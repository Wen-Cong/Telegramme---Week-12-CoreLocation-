//
//  AddContactViewController.swift
//  Telegramme
//
//  Created by Yeo Wen Cong on 12/11/20.
//

import Foundation
import UIKit

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var firstNameFld: UITextField!
    
    @IBOutlet weak var lastNameFld: UITextField!
    
    @IBOutlet weak var mobileFld: UITextField!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    let contactController = ContactController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        firstNameFld.text = ""
        lastNameFld.text = ""
        mobileFld.text = ""
    }
    
    @IBAction func createBtn(_ sender: Any) {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let contact = Contact(firstname: firstNameFld.text!, lastname: lastNameFld.text!, mobileNo: mobileFld.text!)

        //appDelegate.contactList.append(contact)
        
        contactController.AddContact(newContact: contact)
        
        messageLabel.text = "\(firstNameFld.text!) \(lastNameFld.text!) added successfully!"
        
        //print(String(appDelegate.contactList.count))
    }
}
