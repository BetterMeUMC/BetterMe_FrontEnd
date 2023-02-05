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
    
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        performSegue(withIdentifier: "loginView", sender: self)
        
    }
    
    @IBAction func JoinBtn(_ sender: Any) {
        performSegue(withIdentifier: "joinView", sender: self)
    }
    
  
    
 
    
    
}

