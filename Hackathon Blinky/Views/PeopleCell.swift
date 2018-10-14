//
//  PeopleCell.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/13/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class PeopleCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var imgChecked: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var wrapButton: UIButton!
    typealias Callback = (Int) -> Void
    var markThisPeople: Callback!
    
    
    @IBAction func wrapActionButton(_ sender: UIButton) {
        if self.markThisPeople != nil {
            self.markThisPeople(self.tag)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
