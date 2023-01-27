//
//  File.swift
//  Better-me
//
//  Created by Phil on 2023/01/16.
//

import UIKit

class PWEditController: UIViewController{
    
    @IBOutlet weak var oldPWTextField: UITextField!
    @IBOutlet weak var newPWTextField: UITextField!
    @IBOutlet weak var newPWTextField2: UITextField!
    
    let saveBtn : UIBarButtonItem = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1)
        view.layer.cornerRadius = 15
        view.setTitle("저장", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 55),
            view.heightAnchor.constraint(equalToConstant: 31)])
        
        
        return UIBarButtonItem(customView: view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "비밀번호 변경"
        
        self.navigationItem.rightBarButtonItem = self.saveBtn
        textFieldCustom(textField:oldPWTextField)
        textFieldCustom(textField:newPWTextField)
        textFieldCustom(textField:newPWTextField2)
    }
    
    func textFieldCustom (textField: UITextField) {
       
        textField.layer.cornerRadius = 17
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.679, green: 0.679, blue: 0.679, alpha: 1).cgColor
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
     
          self.view.endEditing(true)
     
    }
    
}
