//
//  ServiceManager
//  ChatApp
//
//  Created by Nguyễn Chí Thành on 02/01/2018.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum API_SERVICE {
    case API_SIGNUP
    case API_SIGNIN
    case API_REFRESH_TOKEN
    case API_PEOPLE_ME
    case API_SEARCH_PEOPLE
    case API_ADD_CONTACT
}
let BASE : String = "http://159.65.12.44"//"http://192.168.1.65"
let BASE_URL : String = "\(BASE):8080/api/v3"
let BASE_URL_AUTH : String = "\(BASE):8080/auth/v3"
let SERVER_URL: String = "\(BASE):8080"


class BaseService: NSObject {
    
    static let shared = {
        return BaseService()
    }
    func getURLWithType(type : API_SERVICE, params : [String : AnyObject]) -> String{
        var result = String()
        switch type {
        case .API_SIGNUP:
            result = "\(BASE_URL)/persons"
            break
        case .API_SIGNIN:
            result = "\(BASE_URL_AUTH)/authenticate"
            break
        case .API_REFRESH_TOKEN:
            result = "\(BASE_URL_AUTH)/refresh"
            break
        case .API_PEOPLE_ME:
            result = "\(BASE_URL)/persons/me"
            break
        case .API_ADD_CONTACT:
            result = "\(BASE_URL)/contacts"
            break
        default:
            result =  ""
            break
        }
        return result
    }
    func getURLAndParamertersWithType(type : API_SERVICE, params : [String : AnyObject]) -> String{
        var result = String()
        let appendString = NSMutableString()
        if params.count > 0 {
            appendString.append("?")
        }
        for (index, item) in params.enumerated() {
            appendString.append(item.key)
            appendString.append("=")
            appendString.append(item.value as? String ?? "")
            if index != params.count - 1{
                appendString.append("&")
            }
        }
        switch type {
        case .API_SEARCH_PEOPLE:
            result = "\(BASE_URL)/persons/\(appendString)"
            break
        case .API_ADD_CONTACT:
            result = "\(BASE_URL)/contacts"
            break
        default:
            result =  ""
            break
        }
        return result
    }
    func get(type : API_SERVICE , params : [String:AnyObject], completion: @escaping (_ response : JSON)->()){
        let url = getURLAndParamertersWithType(type: type,params: params)
        
        let arrays = NSMutableArray()
        for value in params {
            arrays.add(NSURLQueryItem(name: value.key, value: value.value as? String ?? ""))
        }
        let urlComponent = NSURLComponents(string: url)
        
        var urlRequest = URLRequest(url: urlComponent?.url ?? URL(string: url)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        if App.shared.currentUser.token.count > 0 {
            urlRequest.addValue("Bearer \(App.shared.currentUser.token)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        print("\(String(describing: urlComponent?.url))")
        Alamofire.request(urlRequest)
            .responseJSON { response in
                let json = SwiftyJSON.JSON(response.value ?? [:])
                print(json)
                completion(json)
        }
    }
    
    func post(type : API_SERVICE , params : [String:AnyObject],completion: @escaping (_ response : JSON)->()){
        let urlRequest = getURLWithType(type: type,params: params)
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        print("URL \(urlRequest)")
        if(App.shared.currentUser.token.count > 0){
            headers["Authorization"] = "Bearer \(App.shared.currentUser.token)"
        }
        Alamofire.request(urlRequest, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (dataResponse) in
            let json = SwiftyJSON.JSON(dataResponse.value ?? [:])
            print(json)
            completion(json)
        }
    }
    
    func JSONFromDictionary(dictionary: [String: AnyObject]) -> String {
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: dictionary,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            return theJSONText
        }
        return ""
    }
    
}
