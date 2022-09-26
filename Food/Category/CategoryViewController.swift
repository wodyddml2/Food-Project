//
//  CategoryViewController.swift
//  Food
//
//  Created by J on 2022/09/27.
//

import UIKit

import RealmSwift

class CategoryViewController: BaseViewController {

    lazy var tableView: UITableView = {
       let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 50
        view.keyboardDismissMode = .onDrag
        view.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reusableIdentifier)
        return view
    }()
    
    lazy var  categoryTextField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.textAlignment = .center
        view.placeholder = "카테고리 추가"
        view.setBorder(borderWidth: 0.3)
        return view
    }()
    
    let repository = UserCategoryRepository()
    
    var tasks: Results<UserCategory>? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = repository.fecth()
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
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reusableIdentifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
      
        cell.categoryLabel.text = tasks?[indexPath.row].category
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
          
            if let tasks = self.tasks {
                self.repository.deleteRecord(item: tasks[indexPath.row])
            }
            self.tasks = self.repository.fecth()
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }

}

extension CategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let test = UserCategory(category: textField.text ?? "")
        repository.addRealm(item: test)
        tasks = repository.fecth()
        
        textField.resignFirstResponder()
        textField.text = nil
        return true
    }
}
