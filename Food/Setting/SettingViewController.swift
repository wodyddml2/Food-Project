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
    case backupAndRecovery = "백업 / 복구"
    case addCategory = "카테고리 추가"
}

enum InfoList: String, CaseIterable {
    case appEvaluation = "리뷰 남기기"
    case appInquiry = "문의하기"
    case versionInfo = "버전 정보"
    case openSource = "오픈소스 라이선스"
}

final class SettingViewController: BaseViewController {
    
    let infoList: [InfoList] = [ .appEvaluation, .appInquiry, .openSource, .versionInfo]
    
    let settingList: [SettingList] = [.addCategory, .backupAndRecovery]
    
    private lazy var settingTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reusableIdentifier)
        view.register(SettingTableHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingTableHeaderView.reusableIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func configureUI() {
        view.addSubview(settingTableView)
        
        navigationItem.backButtonTitle = ""
        navigationItem.title = "설정"
    }
    
    override func setConstraints() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? settingList.count : infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if indexPath.section == 0 {
            cell.settingLabel.text = settingList[indexPath.row].rawValue
        } else {
            cell.settingLabel.text = infoList[indexPath.row].rawValue
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        var selectedVC: UIViewController?
       
        if indexPath.section == 0 {
            let settingCell = settingList[indexPath.row]
            
            switch settingCell {
            case .backupAndRecovery: showCautionAlert(title: "추후 업데이트 예정!!")
            case .addCategory: selectedVC = CategoryViewController()
            }
        } else {
            let infoCell = infoList[indexPath.row]
            
            switch infoCell {
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
            case .versionInfo:
                showCautionAlert(title: "Version 1.0")
            case .openSource:
                guard let url = Bundle.main.url(forResource: "Package", withExtension: "resolved"),
                      let data = try? Data(contentsOf: url),
                      let acknowList = try? AcknowPackageDecoder().decode(from: data) else {
                    return
                }
                
                let vc = AcknowListViewController()
                let acknow = Acknow(title: "NMapsMap", text: nil, license: nil, repository: nil)
                vc.acknowledgements = acknowList.acknowledgements
                vc.acknowledgements.append(acknow)
                transition(vc, transitionStyle: .push)
            }
        }
        
        if let selectedVC = selectedVC {
            transition(selectedVC, transitionStyle: .push)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingTableHeaderView.reusableIdentifier) as? SettingTableHeaderView else {return nil}
        
        header.headerLabel.text = section == 0 ? "설정" : "정보"
        
        return header
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
        
        // mail view가 떴을때 정상적으로 보내졌다.
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
