//
//  SignupViewController.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/13/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class SignupViewController: BaseViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func SIGNUP(_ sender: UIButton) {
        self.showHud()
        let params = [
            "name": self.name.text ?? "",
            "username": self.username.text ?? "",
            "password": self.password.text ?? "",
            "email" : self.email.text ?? "",
            "currency": "USD"
        ]
        Service().signupWithAccount(info: params as [String : AnyObject]) { (JSON) in
            self.hideHud()
            if(JSON["error"].stringValue.count != 0){
                self.showMessage(JSON["error"].stringValue, type: .error)
            } else {
                self.showMessage("Signup success!", type: .success)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
