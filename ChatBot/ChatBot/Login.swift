//
//  ViewController.swift
//  ChatBot
//
//  Created by Prabin K Datta on 30/11/17.
//  Copyright © 2017 Prabin K Datta. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var m_UsernameTxtField: UITextField!
    @IBOutlet weak var m_PasswordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        //call to login controller
        self.performSegue(withIdentifier: "loginsuccessIdentifier", sender: self)
    }
    @IBAction func didTapForgetPasswordBtn(_ sender: Any) {
        //call to forget password controller
    }
}

