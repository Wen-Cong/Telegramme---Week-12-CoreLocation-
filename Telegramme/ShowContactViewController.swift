//
//  ShowContactViewController.swift
//  Telegramme
//
//  Created by Yeo Wen Cong on 12/11/20.
//

import Foundation
import UIKit

class ShowContactViewController: UITableViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let contactController = ContactController()
    var contactList:[Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList = contactController.retriveAllContact()
        self.tableView.reloadData() //Refresh data
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contactList = contactController.retriveAllContact()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let contact = contactList[indexPath.row]
        cell.textLabel!.text = "\(contact.firstName) \(contact.lastName)"
        cell.detailTextLabel!.text = "\(contact.mobileNo)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let contact = contactList[indexPath.row]
            let editAction = UITableViewRowAction(style: .default, title: "Update", handler: { (action, indexPath) in
                let alert = UIAlertController(title: "", message: "Update Contact", preferredStyle: .alert)
                var oldMobileNo = contact.mobileNo
                alert.addTextField(configurationHandler: { (textField) in
                    textField.text = contact.firstName
                    textField.placeholder = "First Name"
                })
                alert.addTextField(configurationHandler: { (textField1) in
                    textField1.text = contact.lastName
                    textField1.placeholder = "Last Name"
                })
                alert.addTextField(configurationHandler: { (textField2) in
                    textField2.text = contact.mobileNo
                    textField2.placeholder = "Mobile No"
                })
                alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                    contact.firstName = alert.textFields?[0].text! ?? ""
                    contact.lastName = alert.textFields?[1].text! ?? ""
                    contact.mobileNo = alert.textFields?[2].text! ?? ""
                    
                    //Update contact in core data
                    self.contactController.updateContact(mobileno: oldMobileNo, newContact: contact)
                    
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: false)
                
            })

            let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
                self.contactList.remove(at: indexPath.row)
                self.contactController.deleteContact(mobileno: contact.mobileNo)
                tableView.reloadData()
            })
        editAction.backgroundColor = .darkGray
            return [deleteAction, editAction]
        }

}
