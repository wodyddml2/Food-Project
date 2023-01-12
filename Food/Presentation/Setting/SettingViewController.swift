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

final class SettingViewController: BaseViewController {
    
    enum SettingList: String, CaseIterable {
        case addCategory = "카테고리 추가"
        case backup = "백업 / 복구"
        case appEvaluation = "리뷰 남기기"
        case appInquiry = "문의하기"
        case versionInfo = "버전 정보"
        case openSource = "오픈소스 라이선스"
    }
    
    private let infoList: [SettingList] = [ .appEvaluation, .appInquiry, .openSource, .versionInfo]
    
    private let settingList: [SettingList] = [.addCategory, .backup]
    
    private var dataSource: UITableViewDiffableDataSource<Int, SettingList>?
    
    private lazy var settingTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reusableIdentifier)
        view.register(SettingTableHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingTableHeaderView.reusableIdentifier)
        view.showsVerticalScrollIndicator = false
        view.bounces = false
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
        configureDataSource()
    }
    
    override func setConstraints() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SettingViewController {
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: settingTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            if indexPath.section == 0 {
                cell.settingLabel.text = self.settingList[indexPath.row].rawValue
            } else {
                cell.settingLabel.text = self.infoList[indexPath.row].rawValue
            }
            return cell
        })
        
        settingTableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, SettingList>()
        snapshot.appendSections([0, 1])
        snapshot.appendItems(settingList, toSection: 0)
        snapshot.appendItems(infoList, toSection: 1)
        dataSource?.apply(snapshot)
    }
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let dataSource = dataSource else {return}
        guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
        
        var selectedVC: UIViewController?
       
        if indexPath.section == 0 {
            switch item {
            case .addCategory: selectedVC = CategoryViewController()
            case .backup: selectedVC =
                BackupViewController()
            case .appEvaluation:
                break
            case .appInquiry:
                break
            case .versionInfo:
                break
            case .openSource:
                break
            }
        } else {
            switch item {
            case .appEvaluation:
                moveToReview()
            case .appInquiry:
                sendMail()
            case .versionInfo:
                showCautionAlert(title: "Version 1.1.3")
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
            case .addCategory:
                break
            case .backup:
                break
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
    
    private func moveToReview() {
        if let reviewURL = URL(string: "itms-apps://itunes.apple.com/app/itunes-u/id\(1645004547)?ls=1&mt=8&action=write-review"), UIApplication.shared.canOpenURL(reviewURL) {
            UIApplication.shared.open(reviewURL, options: [:], completionHandler: nil)
        }
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
