//
//  ViewController.swift
//  Telegramme
//
//  Created by Yeo Wen Cong on 12/11/20.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var usernameInput: UITextField!
    
    
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func loginBtn(_ sender: Any) {
        if true{
            let storyboard = UIStoryboard(name: "Content", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Content") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    


}

