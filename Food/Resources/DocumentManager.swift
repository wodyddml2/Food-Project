//
//  FileManager+Extension.swift
//  Food
//
//  Created by J on 2022/09/17.
//

import UIKit

enum DocumentError: Error {
    case fetchDirectoryPathError
    
    case fetchJsonDataError
    
    case jsonEncodeError
    case jsonDecodeError
}

class DocumentManager {
    
    static let shared = DocumentManager()
    
    private init() { }
  
    
    func documentDirectoryPath() -> URL? {
        guard let documentDiretory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return documentDiretory
    }
    
    func ImageDirectoryPath() -> URL? {
        let imageDirectory = documentDirectoryPath()?.appendingPathComponent("Image")
        
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
            return UIImage(named: "amda")
        }
    }
    
    func fetchDocumentZipFile(completion: @escaping([DocumentFile], [Double]?) -> ()) {
        do {
            guard let path = documentDirectoryPath() else {return}
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
                       
            let zip = docs.filter {
                $0.pathExtension == "zip"
            }
            
            var documentFile: [DocumentFile] = []
            
            for i in zip {
                let title = i.lastPathComponent
                let date = try FileManager.default.attributesOfItem(atPath: i.path)
                let creationDate = date[FileAttributeKey.creationDate] as! Date
                
                documentFile.append(DocumentFile(title: title, date: creationDate))
            }
            documentFile.sort {
                $0.date < $1.date
            }

            let fileSize = zip.map {
                try? FileManager.default.attributesOfItem(atPath: $0.path)[.size]
            } as? [Double]
            
            completion(documentFile, fileSize)
            
        } catch {
            print("Error")
        }
    }
    
    func fetchJSONData(json: String) throws -> Data {
        guard let documentPath = documentDirectoryPath() else { throw DocumentError.fetchDirectoryPathError }
        
        let jsonDataPath = documentPath.appendingPathComponent(json)
        
        do {
            return try Data(contentsOf: jsonDataPath)
        }
        catch {
            throw DocumentError.fetchJsonDataError
        }
    }
    
    func saveJsonToDocument(data: Data, json: String) throws {
        guard let jsonDirectory = documentDirectoryPath()?.appendingPathComponent(json) else { return }
        
        try data.write(to: jsonDirectory)
    }
    
}
