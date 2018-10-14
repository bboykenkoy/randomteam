//
//  ViewController.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/13/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit
import Alamofire
import GSMessages
class ViewController: BaseViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func SIGNIN(_ sender: UIButton) {
        self.showHud()
        let params = [
            "username": self.username.text ?? "",
            "password": self.password.text ?? "",
            "policiesAccepted" :"true"
            ]
        Service().signinWithAccount(info: params as [String : AnyObject]) { (JSON) in
            if(JSON["error"].stringValue.count != 0){
                self.showMessage(JSON["error"].stringValue, type: .error)
                self.hideHud()
            } else {
                App.shared.currentUser.updateToken(token: JSON["token"].stringValue)
                Service().getMe(completion: { (JSON_ME) in
                    self.hideHud()
                    let currentPeople = People()
                    currentPeople.name = JSON_ME["name"].string ?? ""
                    currentPeople.email = JSON_ME["email"].string ?? ""
                    currentPeople.googleConnection = JSON_ME["googleConnection"].bool ?? false
                    currentPeople.profileImage = JSON_ME["profileImage"].string ?? ""
                    currentPeople.marketingNotifications = JSON_ME["marketingNotifications"].bool ?? false
                    currentPeople.unverifiedEmail = JSON_ME["unverifiedEmail"].bool ?? false
                    currentPeople.username = JSON_ME["username"].string ?? ""
                    currentPeople.subscribedUntil = JSON_ME["subscribedUntil"].string ?? ""
//                    currentPeople.id = JSON_ME["id"].int ?? 0
                    currentPeople.created = JSON_ME["created"].string ?? ""
                    currentPeople.policiesAccepted = JSON_ME["policiesAccepted"].bool ?? false
                    currentPeople.currency = JSON_ME["currency"].string ?? ""
                    currentPeople.facebookConnection = JSON_ME["facebookConnection"].bool ?? false
                    currentPeople.marketingEmails = JSON_ME["marketingEmails"].bool ?? false
                    currentPeople.token = JSON["token"].stringValue
                    currentPeople.refreshToken = JSON["refreshToken"].stringValue
                    currentPeople.isCurrentPeople = true
                    currentPeople.saveCurrentUser()
                    self.presentWithIdentifier(identifier: "MAIN_TABBAR", animated: false)
                })
                
                
            }
        }
    }
    @IBAction func SIGNUP(_ sender: UIButton) {
        let vc = SignupViewController(nibName: "SignupViewController", bundle: nil)
        vc.title = "Sign Up"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

