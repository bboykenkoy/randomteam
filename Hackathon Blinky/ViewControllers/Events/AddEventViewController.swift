//
//  AddEventViewController.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/14/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class AddEventViewController: BaseViewController{
    var participants: [People]!
    var payed: [People]!
    
    @IBAction func ADD_EVENT(_ sender: UIButton) {
        self.addEvent()
    }
    @IBOutlet weak var eventIntpu: UITextField!
    @IBOutlet weak var participantsInput: UITextField!
    @IBOutlet weak var payedInput: UITextField!
    @IBOutlet weak var totalInput: UITextField!
    
    var money: Double = Double(0)
    
    
    @IBAction func CHOOSE_PARTICIPANTS(_ sender: UIButton) {
        if(Event().getLatestParticipants().count == 0){
            let vc = ChooseViewController(nibName: "ChooseViewController", bundle: nil)
            vc.type = 100
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            vc.onChoosePeople = { (peoples , type) in
                self.participants = [People]()
                self.participants = peoples
                self.participantsInput.text = self.getName(peoples: self.participants)
            }
        }
    }
    @IBAction func CHOOSE_PAYED(_ sender: UIButton) {
        let vc = ChooseViewController(nibName: "ChooseViewController", bundle: nil)
        vc.type = 200
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        vc.onChoosePeople = { (peoples , type) in
            self.payed = [People]()
            self.payed = peoples
            self.payedInput.text = self.getName(peoples: self.payed)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.participantsInput.text = Event().getLatestParticipants()
        // Do any additional setup after loading the view.
    }
    func addEvent(){
        if self.eventIntpu.text?.count == 0 || self.participantsInput.text?.count == 0 || self.payedInput.text?.count == 0 || self.totalInput.text?.count == 0{
            self.showMessage("Please fill data!", type: .error)
        } else {
            self.money = Double(self.totalInput.text ?? "0") ?? 0
            let event = Event()
            event.name = self.eventIntpu.text ?? ""
            event.participants = self.participantsInput.text ?? ""
            event.payed = self.payedInput.text ?? ""
            event.total = self.money
            event.peoplePay = self.money / Double(self.participants.count)
            event.add()
        }
    }
    
    
    
    
    func getName(peoples: [People]) -> String{
        var stringg = ""
        for (index, pp) in peoples.enumerated() {
            if index != peoples.count-1{
                stringg.append("\(pp.username), ")
            } else {
                stringg.append("\(pp.username)")
            }
        }
        return stringg
    }

}
