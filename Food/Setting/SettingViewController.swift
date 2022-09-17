//
//  SettingViewController.swift
//  Food
//
//  Created by J on 2022/09/11.
//

import UIKit

import SnapKit

class SettingViewController: BaseViewController {
    
    let settingArr: [String] = ["앱 소개글", "앱 평가하기", "백업 / 복구", "버전 정보"]
    
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
        return settingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.settingLabel.text = settingArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
