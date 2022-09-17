//
//  FileManager+Extension.swift
//  Food
//
//  Created by J on 2022/09/17.
//

import UIKit

extension UIViewController {
    
    func documentDiretoryPath() -> URL? {
        guard let documentDiretory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return documentDiretory
    }
    
    func ImageDirectoryPath() -> URL? {
        let imageDirectory = documentDiretoryPath()?.appendingPathComponent("Image")
        
        return imageDirectory
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let imageDirectory = ImageDirectoryPath() else { return }
        
        if FileManager.default.fileExists(atPath: imageDirectory.path) {
            let fileURL = imageDirectory.appendingPathComponent(fileName)
            
            guard let data = image.jpegData(compressionQuality: 0.5) else { return }
            print(fileURL)
            
            do {
                try data.write(to: fileURL)
            } catch let error {
                print("file save error", error)
            }
            
        } else {
            do {
                try FileManager.default.createDirectory(at: imageDirectory, withIntermediateDirectories: true)
            } catch {
                print("경로 문제")
            }
            
            let fileURL = imageDirectory.appendingPathComponent(fileName)
            
            guard let data = image.jpegData(compressionQuality: 0.5) else { return }
            print(fileURL)
            
            do {
                try data.write(to: fileURL)
            } catch let error {
                print("file save error", error)
            }
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let imageDirectory = ImageDirectoryPath() else {return nil}
        let fileURL = imageDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(named: "dishes")
        }
    }
}
