import UIKit

import SnapKit
import Zip

final class BackupViewController: BaseViewController {
    
    private let repository = UserMemoListRepository()
    private let categoryRepository = UserCategoryRepository()
    private let wishlistRepository = UserWishListRepository()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(BackupTableViewCell.self, forCellReuseIdentifier: BackupTableViewCell.reusableIdentifier)
        view.rowHeight = 50
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm EE"
        return formatter
    }()
    
    private var backupList: [DocumentFile] = []
    private var backupFileSize: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchZipFile()
    }
    private func fetchZipFile() {
        DocumentManager.shared.fetchDocumentZipFile { list, size in
            
            self.backupList = list
            
            guard let size = size else {
                return
            }
            self.backupFileSize = size.map { fileSize in
                String(format: "%.1f", fileSize / 1000000)
            }
        }
    }
    
    
    override func configureUI() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(showActionSheet))
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func showActionSheet() {
        let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let backup = UIAlertAction(title: "백업하기", style: .default) { _ in
            self.backupButtonClicked()
        }
        
        let fileApp = UIAlertAction(title: "파일 앱에서 복구하기", style: .default) { _ in
            self.fileAppButtonClicked()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        [backup, fileApp, cancel].forEach {
            action.addAction($0)
        }
        
        present(action, animated: true)
    }
    
    private func backupButtonClicked() {
        
        let currentTime = formatter.string(from: Date())
        
        var urlPaths = [URL]()
        
        do {
            try repository.saveEncodedJsonToDocument()
            try categoryRepository.saveEncodedJsonToDocument()
            try wishlistRepository.saveEncodedJsonToDocument()
        } catch {
            print("error")
        }
        
        // 도큐먼트 위치에 백업할 파일이 있는지 확인
        guard let path = DocumentManager.shared.documentDirectoryPath(), let imageFile = DocumentManager.shared.ImageDirectoryPath() else {
            showCautionAlert(title: "Document 위치에 오류가 있습니다.")
            return
        }
        
        // realmFile 경로 가져오기
        let memoFile = path.appendingPathComponent("memo.json")
        let categoryFile = path.appendingPathComponent("category.json")
        let wishlistFile = path.appendingPathComponent("wishlist.json")
        
        
        // realm 파일이 있는지 없는지 확인
        guard FileManager.default.fileExists(atPath: memoFile.path), FileManager.default.fileExists(atPath: imageFile.path), FileManager.default.fileExists(atPath: categoryFile.path), FileManager.default.fileExists(atPath: wishlistFile.path) else {
            showCautionAlert(title: "백업할 파일이 없습니다.")
            return
        }
        // 파일의 url 배열에 담아준다.
        urlPaths.append(contentsOf: [memoFile, categoryFile, wishlistFile, imageFile])
        // 백업 파일 압축: URL
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: currentTime)
            print("Archive Location\(zipFilePath)")
            showActivityViewController(date: currentTime)
            fetchZipFile()
            tableView.reloadData()
        } catch {
            showCautionAlert(title: "압축 실패")
        }
    }
    
    // ActivityViewController
    private func showActivityViewController(date: String) {
        guard let path = DocumentManager.shared.documentDirectoryPath() else {
            showCautionAlert(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        // zipFile 경로 가져오기
        let backupFileURL = path.appendingPathComponent("\(date).zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    private func recoveryCellClicked(zipfile: String) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = TabViewController()
        
        guard let path = DocumentManager.shared.documentDirectoryPath() else {
            showCautionAlert(title: "Document 위치에 오류가 있습니다.")
            return
        }
        
        let zipFile = path.appendingPathComponent(zipfile)
        
        do {
            try Zip.unzipFile(zipFile, destination: path, overwrite: true, password: nil, progress: { progress in
                print("progress: \(progress)")
            }, fileOutputHandler: { unzippedFile in
                print("unZippedFile: \(unzippedFile)")
            })
            
            try self.repository.overwriteRealm()
            try self.wishlistRepository.overwriteRealm()
            try self.categoryRepository.overwriteRealm()
            
            self.showCautionAlert(title: "복구 완료")
            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
            
        } catch {
            showCautionAlert(title: "압축 해제에 실패했습니다.")
        }
        
    }
    
    private func fileAppButtonClicked() {
        // 파일 앱 불러오기
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
    
}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if backupList.isEmpty {
            return 1
        } else {
            return backupList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.reusableIdentifier) as? BackupTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        if backupList.isEmpty {
            tableView.separatorStyle = .none
            tableView.rowHeight = 300
            cell.fileNameLabel.numberOfLines = 0
            cell.fileNameLabel.textAlignment = .center
            
            cell.fileNameLabel.text = """
            복구할 데이터가 없습니다.
            
            상단의 버튼을 이용하여
            
            현재 데이터를 백업해주세요 :)
            """
            cell.fileSizeLabel.text = ""
            cell.fileNameLabel.snp.remakeConstraints { make in
                make.center.equalTo(cell)
            }
            
        } else {
            tableView.separatorStyle = .singleLine
            tableView.rowHeight = 50
            cell.fileNameLabel.numberOfLines = 1
            cell.fileNameLabel.textAlignment = .left
            cell.fileNameLabel.text = backupList[indexPath.row].title
            cell.fileSizeLabel.text = "\(backupFileSize[indexPath.row])MB"
            
            cell.fileNameLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(cell)
                make.leading.equalTo(16)
                make.trailing.lessThanOrEqualTo(cell.fileSizeLabel.snp.leading).offset(-8)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !backupList.isEmpty {
            let file = backupList[indexPath.row].title
            
            showMemoAlert(title: "해당 파일을 복구하시겠습니까?", button: "확인") { [weak self] _ in
                guard let self = self else { return }
                self.recoveryCellClicked(zipfile: file)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            
            guard let path = DocumentManager.shared.documentDirectoryPath() else {
                self.showCautionAlert(title: "Document 위치에 오류가 있습니다.")
                return
            }
            
            let zipFile = path.appendingPathComponent(self.backupList[indexPath.row].title)
            
            do {
                try FileManager.default.removeItem(at: zipFile)
                self.fetchZipFile()
                self.tableView.reloadData()
            } catch {
                self.showCautionAlert(title: "백업 파일 삭제에 실패했습니다")
            }
            
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        
        if backupList.isEmpty {
            return nil
        } else {
            return UISwipeActionsConfiguration(actions: [delete])
        }
        
    }
}

extension BackupViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = TabViewController()
        
        guard let selectedFileURL = urls.first else {
            showCautionAlert(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        guard let path = DocumentManager.shared.documentDirectoryPath() else {
            showCautionAlert(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        // lastPathComponent는 파일이름과 확장자를 가져온다.
        // 압축파일의 경로를 가져온다.
        let sandBoxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        if backupList.contains(where: {
            $0.title == sandBoxFileURL.lastPathComponent
        }) {
            if FileManager.default.fileExists(atPath: sandBoxFileURL.path) {
                let fileURL = path.appendingPathComponent(sandBoxFileURL.lastPathComponent) // 폴더 생성, 폴더 안에 파일 저장 공부 - 이미지들같은 경우
                
                do {
                    try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                        print("progress: \(progress)")
                    }, fileOutputHandler: { unzippedFile in
                        print("unZippedFile: \(unzippedFile)")
                    })
                    
                    try self.repository.overwriteRealm()
                    try self.wishlistRepository.overwriteRealm()
                    try self.categoryRepository.overwriteRealm()
                    
                    self.showCautionAlert(title: "복구 완료")
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
                    // 앱을 껏다 켜야 복구가 된 것을 볼 수 있는데 해결하기 위해 window rootView를 바꿔줌
                } catch {
                    showCautionAlert(title: "압축 해제에 실패했습니다.")
                }
            } else {
                do {
                    // 파일 앱의 zip -> 도큐먼트 폴더에 복사
                    try FileManager.default.copyItem(at: selectedFileURL, to: sandBoxFileURL)
                    
                    let fileURL = path.appendingPathComponent(sandBoxFileURL.lastPathComponent)
                    
                    try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                        print("progress: \(progress)")
                    }, fileOutputHandler: { unzippedFile in
                        print("unZippedFile: \(unzippedFile)")
                        
                    })
                    
                    try self.repository.overwriteRealm()
                    try self.wishlistRepository.overwriteRealm()
                    try self.categoryRepository.overwriteRealm()
                    
                    self.showCautionAlert(title: "복구 완료")
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
                    
                } catch {
                    showCautionAlert(title: "압축 해제에 실패했습니다.")
                }
            }
        } else {
            showCautionAlert(title: "선택한 파일은 복구할 수 없습니다.")
        }
    }
    
    
}

