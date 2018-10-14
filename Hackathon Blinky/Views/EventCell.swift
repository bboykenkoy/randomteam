//
//  EventCell.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/14/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var participantsName: UILabel!
    @IBOutlet weak var payedNAme: UILabel!
    @IBOutlet weak var moneyTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
