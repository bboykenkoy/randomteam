//
//  SearchViewController.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/14/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var peoples: [People]!
    
    @IBAction func SEARCH(_ sender: UIButton) {
        self.view.endEditing(true)
        self.searchings()
    }
    func searchings(){
        self.peoples.removeAll()
        self.showHud()
        Service().searchPeople(info: ["startsWith": self.searchInput.text as AnyObject]) { (JSON) in
            self.hideHud()
            let list = JSON.array ?? []
            if list.count > 0{
                for ppv in list {
                    let peop = People()
                    peop.name = ppv["name"].string ?? ""
                    peop.username = ppv["username"].string ?? ""
                    peop.profileImage = ppv["profileImage"].string ?? ""
                    self.peoples.append(peop)
                }
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var searchInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        self.peoples = [People]()
        self.searchings()
        self.tableView.register(UINib(nibName: "PeopleNameCell", bundle: nil), forCellReuseIdentifier: "PeopleNameCell")
    }

}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peoples.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleNameCell", for: indexPath) as! PeopleNameCell
        if indexPath.row < self.peoples.count {
            let people = self.peoples[indexPath.row]
            cell.lbIndex.text = String.init(format: "%.2i", indexPath.row + 1)
            cell.lbName.text = people.name
            cell.lbUsername.text = String.init(format: "@%@", people.username)
            cell.addThisContact = {
                self.addThisContact(people: people)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func addThisContact(people: People){
        self.view.endEditing(true)
        let vc = InputAlertViewController(nibName: "InputAlertViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.onConfirmButton = { (nickname) -> () in
            self.showHud()
            let params = [
                "username": people.username,
                "nickname": nickname
            ]
            Service().addContact(info: params as [String : AnyObject]) { (JSON) in
                self.hideHud()
                if(JSON["error"].stringValue.count != 0){
                    self.showMessage(JSON["error"].stringValue, type: .error)
                } else {
                    self.showMessage("Add friend success!", type: .success)
                }
            }
        }
        self.present(vc, animated: false, completion: nil)
    }
}
