//
//  SettingViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit
import MessageUI
import StoreKit
import AcknowList

import SnapKit

enum SettingList: String, CaseIterable {
    case appInfo = "앱 소개글"
    case appEvaluation = "리뷰 남기기"
    case appInquiry = "문의하기"
    case backupAndRecovery = "백업 / 복구"
    case versionInfo = "버전 정보"
    case openSource = "오픈소스 라이선스"
    case addCategory = "카테고리 추가"
}

final class SettingViewController: BaseViewController {
    
    let settingList: [SettingList] = [.appEvaluation, .appInfo, .appInquiry, .backupAndRecovery, .versionInfo, .openSource, .addCategory]
    
    private lazy var settingTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reusableIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func configureUI() {
        view.addSubview(settingTableView)
        
        navigationItem.title = "설정"
    }
    
    override func setConstraints() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.settingLabel.text = settingList[indexPath.row].rawValue
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = settingList[indexPath.row]
        
        var selectedVC: UIViewController?
        
        switch cell {
        case .appInfo: break
        case .appEvaluation:
            if #available(iOS 14.0, *) {
                guard let scene = UIApplication
                    .shared
                    .connectedScenes
                    .first(where: {
                        $0.activationState == .foregroundActive
                    }) as? UIWindowScene else { return }
                SKStoreReviewController.requestReview(in: scene)
            } else {
                SKStoreReviewController.requestReview()
            }
        case .appInquiry:
            sendMail()
        case .backupAndRecovery: selectedVC = BackupViewController()
        case .versionInfo: break
        case .openSource:
            guard let url = Bundle.main.url(forResource: "Package", withExtension: "resolved"),
                  let data = try? Data(contentsOf: url),
                  let acknowList = try? AcknowPackageDecoder().decode(from: data) else {
                return
            }
            
            let vc = AcknowListViewController()
            vc.acknowledgements = acknowList.acknowledgements
            transition(vc, transitionStyle: .push)
        case .addCategory: selectedVC = CategoryViewController()
        }
        
        if let selectedVC = selectedVC {
            transition(selectedVC, transitionStyle: .push)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SettingViewController : MFMailComposeViewControllerDelegate {
    
    private func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            //메일 보내기
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["wodyddml2@gmail.com"])
            mail.setSubject("아맛다 문의사항 -")
            mail.mailComposeDelegate = self
            self.present(mail, animated: true)
            
        } else {
            showCautionAlert(title: "메일 등록을 해주시거나 wodyddml2@gmail.com으로 문의주세요.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // mail view가 떴을때 정상적으로 보내졌다. 실패했다고 Toast 띄워줄 수 있음
        // 어떤식으로 대응 할 수 있을지 생각해보기
        switch result {
        case .cancelled:
            showCautionAlert(title: "메일 전송을 취소했습니다.")
         
        case .failed:
            showCautionAlert(title: "메일 전송을 실패했습니다.")
        case .saved: //임시저장
            showCautionAlert(title: "메일을 임시 저장했습니다.")
        case .sent: // 보내짐
            showCautionAlert(title: "메일이 전송되었습니다.")
        @unknown default:
            fatalError()
        }
        
        controller.dismiss(animated: true)
    }
}
