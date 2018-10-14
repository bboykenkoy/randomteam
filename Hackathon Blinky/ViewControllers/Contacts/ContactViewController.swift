//
//  ContactViewController.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/13/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class ContactViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var contacts: [People]!
    
    @IBAction func ADD(_ sender: UIBarButtonItem) {
        let vc = SearchViewController(nibName: "SearchViewController", bundle: nil)
        vc.title = "Search"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showHud()
        self.contacts.removeAll()
        Service().getContacts { (JSON) in
            let list = JSON["contacts"].array ?? []
            if list.count > 0{
                for item in list {
                    let people = People()
                    people.nickname = item["nickname"].string ?? ""
                    people.name = item["name"].string ?? ""
                    people.id = item["id"].int ?? 0
                    people.profileImage = item["profileImage"].string ?? ""
                    people.username = item["username"].string ?? ""
                    self.contacts.append(people)
                }
                self.tableView.reloadData();
            }
            self.hideHud()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contacts = [People]()
        self.tableView.register(UINib(nibName: "PeopleCell", bundle: nil), forCellReuseIdentifier: "PeopleCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath) as! PeopleCell
        if indexPath.row < self.contacts.count {
            let people = self.contacts[indexPath.row]
            cell.name.text = people.name
            cell.nickname.text = String.init(format: "(%@)",people.nickname)
            cell.username.text = String.init(format: "@%@",people.username)
            cell.imgChecked.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
