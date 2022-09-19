//
//  WriteMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit
import PhotosUI

import RealmSwift

enum TextViewPlaceholder: String {
    case locationPlaceholder = "음식점 주소를 적어주세요"
    case reviewPlaceholder = "음식점에 대한 리뷰를 남겨주세요"
}

final class WriteMemoViewController: BaseViewController {
    
    private let mainView = WriteMemoView()
    
    let repository = UserMemoListRepository()
    
    var tasks: Results<UserMemo>?

    var categoryKey: Int?
    
    lazy var imagePicker: UIImagePickerController = {
        let view = UIImagePickerController()
        view.delegate = self
        return view
    }()
    
    let configuration: PHPickerConfiguration = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0
        return configuration
    }()
    
    lazy var phPicker: PHPickerViewController = {
        let view = PHPickerViewController(configuration: configuration)
        view.delegate = self
        return view
    }()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = repository.fetchCategory(category: categoryKey ?? 0)
       
        mainView.storeNameField.delegate = self
        mainView.storeLocationTextView.delegate = self
        mainView.storeReviewTextView.delegate = self
    }
    
    override func navigationSetup() {
        
        if ((tasks?.isEmpty) == nil) {
            navigationItem.title = "메모 작성"
            let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
            let galleryButton = UIBarButtonItem(image: UIImage(systemName: "photo"), primaryAction: nil, menu: menuImageButtonClicked())
            navigationItem.rightBarButtonItems = [saveButton, galleryButton]
            
        } else {
            navigationItem.title = "메모 수정"
            let resaveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(resaveButtonClicked))
            let galleryButton = UIBarButtonItem(image: UIImage(systemName: "photo"), primaryAction: nil, menu: menuImageButtonClicked())
            
            navigationItem.rightBarButtonItems = [resaveButton, galleryButton]
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonClicked))
        }
    }
    
    @objc func saveButtonClicked() {

        showMemoAlert(title: "메모를 저장하시겠습니까?") { _ in
            let task = UserMemo(storeName: self.mainView.storeNameField.text ?? "없음", storeAdress: self.mainView.storeLocationTextView.text ?? "없음", storeRate: self.mainView.currentRate, storeVisit: self.mainView.visitCount, storeReview: self.mainView.storeReviewTextView.text ?? "없음",storeCategory: self.categoryKey ?? 0)
            
            self.repository.addRealm(item: task)
            self.dismiss(animated: true)
        }
    }
    @objc func galleryButtonClicked() {
        
    }
    @objc func resaveButtonClicked() {
        showMemoAlert(title: "메모를 수정하시겠습니까?") { _ in
            
        }
    }
    @objc func deleteButtonClicked() {
        showMemoAlert(title: "메모를 삭제하시겠습니까?") { _ in
            
        }
    }
    

    override func configureUI() {
        if tasks?.isEmpty == true {
            
        }
        
      
    }
    
    func menuImageButtonClicked() -> UIMenu {
        let camera = UIAction(title: "카메라", image: UIImage(systemName: "camera")) { _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true)
        }
        let gallery = UIAction(title: "갤러리", image: UIImage(systemName: "photo.on.rectangle.angled")) { _ in
            self.present(self.phPicker, animated: true)
        }
        let menu = UIMenu(title: "이미지를 가져올 경로를 정해주세요.", options: .displayInline, children: [camera, gallery])
        
        return menu
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
}
extension WriteMemoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            mainView.memoImageView.image = image
            dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

extension WriteMemoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.mainView.memoImageView.image = image as? UIImage
                }
            }
        }
    }

}

extension WriteMemoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = mainView.storeNameField.text else {
            return false
        }
        guard let range = Range(range, in: text) else { return false }
        
        let changeText = text.replacingCharacters(in: range, with: string)
        
        return changeText.count <= 17
    }
}

extension WriteMemoViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == mainView.storeLocationTextView {
            if text == "\n" {
                textView.resignFirstResponder()
            }
            guard let currentText = mainView.storeLocationTextView.text else {
                return false
            }
            guard let range = Range(range, in: currentText) else { return false }
            
            let changeText = currentText.replacingCharacters(in: range, with: text)
            
            return changeText.count <= 35
        } else {
            return true
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == mainView.storeReviewTextView {
            setKeyboardObserver()
            navigationController?.navigationBar.tintColor = .clear
        }

        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == mainView.storeLocationTextView {
            if mainView.storeLocationTextView.textColor == .lightGray {
                mainView.storeLocationTextView.text = nil
                mainView.storeLocationTextView.textColor = .black
            }
        } else {
            if mainView.storeReviewTextView.textColor == .lightGray {
                mainView.storeReviewTextView.text = nil
                mainView.storeReviewTextView.textColor = .black
            }
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == mainView.storeLocationTextView {
            if mainView.storeLocationTextView.text.isEmpty {
                mainView.storeLocationTextView.text = TextViewPlaceholder.locationPlaceholder.rawValue
                mainView.storeLocationTextView.textColor = .lightGray
            }
        } else {
            if mainView.storeReviewTextView.text.isEmpty {
                mainView.storeReviewTextView.text = TextViewPlaceholder.reviewPlaceholder.rawValue
                mainView.storeReviewTextView.textColor = .lightGray
            }
            navigationController?.navigationBar.tintColor = .black
            removeKeyboardObserver()
        }
    }
    
   
}
