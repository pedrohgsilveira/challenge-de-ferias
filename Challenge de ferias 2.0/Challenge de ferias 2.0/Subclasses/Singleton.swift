//
//  File.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 13/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CoreData
import UIKit



public class ModelManager{
    
    private init(){
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            _albuns = try context.fetch(PhotoAlbum.fetchRequest())
            _photoCard = try context.fetch(PhotoCard.fetchRequest())
            
        }catch{
            fatalError("Dados Perdidos")
        }
    }
    
    class func shared() -> ModelManager{
        return sharedContextManager
    }
    
    private static var sharedContextManager: ModelManager = {
        let contextManager = ModelManager()
        return contextManager
    }()
    
    private let context:NSManagedObjectContext
    private var _albuns:[PhotoAlbum]
    private var _photoCard:[PhotoCard]

    private var delegates:[DataModifiedDelegate] = []
    public func addDelegate(newDelegate:DataModifiedDelegate){
        delegates.append(newDelegate)
    }
    
    private func notify(){
        for delegates in delegates{
            delegates.DataModified()
        }
    }
    
    public var albuns:[PhotoAlbum]{
        get {
            var copy:[PhotoAlbum] = []
            copy.append(contentsOf: _albuns)
            return copy
        }
        
    }
    
    public func addAlbum(name:String, photo:UIImage?, date: NSDate) -> ModelStatus{
        
        let newAlbum = NSEntityDescription.insertNewObject(forEntityName: "PhotoAlbum", into: context) as! PhotoAlbum
        newAlbum.feed(name: name, photo: photo, date: date)
        _albuns.append(newAlbum)
        do{
            try context.save()
        }
        catch{
            return ModelStatus(successful: false, description: "Não foi possivel criar um novo Album")
        }
        notify()
        return ModelStatus(successful: true)
    }
    
    public func editAlbum(target:PhotoAlbum, newName:String?, newDate: NSDate?) -> ModelStatus{
        
        if target.modifyData(newName: newName, newDate: newDate){
            do{
                try context.save()
                return ModelStatus(successful: true)
            }catch{
                return ModelStatus(successful: false, description: "Não foi possivel editar o album")
            }
        }
        return ModelStatus(successful: false, description: "Não ocorreram modificações")
        
    }
    
    public func removeAlbum(rA: Int) -> ModelStatus{
        
        if rA < _albuns.count && rA >= 0{
            context.delete(_albuns[rA])
            _albuns.remove(at: rA)
            do{
                try context.save()
                notify()
                return ModelStatus(successful: true)
            }catch{
                return ModelStatus(successful: false, description: "Não foi possivel deletar o Album" )
            }
        }
        return ModelStatus(successful: false, description: "Não foi possivel acessar o Album desejado" )
    }
    
    public var completePhoto:[PhotoCard]{
        get{
            var copy:[PhotoCard] = []
            copy.append(contentsOf: _photoCard)
            return copy
        }
        
    }
    
    public func addPhotoCard(target: PhotoAlbum) -> ModelStatus{
        
        let photoCard = NSEntityDescription.insertNewObject(forEntityName: "PhotoCard", into: context) as! PhotoCard
        photoCard.name = String()
        photoCard.date = NSDate()
        target.addToCompletePhoto(photoCard)
        _photoCard.append(photoCard)
        do{
            try context.save()
            notify()
            return ModelStatus(successful: true)
        }catch{
            return ModelStatus(successful: false, description: "Não foi possivel criar um Photo Card")
        }
    }
    
    
    public func removePhotoCard(rPC: Int) -> ModelStatus{
        
        if rPC < _photoCard.count && rPC >= 0{
            context.delete(_photoCard[rPC])
            _photoCard.remove(at: rPC)
            do{
                try context.save()
                notify()
                return ModelStatus(successful: true)
            }catch{
                return ModelStatus(successful: false, description: "Não foi possivel apagar o Photo Card")
            }
        }
        
        return ModelStatus(successful: false, description: "Não foi possivel encontrar o Photo Card" )
    }
    
}

