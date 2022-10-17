//
//  WriteMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit
import PhotosUI

import RealmSwift
import CropViewController

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
    let categoryRepository = UserCategoryRepository()
    
    var categoryTask: Results<UserCategory>?
    
    var task: UserMemo?
    var delegate: UserMemoDelegate?
    
    var storeData: StoreInfo?
    
    var categoryKey: ObjectId?
    
    var memoCheck: Bool = false
    
    lazy var imagePicker: UIImagePickerController = {
        let view = UIImagePickerController()
        view.delegate = self
        return view
    }()
    
    let configuration: PHPickerConfiguration = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
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
  
    }
    
    override func navigationSetup() {
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.tintColor = .black
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
        if categoryKey != nil && mainView.storeNameField.text != "" && mainView.storeLocationTextView.textColor != .lightGray {

            showMemoAlert(title: "메모를 저장하시겠습니까?") { [weak self] _ in
                guard let self = self else { return }
                if self.mainView.storeReviewTextView.textColor == .lightGray {
                    self.mainView.storeReviewTextView.text = nil
                }
                let task = UserMemo(storeName: self.mainView.storeNameField.text ?? "없음", storeAdress: self.mainView.storeLocationTextView.text ?? "없음", storeRate: self.mainView.currentRate, storeVisit: self.repository.fetchSameData(storeAdress: self.mainView.storeLocationTextView.text ?? "s") + 1, storeReview: self.mainView.storeReviewTextView.text ?? "없음",storeCategory: self.categoryKey!, storeDate: Date())
                
                do {
                    try self.repository.addRealm(item: task)
                } catch {
                    self.showCautionAlert(title: "메모 저장에 실패했습니다.")
                }

                if let image = UIImage(named: "amda") {
                    DocumentManager.shared.saveImageToDocument(fileName: "\(task.objectId).jpg", image: (self.mainView.memoImageView.image ?? image))
                }
                
                self.dismiss(animated: true)
            }
        } else if categoryKey == nil {
            showCautionAlert(title: "주의", message: "카테고리를 선택해주세요!")
        } else {
            showCautionAlert(title: "주의", message: "상호명과 주소란에 최소 한 글자 이상 적어주세요!!")
        }
    }
    
    @objc func resaveButtonClicked() {
        
        if let task = task {
            if mainView.storeNameField.text != ""  && mainView.storeLocationTextView.textColor != .lightGray  {
                
                showMemoAlert(title: "메모를 수정하시겠습니까?") { [weak self] _ in
                    guard let self = self else { return }
                    if self.mainView.storeReviewTextView.textColor == .lightGray {
                        self.mainView.storeReviewTextView.text = nil
                    }
                    self.repository.removeImageFromDocument(fileName: "\(task.objectId).jpg" )
                    do {
                        try self.repository.fetchUpdate {
                            task.storeName = self.mainView.storeNameField.text ?? "없음"
                            task.storeAdress = self.mainView.storeLocationTextView.text ?? "없음"
                            if let categoryKey = self.categoryKey {
                                task.storeCategory = categoryKey
                            }
                            task.storeRate = self.mainView.currentRate
                            task.storeReview = self.mainView.storeReviewTextView.text ?? "없음"
                            task.storeVisit = self.repository.fetchSameData(storeAdress: self.mainView.storeLocationTextView.text ?? "s")
                        }
                    } catch {
                        self.showCautionAlert(title: "메모 수정에 실패했습니다.")
                    }
                    
                    
                    if let image = UIImage(named: "amda") {
                        DocumentManager.shared.saveImageToDocument(fileName: "\(task.objectId).jpg", image: (self.mainView.memoImageView.image ?? image))
                    }
                    
                    self.dismiss(animated: true)
                }
            } else {
                showCautionAlert(title: "주의", message: "상호명과 주소란에 최소 한 글자 이상 적어주세요!!")
            }
        }
        
    }
    @objc func deleteButtonClicked() {
        showMemoAlert(title: "메모를 삭제하시겠습니까?",button: "삭제") { [weak self] _ in
            guard let self = self else { return }
            if let task = self.task {
                do {
                    try self.repository.deleteRecord(item: task)
                } catch {
                    self.showCautionAlert(title: "메모 삭제를 실패했습니다.")
                }
            }

            self.dismiss(animated: true)
        }
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true)
    }
    
    override func configureUI() {
        categoryTask = categoryRepository.fetch()
        
        if categoryKey == nil || task != nil {
            mainView.categoryTextField.tintColor = .clear
            setPickerView()
            dismissPickerView()
        } else {
            mainView.categoryTextField.text = categoryRepository.fetchCategory(category: categoryKey!)[0].category
            mainView.categoryTextField.isEnabled = false
        }
        
        if let task = task {
            mainView.storeNameField.text = task.storeName
            mainView.storeLocationTextView.text = task.storeAdress
            mainView.storeReviewTextView.text = task.storeReview
            mainView.currentRate = task.storeRate
            mainView.categoryTextField.text = categoryRepository.fetchCategory(category: task.storeCategory)[0].category
            mainView.storeLocationTextView.textColor = .black
            mainView.storeReviewTextView.textColor = .black
            
            if mainView.currentRate > 0 {
                mainView.rateUpdate(tag: mainView.currentRate - 1)
            }
            mainView.memoImageView.image = DocumentManager.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
            
            
            storeLocationTextViewHeight(textCount: mainView.storeLocationTextView.text.count)
        }
        
        mainView.storeSearchButton.addTarget(self, action: #selector(storeSearchButtonClicked), for: .touchUpInside)
    }
    
    @objc func storeSearchButtonClicked() {
      
        let vc = SearchViewController()
        vc.viewModel.memoCheck.value = true
        vc.delegate = self
        transition(vc, transitionStyle: .presentNavigation)
    }
    
    func menuImageButtonClicked() -> UIMenu {
        let camera = UIAction(title: "카메라", image: UIImage(systemName: "camera")) { [weak self] _ in
            guard let self = self else {return}
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            switch status {
            case .authorized:
                guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                    self.showCautionAlert(title: "카메라 사용이 불가능합니다.")
                    return
                }
                
                DispatchQueue.main.async {
                    self.imagePicker.sourceType = .camera
                    self.imagePicker.allowsEditing = true
                    self.present(self.imagePicker, animated: true)
                }
                
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] bool in
                    guard let self = self else {return}
                    if bool {
                        DispatchQueue.main.async {
                            self.imagePicker.sourceType = .camera
                            self.imagePicker.allowsEditing = true
                            self.present(self.imagePicker, animated: true)
                        }
                    }
                }
            default:
                self.showRequestServiceAlert(title: "카메라 이용", message: "카메라를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 카메라 권한을 설정해주세요.")
            }
        }
        let gallery = UIAction(title: "갤러리", image: UIImage(systemName: "photo.on.rectangle.angled")) { [weak self] _ in
            guard let self = self else {return}
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

            let crop = CropViewController(image: image)
            
            crop.delegate = self
            crop.doneButtonTitle = "완료"
            crop.cancelButtonTitle = "취소"
            
            self.dismiss(animated: true)
            
            self.present(crop, animated: true)
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
                    
                    guard let image = image as? UIImage else {
                        return
                    }
                    
                    let crop = CropViewController(image: image)
                    
                    crop.delegate = self
                    crop.doneButtonTitle = "완료"
                    crop.cancelButtonTitle = "취소"
                    
                    self.present(crop, animated: true)

                }
            }
        }
    }
    
}

