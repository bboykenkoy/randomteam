//
//  BaseViewController.swift
//  Stindy
//
//  Created by Lê Thị Lan Anh on 6/13/18.
//  Copyright © 2018 Lê Thị Lan Anh. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    typealias Callback = () -> Void
    var didTapSelfView: Callback!
    
    var isLightStatusBar: Bool! {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func showNavigation(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func hideNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public var hud: MBProgressHUD!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return (self.isLightStatusBar != nil && self.isLightStatusBar) ? .lightContent : .default
    }
    func showHud(){
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    func hideHud(){
        self.hud.hide(animated: true)
    }
    func Delay(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    // MARK: LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func tapDismiss(){
        self.view.endEditing(true)
        if self.didTapSelfView != nil {
            self.didTapSelfView()
        }
    }
}
