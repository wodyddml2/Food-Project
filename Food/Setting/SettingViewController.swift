//
//  SettingViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

import SnapKit

enum SettingList: String, CaseIterable {
    case appInfo = "앱 소개글"
    case appEvaluation = "앱 평가하기"
    case backupAndRecovery = "백업 / 복구"
    case versionInfo = "버전 정보"
    case openSource = "오픈소스 라이선스"
}

final class SettingViewController: BaseViewController {
    
    let settingList: [SettingList] = [.appEvaluation, .appInfo, .backupAndRecovery, .versionInfo, .openSource]
    
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
        case .appEvaluation: break
        case .backupAndRecovery: selectedVC = BackupViewController()
        case .versionInfo: break
        case .openSource: break
        }
        
        if let selectedVC = selectedVC {
            transition(selectedVC, transitionStyle: .push)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
