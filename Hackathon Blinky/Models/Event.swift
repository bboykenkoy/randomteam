//
//  Event.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/14/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit
import RealmSwift

class Event: Object {
    @objc dynamic var name = ""
    @objc dynamic var participants = ""
    @objc dynamic var payed = ""
    @objc dynamic var total: Double = Double(0)
    @objc dynamic var peoplePay: Double = Double(0)
    
    func add(){
        try! App.shared.realm.write {
            App.shared.realm.add(self)
        }
    }
    func getList(condition: String) -> Results<Event>{
        return App.shared.realm.objects(Event.self).filter(condition)
    }
    func getAll() -> Results<Event>{
        return App.shared.realm.objects(Event.self)
    }
    func getLatestParticipants() -> String{
        let events = App.shared.realm.objects(Event.self)
        if events.count > 0 {
            let e = events.last
            return e?.participants ?? ""
        } else {
            return ""
        }
    }
    
}
