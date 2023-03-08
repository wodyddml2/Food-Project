//
//  SubMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit

import RealmSwift
import RxSwift
import RxCocoa

final class SubMemoViewController: BaseViewController {
    
    private let repository = UserMemoListRepository()
    let viewModel = SubMemoViewModel()
    var disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.showsVerticalScrollIndicator = false
        view.register(SubMemoCollectionViewCell.self, forCellWithReuseIdentifier: SubMemoCollectionViewCell.reusableIdentifier)
        return view
    }()
    
    let plusButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: SubMemoViewController.self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filterButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "slider.horizontal.3"), primaryAction: nil, menu: filterButtonClicked())
        
        navigationItem.rightBarButtonItems = [plusButton, filterButton]
    }
    
    override func configureUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = viewModel.categoryKey == nil ? "메모" : viewModel.category
        navigationController?.navigationBar.tintColor = .black
        disposeBag = DisposeBag()
        bindViewModel()
        viewModel.fetch()
    }
}

extension SubMemoViewController {
    private func filterAction(fetchRate: Results<UserMemo>, fetchVisit: Results<UserMemo>, fetchRecentDate: Results<UserMemo>) -> UIMenu {
        let rate = UIAction(title: "별점순", image: UIImage(systemName: "star.fill")) {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.tasks.onNext(fetchRate)
        }
        
        let visit = UIAction(title: "방문순", image: UIImage(systemName: "person.3.fill")) {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.tasks.onNext(fetchVisit)
        }
        
        let recentDate = UIAction(title: "최신순", image: UIImage(systemName: "tray.and.arrow.down.fill")) {[weak self] _ in
            guard let self = self else {return}
            self.viewModel.tasks.onNext(fetchRecentDate)
        }
        let menu = UIMenu(title: "원하는 방식으로 정렬해주세요.", options: .displayInline, children: [recentDate, rate, visit])
        
        return menu
    }
    
    private func filterButtonClicked() -> UIMenu {
        if viewModel.category == nil {
            return filterAction(
                fetchRate: repository.fetchSort(sort: "storeRate"),
                fetchVisit: repository.fetchSort(sort: "storeVisit"),
                fetchRecentDate: repository.fetchSort(sort: "storeDate")
            )
        } else {
            guard let categoryKey = self.viewModel.categoryKey else {
                return UIMenu()
            }
            return filterAction(
                fetchRate: repository.fetchCategorySort(sort: "storeRate", category: categoryKey),
                fetchVisit: repository.fetchCategorySort(sort: "storeVisit", category: categoryKey),
                fetchRecentDate: repository.fetchCategorySort(sort: "storeDate", category: categoryKey)
            )
        }
    }
}

extension SubMemoViewController {
    func bindViewModel() {
        plusButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                let viewController = WriteMemoViewController()
                if vc.viewModel.categoryKey != nil {
                    viewController.categoryKey = vc.viewModel.categoryKey
                    viewController.memoCheck = true
                }
                vc.transition(viewController, transitionStyle: .presentFullNavigation)
            }
            .disposed(by: disposeBag)

        viewModel.tasks
            .bind(to: collectionView.rx.items(cellIdentifier: SubMemoCollectionViewCell.reusableIdentifier, cellType: SubMemoCollectionViewCell.self)) { index, info, cell in
                cell.storeNameLabel.text = info.storeName
                cell.storeVisitLabel.text = "\(info.storeVisit)번 방문"
                cell.storeRateLabel.text = "\(info.storeRate)"
                cell.storeLocationLabel.text = info.storeAdress
                
                cell.memoImageView.image = DocumentManager.shared.loadImageFromDocument(fileName: "\(info.objectId).jpg")
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(UserMemo.self)
            .withUnretained(self)
            .bind { vc, info in
                let viewCotroller = WriteMemoViewController()
                viewCotroller.task = info
                
                if vc.viewModel.categoryKey != nil {
                    viewCotroller.categoryKey = vc.viewModel.categoryKey
                    viewCotroller.memoCheck = true
                }
                vc.transition(viewCotroller, transitionStyle: .presentFullNavigation)
            }
            .disposed(by: disposeBag)
    }
}

extension SubMemoViewController: UICollectionViewDelegate {
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 1.3
        
        layout.itemSize = CGSize(width: width / 1.7, height: width / 1.2)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        return layout
    }
}
