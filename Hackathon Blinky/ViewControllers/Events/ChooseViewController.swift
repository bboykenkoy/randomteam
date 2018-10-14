//
//  ChooseViewController.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/14/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChooseViewController: BaseViewController {
    var type: Int = 0
    var peoples: [JSON]!
    var peoplesClicked: NSMutableArray!
    typealias CallbackPeople = (_ people: [People], _ type: Int) -> Void
    var onChoosePeople: CallbackPeople!
    
    @IBAction func onClickOK(_ sender: UIButton) {
        self.getData()
    }
    func getData(){
        let arraysClicked = self.peoples.filter { $0["clicked"].boolValue == true}
        var arrays: [People] = [People]()
        for item in arraysClicked {
            let people = People()
            people.nickname = item["nickname"].string ?? ""
            people.name = item["name"].string ?? ""
            people.id = item["id"].int ?? 0
            people.profileImage = item["profileImage"].string ?? ""
            people.username = item["username"].string ?? ""
            arrays.append(people)
        }
        if self.onChoosePeople != nil && arrays.count > 0{
            self.onChoosePeople(arrays, self.type)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.peoples = [JSON]()
        self.peoplesClicked = NSMutableArray()
        self.showHud()
        Service().getContacts { (JSON) in
            let list = JSON["contacts"].array ?? []
            if list.count > 0{
                for item in list {
                    var newItem = item
                    newItem["clicked"] = false
                    self.peoples.append(newItem)
                }
                self.tableView.reloadData();
            }
            self.hideHud()
        }
        
        self.tableView.register(UINib(nibName: "PeopleCell", bundle: nil), forCellReuseIdentifier: "PeopleCell")
        // Do any additional setup after loading the view.
    }
    
}
extension ChooseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peoples.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath) as! PeopleCell
        cell.tag = indexPath.row
        if indexPath.row < self.peoples.count {
            let people = People()
            people.nickname = self.peoples[indexPath.row]["nickname"].string ?? ""
            people.name = self.peoples[indexPath.row]["name"].string ?? ""
            people.id = self.peoples[indexPath.row]["id"].int ?? 0
            people.profileImage = self.peoples[indexPath.row]["profileImage"].string ?? ""
            people.username = self.peoples[indexPath.row]["username"].string ?? ""
            let isClicked = self.peoples[indexPath.row]["clicked"].bool ?? false
            if isClicked {
                cell.imgChecked.isHidden = false
            } else {
                cell.imgChecked.isHidden = true
            }
            cell.name.text = people.name
            cell.nickname.text = String.init(format: "(%@)",people.nickname)
            cell.username.text = String.init(format: "@%@",people.username)
            cell.markThisPeople = { (tag) in
                if tag < self.peoples.count{
                    var newPeoples: [JSON] = [JSON]()
                    let currentPeople = self.peoples[tag]
                    let currentNickname = currentPeople["nickname"].string ?? ""
                    for item in self.peoples {
                        let itemPeople = item
                        let itemNickname = itemPeople["nickname"].string ?? ""
                        if currentNickname == itemNickname {
                            if currentPeople["clicked"] == true {
                                var newItem = item
                                newItem["clicked"] = false
                                newPeoples.append(newItem)
                            } else {
                                var newItem = item
                                newItem["clicked"] = true
                                newPeoples.append(newItem)
                            }
                        } else {
                            let newItem = item
                            newPeoples.append(newItem)
                        }
                    }
                    self.peoples = newPeoples
                    self.tableView.reloadData()
                    let arraysClicked = self.peoples.filter { $0["clicked"].boolValue == true}
                    if arraysClicked.count == 1 && self.type == 200{
                        self.getData()
                    }
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
