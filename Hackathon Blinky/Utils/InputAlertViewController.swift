//
//  InputAlertViewController.swift
//  Hackathon Blinky
//
//  Created by Nguyễn Chí Thành on 10/14/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class InputAlertViewController: BaseViewController {
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var inputContent: UITextField!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    typealias CallbackString = (String) -> Void
    var onConfirmButton: CallbackString!
    
    @IBAction func CANCEL(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func EXEC(_ sender: UIButton) {
        if self.onConfirmButton != nil {
            self.dismiss(animated: false, completion: {
                self.onConfirmButton(self.inputContent.text ?? "")
            })
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
