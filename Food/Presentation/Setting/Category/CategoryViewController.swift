//
//  CategoryViewController.swift
//  Food
//
//  Created by J on 2022/09/27.
//

import UIKit

import RealmSwift

final class CategoryViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.keyboardDismissMode = .onDrag
        view.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reusableIdentifier)
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private lazy var  categoryTextField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.textAlignment = .center
        view.placeholder = "카테고리 추가"
        view.setBorder(borderWidth: 0.3)
        return view
    }()
    
    private let repository = UserMemoListRepository()
    private let categoryRepository = UserCategoryRepository()
    
    private var categoryTasks: Results<UserCategory>? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTasks = categoryRepository.fetch()
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func configureUI() {
        [categoryTextField, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryTasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reusableIdentifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.isHidden = indexPath.row == indexPath.first ? true : false
        
        cell.categoryLabel.text = categoryTasks?[indexPath.row].category
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == indexPath.first ? 0 : 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            if indexPath.row != indexPath.first {
                if let tasks = self.categoryTasks {
                    do {
                        try self.repository.fetchUpdate {
                            self.repository.fetchCategory(category: tasks[indexPath.row].objectId).forEach { memo in
                                guard let task = tasks.first else {return}
                                memo.storeCategory = task.objectId
                            }
                        }
                    } catch {
                        self.showCautionAlert(title: "카테고리 삭제에 실패했습니다.")
                    }
                    
                    do {
                        try self.categoryRepository.deleteRecord(item: tasks[indexPath.row])
                    } catch {
                        self.showCautionAlert(title: "카테고리 삭제에 실패했습니다.")
                    }
                    
                }
                self.categoryTasks = self.categoryRepository.fetch()
            }
            
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}

extension CategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let category = textField.text {
            if category != "" {
                let item = UserCategory(category: category)
                do {
                    try categoryRepository.addRealm(item: item)
                } catch {
                    showCautionAlert(title: "카테고리 추가를 실패했습니다.")
                }
                categoryTasks = categoryRepository.fetch()
            } else {
                showCautionAlert(title: "한글자 이상 입력해주세요!")
            }
        }
        
        textField.text = nil
        return true
    }
}
