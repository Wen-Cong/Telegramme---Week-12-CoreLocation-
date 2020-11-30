//
//  FriendController.swift
//  Telegramme
//
//  Created by Yeo Wen Cong on 30/11/20.
//

import Foundation
import UIKit
import CoreData

class FriendController{
    func AddFriend(friend: Friend) {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDFriend", in: context)!
        
        let friendNS = NSManagedObject(entity: entity, insertInto: context)
        
        friendNS.setValue(friend.name, forKeyPath: "name")
        friendNS.setValue(friend.profileImageName, forKeyPath: "profileImageName")
        
        do{
            try context.save()
        }catch let error as NSError{
            print("Unable to add friend. \(error). \(error.userInfo)")
        }
    }
    
    func AddMessageToFriend(friend:Friend, message:Message){
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Create an entity and a new friend record
       let messageEntity = NSEntityDescription.entity(forEntityName:"CDMessage", in: context)!
       
       //friend record
       let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDFriend")
       fetchRequest.predicate = NSPredicate(format: "name = %@", friend.name)
       
       
       do {
           let friendlist = try context.fetch(fetchRequest)
           let friendNS = friendlist[0]
           
           let messageNS = NSManagedObject(entity:messageEntity, insertInto: context)
           messageNS.setValue(message.isSender , forKeyPath:"isSender")
           messageNS.setValue(message.text , forKeyPath:"text")
           messageNS.setValue(message.date , forKeyPath:"date")
           messageNS.setValue(friendNS , forKeyPath:"friend")
           
           try context.save()
        
       } catch let error as NSError {
        print("Unable to add message to friend!. \(error). \(error.userInfo)")
       }
    }
    
    func retrieveMessagebyFriend(friend:Friend)-> [Message] {
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var messages:[Message] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFriend")
        fetchRequest.predicate = NSPredicate(format: "name = %@", friend.name)
        
        do{
            let result = try context.fetch(fetchRequest)
            let friendNS = result[0] as! NSManagedObject
            
            let messageList:[NSManagedObject] = friendNS.value(forKey: "message") as! [NSManagedObject]
            
            for messageNS in messageList{
                let message = Message(date: messageNS.value(forKey: "date") as! Date, isSender: messageNS.value(forKey: "isSender") as! Bool, text: messageNS.value(forKey: "text") as! String)
                
                messages.append(message)
            }
        } catch let error as NSError {
            print("Unable to retrieve messages by friend. \(error). \(error.userInfo)")
        }
        
        return messages
    }
}
