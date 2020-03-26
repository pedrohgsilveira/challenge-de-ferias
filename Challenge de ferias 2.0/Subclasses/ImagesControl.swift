//
//  ImagesControl.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 13/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import UIKit

class ImagesControl {
    
    private static let fileManager:FileManager = FileManager()
    
    
    public static func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    public static func saveImage(image:UIImage, nameWithoutExtension:String){
        
        if let data = image.jpegData(compressionQuality: 1) {
            let filename = getDocumentsDirectory().appendingPathComponent("\(nameWithoutExtension).jpg")
            do{
                try data.write(to: filename)
                print(filename.path)
            }
            catch{
                fatalError("Não foi possível salvar a imagem")
            }
        }
    }
    
    public static func getFile(filePathWithoutExtension:String) -> String?{
        let imagePath:URL = getDocumentsDirectory().appendingPathComponent("\(filePathWithoutExtension).jpg")
        if fileManager.fileExists(atPath: imagePath.relativePath){
            return imagePath.relativePath
        }
        else{
            return nil
        }
    }
    
    public static func deleteImage(filePathWithoutExtension:String) -> Bool{
        do{
            let imagePath:URL = getDocumentsDirectory().appendingPathComponent("\(filePathWithoutExtension).jpg")
            if fileManager.fileExists(atPath: imagePath.relativePath){
                try fileManager.removeItem(at: imagePath)
            }
            else{
                return false
            }
        }
        catch{
            fatalError("Não foi possível deletar o arquivo desejado")
        }
        return true
    }
    
    static func saveToDisk(image: UIImage, compression: CGFloat) -> URL {
        var fileURL = FileManager.default.temporaryDirectory
        let filename = UUID().uuidString
        fileURL.appendPathComponent(filename)
        let data = image.jpegData(compressionQuality: compression)!
        try! data.write(to: fileURL)
        return fileURL
    }
}
