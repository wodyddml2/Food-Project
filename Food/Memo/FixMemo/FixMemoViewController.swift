//
//  FixMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/20.
//

import UIKit

class FixMemoViewController: BaseViewController {

    let mainView = FixMemoView()
    
    let documentManager = DocumentManager()
    
    var task: UserMemo?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.storeReviewTextView.isEditable = false
        mainView.storeLocationTextView.isEditable = false
    }
    
    override func configureUI() {
        if let task = task {
            mainView.storeNameLabel.text = task.storeName
            mainView.storeLocationTextView.text = task.storeAdress
            mainView.storeReviewTextView.text = task.storeReview
            mainView.storeVisitLabel.text = "\(task.storeVisit)번 방문"
            mainView.currentRate = task.storeRate
            
            mainView.storeLocationTextView.textColor = .black
            mainView.storeReviewTextView.textColor = .black
            
            if mainView.currentRate > 0 {
                mainView.rateUpdate(tag: mainView.currentRate - 1)
            }
            mainView.memoImageView.image = try documentManager.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        }
    }
   

}
