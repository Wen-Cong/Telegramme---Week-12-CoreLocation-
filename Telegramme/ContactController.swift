//
//  ContactController.swift
//  Telegramme
//
//  Created by Yeo Wen Cong on 26/11/20.
//

import Foundation
import UIKit
import CoreData

class ContactController {
    
    //Add a new contact to core data
    func AddContact(newContact: Contact){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDContact", in: context)!
        
        let contact = NSManagedObject(entity: entity, insertInto: context)
        
        contact.setValue(newContact.firstName, forKey: "firstname")
        contact.setValue(newContact.lastName, forKey: "lastname")
        contact.setValue(newContact.mobileNo, forKey: "mobileno")
        
        do{
            try context.save()
        }catch let error as NSError{
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    func retriveAllContact()-> [Contact]{
        var contacts:[NSManagedObject] = []
        var contactList:[Contact] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        do {
            contacts = try context.fetch(fetchRequest)
            
            for c in contacts{
                let firstname = c.value(forKey: "firstname") as? String
                let lastname = c.value(forKey: "lastname") as? String
                let mobileno = c.value(forKey: "mobileno") as? String
                
                contactList.append(Contact(firstname: firstname!, lastname: lastname!, mobileNo: mobileno!))
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return contactList
    }
    
    func updateContact(mobileno: String, newContact: Contact){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        if let result = try? context.fetch(fetchRequest) {
            if(result.count > 0){
                for object in result {
                    let mobilenum = object.value(forKey: "mobileno") as? String
                    if(mobilenum == mobileno){
                        object.setValue(newContact.firstName, forKey: "firstname")
                        object.setValue(newContact.lastName, forKey: "lastname")
                        object.setValue(newContact.mobileNo, forKey: "mobileno")
                        break
                    }
                }
                do{
                    try context.save()
                }catch let error as NSError{
                    print("Could not update contact. \(error). \(error.userInfo)")
                }
            }
            else{
                print("No contact is found!")
            }
        }
    }
    
    func deleteContact(mobileno:String){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDContact")
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                let mobilenum = object.value(forKey: "mobileno") as? String
                if(mobilenum == mobileno){
                    context.delete(object)
                    break
                }
            }
            do{
                try context.save()
            }catch let error as NSError{
                print("Could not delete contact. \(error). \(error.userInfo)")
            }
        }
        
        
        //var contacts:[NSManagedObject] = []
        //var contact:NSManagedObject? = nil
        
        /*do {
            contacts = try context.fetch(fetchRequest)
            
            for c in contacts{
                let mobilenum = c.value(forKey: "mobileno") as? String
                if (mobilenum == mobileno){
                    contact = c
                    break
                }
            }
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if(contact != nil){
            do{
               try context.delete(contact!)
            } catch let error as NSError{
                print("Unable to delete. \(error), \(error.userInfo)")
            }
        }
        else{
            print("Contact not found")
        }
        */
    }
}
