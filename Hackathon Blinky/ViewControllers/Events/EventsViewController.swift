//
//  EventsViewController.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/14/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
class EventsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var events: [Event]!
    
    @IBAction func CALCULATOR(_ sender: UIBarButtonItem) {
        self.calculator()
    }
    @IBAction func ADD(_ sender: UIBarButtonItem) {
        let vc = AddEventViewController(nibName: "AddEventViewController", bundle: nil)
        vc.title = "Add Event"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.events.removeAll()
        let ev = Event().getAll()
        if ev.count > 0 {
            for e in ev {
                self.events.append(e)
            }
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.events = [Event]()
        
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
    }

    func calculator(){
        
    }

}
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        if indexPath.row < self.events.count {
            let event = self.events[indexPath.row]
            cell.eventName.text = event.name
            cell.participantsName.text = event.participants
            cell.payedNAme.text = event.payed
            cell.moneyTotal.text = "\(event.total)"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
