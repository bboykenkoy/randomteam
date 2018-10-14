//
//  PeopleNameCell.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/14/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class PeopleNameCell: UITableViewCell {
    @IBOutlet weak var lbIndex: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    @IBAction func onClickAddContact(_ sender: UIButton) {
        if (self.addThisContact != nil) {
            self.addThisContact()
        }
    }
    typealias Callback = () -> Void
    var addThisContact: Callback!
    
    @IBOutlet weak var lbUsername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
