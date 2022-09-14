//
//  FilterViewController.swift
//  Food
//
//  Created by J on 2022/09/15.
//

import UIKit

class FilterViewController: BaseViewController {
    
   let mainView = FilterView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configureUI() {
        mainView.metropolitanCityTableView.delegate = self
        mainView.metropolitanCityTableView.dataSource = self
        mainView.metropolitanCityTableView.register(MetropolitanCityTableViewCell.self, forCellReuseIdentifier: MetropolitanCityTableViewCell.reusableIdentifier)
        
        mainView.cityTableView.delegate = self
        mainView.cityTableView.dataSource = self
        mainView.cityTableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reusableIdentifier)
    }


}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == mainView.metropolitanCityTableView ? 10 : 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainView.metropolitanCityTableView, let cell = tableView.dequeueReusableCell(withIdentifier: MetropolitanCityTableViewCell.reusableIdentifier, for: indexPath) as? MetropolitanCityTableViewCell {
            
            return cell
            
        } else if tableView == mainView.cityTableView, let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reusableIdentifier, for: indexPath) as? CityTableViewCell {
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}
