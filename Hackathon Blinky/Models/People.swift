//
//  People.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/13/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit
import RealmSwift

class People: Object {
    @objc dynamic var id = 0
    @objc dynamic var nickname = ""
    @objc dynamic var token = ""
    @objc dynamic var refreshToken = ""
    @objc dynamic var username = ""
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var created = ""
    @objc dynamic var currency = ""
    @objc dynamic var facebookConnection = false
    @objc dynamic var googleConnection = false
    @objc dynamic var subscribedUntil = ""
    @objc dynamic var policiesAccepted = false
    @objc dynamic var profileImage = ""
    @objc dynamic var unverifiedEmail = true
    @objc dynamic var marketingEmails = false
    @objc dynamic var marketingNotifications = false
    @objc dynamic var isCurrentPeople = false
    
    func saveCurrentUser(){
        try! App.shared.realm.write {
            App.shared.realm.add(self)
        }
    }
    func updateToken(token: String){
        try! App.shared.realm.write {
            self.token = token
        }
    }
    func removeCurrentUser(){
        try! App.shared.realm.write {
            let arrays = App.shared.realm.objects(People.self).filter("isCurrentPeople == true")
            for us in arrays {
                realm?.delete(us)
            }
            App.shared.currentUser = People()
        }
    }
    
    func add(){
        try! App.shared.realm.write {
            App.shared.realm.add(self)
        }
    }
    func getList(condition: String) -> Results<People>{
        return App.shared.realm.objects(People.self).filter(condition)
    }
}
