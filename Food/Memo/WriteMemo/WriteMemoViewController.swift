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

protocol UserMemoDelegate {
    func searchInfoMemo(storeName: String, storeAdress: String)
}

final class WriteMemoViewController: BaseViewController {
    
    private let mainView = WriteMemoView()
    
    let repository = UserMemoListRepository()
    let documentManager = DocumentManager()
    
    let categoryInfo = CategoryInfo()
    
    var task: UserMemo?
    var delegate: UserMemoDelegate?
    
    var storeData: StoreInfo?
    
    var categoryKey: Int?
    var sameTask: Int?
    
    var memoCheck: Bool = false
    
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
        
        mainView.storeNameField.delegate = self
        mainView.storeLocationTextView.delegate = self
        mainView.storeReviewTextView.delegate = self
        
        
        if categoryKey == nil || task != nil {
            mainView.categoryTextField.tintColor = .clear
            setPickerView()
            dismissPickerView()
        } else {
            mainView.categoryTextField.text = categoryInfo.categoryInfo[categoryKey ?? 0]
            mainView.categoryTextField.isEnabled = false
        }
        
    }
    
    
    override func navigationSetup() {
        navigationController?.navigationBar.tintColor = .black
        
        if task == nil {
            
            navigationItem.title = "작성"
            let saveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClicked))
            let galleryButton = UIBarButtonItem(image: UIImage(systemName: "photo"), primaryAction: nil, menu: menuImageButtonClicked())
            navigationItem.rightBarButtonItems = [saveButton, galleryButton]
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButtonClicked))
            
        } else {
            
            navigationItem.title = "수정"
            let resaveButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(resaveButtonClicked))
            let galleryButton = UIBarButtonItem(image: UIImage(systemName: "photo"), primaryAction: nil, menu: menuImageButtonClicked())
            
            navigationItem.rightBarButtonItems = [resaveButton, galleryButton]
            
            let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonClicked))
            let backButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(backButtonClicked))
            
            navigationItem.leftBarButtonItems = [backButton, deleteButton]
        }
    }
    
    @objc func saveButtonClicked() {
        if categoryKey != nil && mainView.storeNameField.text != nil && mainView.storeLocationTextView.textColor != .lightGray {
            
            sameTask = repository.fetchSameData(storeAdress: mainView.storeLocationTextView.text ?? "s")

            showMemoAlert(title: "메모를 저장하시겠습니까?") { _ in
                if self.mainView.storeReviewTextView.textColor == .lightGray {
                    self.mainView.storeReviewTextView.text = nil
                }
                let task = UserMemo(storeName: self.mainView.storeNameField.text ?? "없음", storeAdress: self.mainView.storeLocationTextView.text ?? "없음", storeRate: self.mainView.currentRate, storeVisit: self.repository.fetchSameData(storeAdress: self.mainView.storeLocationTextView.text ?? "s") + 1, storeReview: self.mainView.storeReviewTextView.text ?? "없음",storeCategory: self.categoryKey ?? 0, storeDate: Date())
                
                self.repository.addRealm(item: task)
                
                if let image = UIImage(named: "dishes") {
                    self.documentManager.saveImageToDocument(fileName: "\(task.objectId).jpg", image: (self.mainView.memoImageView.image ?? image))
                }
                
                self.dismiss(animated: true)
            }
        } else if categoryKey == nil {
            showCautionAlert(title: "주의", message: "카테고리를 선택해주세요!")
        } else {
            showCautionAlert(title: "주의", message: "각 작성란에 최소 한 글자 이상 적어주세요!!")
        }
        
        
    }
    
    @objc func resaveButtonClicked() {
        
        if let task = task {
            if mainView.storeNameField.text != nil && mainView.storeLocationTextView.textColor != .lightGray  {
                
                showMemoAlert(title: "메모를 수정하시겠습니까?") { _ in
                    if self.mainView.storeReviewTextView.textColor == .lightGray {
                        self.mainView.storeReviewTextView.text = nil
                    }
                    self.repository.removeImageFromDocument(fileName: "\(task.objectId).jpg" )
                    self.repository.fetchUpdate {
                        task.storeName = self.mainView.storeNameField.text ?? "없음"
                        task.storeAdress = self.mainView.storeLocationTextView.text ?? "없음"
                        task.storeCategory = self.categoryKey ?? 0
                        task.storeRate = self.mainView.currentRate
                        task.storeReview = self.mainView.storeReviewTextView.text ?? "없음"
                    }
                    if let image = UIImage(named: "dishes") {
                        self.documentManager.saveImageToDocument(fileName: "\(task.objectId).jpg", image: (self.mainView.memoImageView.image ?? image))
                    }
                    
                    self.dismiss(animated: true)
                }
            } else {
                showCautionAlert(title: "주의", message: "각 작성란에 최소 한 글자 이상 적어주세요!!")
            }
        }
        
        
        
        
    }
    @objc func deleteButtonClicked() {
        showMemoAlert(title: "메모를 삭제하시겠습니까?",button: "삭제") { _ in
            if let task = self.task {
                self.repository.deleteRecord(item: task)
            }
            
            
            self.dismiss(animated: true)
        }
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true)
    }
    
    override func configureUI() {
        if let task = task {
            mainView.storeNameField.text = task.storeName
            mainView.storeLocationTextView.text = task.storeAdress
            mainView.storeReviewTextView.text = task.storeReview
            mainView.currentRate = task.storeRate
            mainView.categoryTextField.text = categoryInfo.categoryInfo[task.storeCategory]
            mainView.storeLocationTextView.textColor = .black
            mainView.storeReviewTextView.textColor = .black
            
            if mainView.currentRate > 0 {
                mainView.rateUpdate(tag: mainView.currentRate - 1)
            }
            mainView.memoImageView.image = documentManager.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        }
        mainView.storeSearchButton.addTarget(self, action: #selector(storeSearchButtonClicked), for: .touchUpInside)
    }
    
    @objc func storeSearchButtonClicked() {
        let vc = SearchViewController()
        vc.memoCheck = true
        vc.delegate = self
        transition(vc, transitionStyle: .presentNavigation)
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

extension WriteMemoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryInfo.categoryInfo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryInfo.categoryInfo[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mainView.categoryTextField.text = categoryInfo.categoryInfo[row]
        categoryKey = row
        
    }
    
    func setPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        mainView.categoryTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let ChoiceButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(ChoiceButtonClicked))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        ChoiceButton.tintColor = .black
        toolBar.setItems([flexSpace ,ChoiceButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        mainView.categoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func ChoiceButtonClicked() {
        mainView.endEditing(true)
    }
}

extension WriteMemoViewController: UserMemoDelegate {
    func searchInfoMemo(storeName: String, storeAdress: String) {
        mainView.storeNameField.text = storeName
        mainView.storeLocationTextView.text = storeAdress
        mainView.storeLocationTextView.textColor = .black
    }
}
