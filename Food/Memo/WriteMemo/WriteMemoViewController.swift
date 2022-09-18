//
//  WriteMemoViewController.swift
//  Food
//
//  Created by J on 2022/09/14.
//

import UIKit
import PhotosUI

import RealmSwift


final class WriteMemoViewController: BaseViewController {
    
    private let mainView = WriteMemoView()
    
    let repository = UserWishListRepository()
    
    var tasks: Results<UserMemo>?
    
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
        
    }
    @objc func galleryButtonClicked() {
        
    }
    @objc func resaveButtonClicked() {
        
    }
    @objc func deleteButtonClicked() {
    
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
