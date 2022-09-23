import UIKit

import SnapKit
import Zip


class BackupViewController: BaseViewController {

    let repository = UserMemoListRepository()
    
    let documentManager = DocumentManager()
    
    lazy var tableView: UITableView = {
       let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(BackupTableViewCell.self, forCellReuseIdentifier: BackupTableViewCell.reusableIdentifier)
        return view
    }()
    
    var backupList: [String] = []
    var backupFileSize: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메인스레드에서 시간 지연
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//
//        }
        
        
        fetchZipFile()
    }
    func fetchZipFile() {
        documentManager.fetchDocumentZipFile { list, size in
            self.backupList = list
            guard let size = size else {
                return
            }
            self.backupFileSize = size.map { fileSize in
                String(format: "%.1f", fileSize / 1000)
            }
        }
      
    }
    
    
    
    override func configureUI() {
        view.addSubview(tableView)
        tableView.rowHeight = 60
        
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        let recoveryButton = UIBarButtonItem(title: "복구", style: .plain, target: self, action: #selector(recoveryButtonClicked))
        
        navigationItem.rightBarButtonItems = [backupButton,recoveryButton]
    }
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func backupButtonClicked() {
        let currentTime = Date()
        
        var urlPaths = [URL]()
        
        do {
            try repository.saveEncodedJsonToDocument()
        } catch {
            print("error")
        }
        
        // 도큐먼트 위치에 백업할 파일이 있는지 확인
        guard let path = documentManager.documentDirectoryPath(), let imageFile = documentManager.ImageDirectoryPath() else {
            showCautionAlert(title: "Document 위치에 오류가 있습니다.")
            return
        }
      
        // realmFile 경로 가져오기
        let realmFile = path.appendingPathComponent("realm.json") // realm file이 없을 수 있음
        
        // realm 파일이 있는지 없는지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path), FileManager.default.fileExists(atPath: imageFile.path) else {
            showCautionAlert(title: "백업할 파일이 없습니다.")
            return
        }
        // 파일의 url 배열에 담아준다.
        urlPaths.append(contentsOf: [realmFile, imageFile])
        // 백업 파일 압축: URL
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "Memo_\(currentTime)")
            print("Archive Location\(zipFilePath)")
            showActivityViewController(date: currentTime)
            fetchZipFile()
            tableView.reloadData()
        } catch {
            showCautionAlert(title: "압축 실패!!")
        }
        
        
        
    }
    // ActivityViewController
    func showActivityViewController(date: Date) {
        guard let path = documentManager.documentDirectoryPath() else {
            showCautionAlert(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        // zipFile 경로 가져오기
        let backupFileURL = path.appendingPathComponent("Memo_\(date).zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc private func recoveryButtonClicked() {
        // 파일 앱 불러오기
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // document에 여러 파일을 가져오지 못하게 false 해줌
        self.present(documentPicker, animated: true)
    }

}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return backupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.reusableIdentifier) as? BackupTableViewCell else {
            return UITableViewCell()
        }
        cell.fileNameLabel.text = backupList[indexPath.row]
        cell.fileSizeLabel.text = "\(backupFileSize[indexPath.row])KB"
        return cell
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
        guard let path = documentManager.documentDirectoryPath() else {
            showCautionAlert(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        // lastPathComponent는 파일이름과 확장자를 가져온다.
        // 압축파일의 경로를 가져온다.
        let sandBoxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        if backupList.contains(sandBoxFileURL.lastPathComponent) {
            if FileManager.default.fileExists(atPath: sandBoxFileURL.path) {
                let fileURL = path.appendingPathComponent(sandBoxFileURL.lastPathComponent) // 폴더 생성, 폴더 안에 파일 저장 공부 - 이미지들같은 경우
                
                do {
                    try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                        print("progress: \(progress)")
                    }, fileOutputHandler: { unzippedFile in
                        print("unZippedFile: \(unzippedFile)")
                        
                        
                    })
                    
                    try self.repository.overwriteRealm()
                    
                    self.showCautionAlert(title: "복구 완료~")
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
                        self.showCautionAlert(title: "복구 완료~")
                    })
                    
                } catch {
                    showCautionAlert(title: "압축 해제에 실패했습니다.")
                }
            }
        } else {
            showCautionAlert(title: "선택한 파일은 복구할 수 없습니다.")
        }
        
        
    }
}
// json으로 데이터를 만들어서 백/복이 깔끔 마이그레이션 걱정 덜한다. 좀 더 적합 json을 default.realm에 추가하고 scenedelegate로 root뷰를 바꾸는 것으로 가능
// 복구 위치를 바꿔준다. 그 후 기존 렘을 없애주고 그 위치에 다시 넣어준다. 비추
// 기존의 렘데이터가 남아있어서 문제가 생긴다. sceneDelegate는
