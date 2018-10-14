//
//  Service.swift
//  Locate DiDi
//
//  Created by Nguyễn Chí Thành on 10/01/2018.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//
import UIKit
import SwiftyJSON
import Alamofire

class Service: BaseService {
    func signupWithAccount(info: [String: AnyObject], completion: @escaping (_ status: JSON) ->()){
        self.post(type: .API_SIGNUP, params: info) { (jsonData) in
            completion(jsonData)
        }
    }
    func signinWithAccount(info: [String: AnyObject], completion: @escaping (_ status: JSON) ->()){
        self.post(type: .API_SIGNIN, params: info) { (jsonData) in
            completion(jsonData)
        }
    }
    func refresh(info: [String: AnyObject], completion: @escaping (_ status: JSON) ->()){
        self.post(type: .API_REFRESH_TOKEN, params: info) { (jsonData) in
            completion(jsonData)
        }
    }
    
    func getMe(completion: @escaping (_ status: JSON) ->()){
        self.get(type: .API_PEOPLE_ME, params: [:]) { (jsonData) in
            completion(jsonData)
        }
    }
    func searchPeople(info: [String: AnyObject], completion: @escaping (_ status: JSON) ->()){
        self.get(type: .API_SEARCH_PEOPLE, params: info) { (jsonData) in
            completion(jsonData)
        }
    }
    func addContact(info: [String: AnyObject], completion: @escaping (_ status: JSON) ->()){
        self.post(type: .API_ADD_CONTACT, params: info) { (jsonData) in
            completion(jsonData)
        }
    }
    func getContacts(completion: @escaping (_ status: JSON) ->()){
        self.get(type: .API_ADD_CONTACT, params: [:]) { (jsonData) in
            completion(jsonData)
        }
    }
}