extension WriteMemoViewController: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        mainView.memoImageView.image = image
        self.dismiss(animated: true)
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
    
    func storeLocationTextViewHeight(textCount: Int) {
        if textCount <= 23 {
            mainView.storeLocationTextView.snp.updateConstraints { make in
                make.height.equalTo(35)
            }
        } else {
            mainView.storeLocationTextView.snp.updateConstraints { make in
                make.height.equalTo(55)
            }
        }
    }
    
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
            
            storeLocationTextViewHeight(textCount: changeText.count)
            
            return changeText.count <= 35
        } else {
            return true
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == mainView.storeReviewTextView {
            setKeyboardObserver()
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textViewNotPlaceholder()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == mainView.storeLocationTextView {
            textView.textViewPlaceholder(placeholderText: TextViewPlaceholder.locationPlaceholder.rawValue)
        } else {
            textView.textViewPlaceholder(placeholderText: TextViewPlaceholder.reviewPlaceholder.rawValue)
            
            removeKeyboardObserver()
            mainView.endEditing(true)
        }
    }
}

extension WriteMemoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryTask?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryTask?[row].category
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mainView.categoryTextField.text = categoryTask?[row].category
        categoryKey = categoryTask?[row].objectId
    }
    
    func setPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        mainView.categoryTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let choiceButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(choiceButtonClicked))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        choiceButton.tintColor = .black
        toolBar.setItems([flexSpace ,choiceButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        mainView.categoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func choiceButtonClicked() {
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
