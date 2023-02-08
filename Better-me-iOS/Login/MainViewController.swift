//
//  ViewController.swift
//  login
//
//  Created by 심윤주 on 2023/01/09.
//

import UIKit
import Alamofire


class MainViewController: UIViewController {
    
    @IBOutlet weak var joinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinBtn.layer.borderWidth = 2
        joinBtn.layer.cornerRadius = 25
        joinBtn.layer.borderColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1).cgColor
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginFirstViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
    @IBAction func JoinBtn(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "JoinViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
    
    
}

