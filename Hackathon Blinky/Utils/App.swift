//
//  AppManager.swift
//  Stindy
//
//  Created by Nguyễn Chí Thành on 6/20/18.
//  Copyright © 2018 Lê Thị Lan Anh. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class App {
    static let shared = App()
    var logged: Bool = false
    var token: String = ""
    let realm: Realm!
    var currentUser: People!
    private init() {
        self.realm = try! Realm()
        let list = self.realm.objects(People.self).filter("isCurrentPeople == true")
        if list.count > 0 {
            self.currentUser = list.last ?? People()
        } else {
            self.currentUser = People()
        }
    }
    
}
