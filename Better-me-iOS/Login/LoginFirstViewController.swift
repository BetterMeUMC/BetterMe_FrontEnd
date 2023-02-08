//
//  LoginFirstViewController.swift
//  login
//
//  Created by 심윤주 on 2023/01/10.
//

import UIKit
import Alamofire

extension UITextField { //textFeild padding
    func addLeftPadding() {
        self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: self.frame.height))
        self.leftViewMode = .always
    }
    
    func borderAttribute() { //굵기 설정
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(red: 0.679, green: 0.679, blue: 0.679, alpha: 1).cgColor
    }
}

extension UIViewController { //화면 터치시 키보드 내려감
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class LoginFirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var alertLabel: UILabel! {
        didSet {
            alertLabel.isHidden = true
        }
    }
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var loginCheck : Bool = false
    var emailCk : Bool = false
    var pwdCk : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //키보드 메소드 호출
        
        //back title 지우기
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        emailField.borderAttribute()
        passwordField.borderAttribute()
        
        emailField.addLeftPadding()
        passwordField.addLeftPadding()
        
        //텍스트필드 delegate설정으로 return시 키보드 내려가도록 설정
        emailField.delegate = self
        passwordField.delegate = self
        
        self.passwordField.addTarget(self, action: #selector(self.TextFieldChange(_:)), for: .editingChanged)
        self.emailField.addTarget(self, action: #selector(self.TextFieldChange(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: emailField)
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(PasswordTextDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: passwordField)
 
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //noti등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //noti해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        
        PostDataManager().PostLogin(email: email, password: password, viewController: self)
    }
    
    @IBAction func passwordFindBtn(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "passwordFindViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        let maxLength = 30
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {
                        // 8글자 넘어가면 자동으로 키보드 내려감
                        alertLabel.isHidden = false
                        alertLabel.text = "이메일은 30자리 미만으로 입력해주세요."
                        emailCk = false
                    }
                    else if text.count == 0 {
                        alertLabel.isHidden = false
                        alertLabel.text = "이메일을 입력해주세요."
                        emailCk = false
                    }
                    else if text.count != 0 && passwordField.text?.count == 0 {
                        alertLabel.isHidden = false
                        alertLabel.text = "비밀번호를 입력해주세요."
                        emailCk = false
                    } else {
                        alertLabel.isHidden = true
                        emailCk = true
                        pwdCk = true
                        alertLabel.isHidden = true
                        loginBtn.isEnabled = true
                        loginBtn.configuration?.background.backgroundColor = .BtnColor
                        loginBtn.configuration?.attributedTitle?.foregroundColor = .WhiteTextColor
                    }
                 
                    if text.count >= maxLength {
                                      let index = text.index(text.startIndex, offsetBy: maxLength)
                                      let newString = text[text.startIndex..<index]
                                      textField.text = String(newString)
                                  }
                }
            }
        }
    
    @objc private func PasswordTextDidChange(_ notification: Notification) {
        let maxLength = 20
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {
                        // 8글자 넘어가면 자동으로 키보드 내려감
                        alertLabel.isHidden = false
                        alertLabel.text = "비밀번호는 6~20자리를 입력해주세요."
                        pwdCk = false
                    }
                    else if text.count == 0 {
                        alertLabel.isHidden = false
                        alertLabel.text = "비밀번호를 입력해주세요."
                       pwdCk = false
                    }
                    else if text.count != 0 && emailField.text?.count == 0 {
                        alertLabel.isHidden = false
                        alertLabel.text = "이메일을 입력해주세요."
                       pwdCk = false
                    }
                    else {
                        alertLabel.isHidden = true
                        emailCk = true
                        pwdCk = true
                        alertLabel.isHidden = true
                        loginBtn.isEnabled = true
                        loginBtn.configuration?.background.backgroundColor = .BtnColor
                        loginBtn.configuration?.attributedTitle?.foregroundColor = .WhiteTextColor
                    }
                    
                    if text.count >= maxLength {
                                      let index = text.index(text.startIndex, offsetBy: maxLength)
                                      let newString = text[text.startIndex..<index]
                                      textField.text = String(newString)
                                  }
                 
                }
            }
        }
    
    
    @objc func TextFieldChange (_ sender: UITextField) { //버튼 활성화, 비활성화 설정
        
        if !(emailField.text!.isEmpty) && !(passwordField.text!.isEmpty) && emailCk && pwdCk{ //비밀번호, 이메일 확인되면 버튼 활성화
            alertLabel.isHidden = true
            loginBtn.isEnabled = true
            loginBtn.configuration?.background.backgroundColor = .BtnColor
            loginBtn.configuration?.attributedTitle?.foregroundColor = .WhiteTextColor
            
        } else {
            loginBtn.isEnabled = false
            loginBtn.configuration?.background.backgroundColor = .OriginBtnColor
            loginBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
        }
    }
    
    //return시 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder() // TextField 비활성화
           return true
       }
    
    
    @objc func keyboardWillshow(notification: NSNotification) {
        //키보드 값 가져오기 (옵셔널 값)
        if self.view.frame.origin.y == 0 {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]as? NSValue)?.cgRectValue {
            
            if(keyboardSize.height < loginBtn.frame.origin.y) { //키보드가 버튼을 덮는 경우 화면 올릴 값을 구함(distance)
                let distance = keyboardSize.height - loginBtn.frame.height
                self.view.frame.origin.y -= distance
            }
        }
    }

    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
        self.view.frame.origin.y = 0
        }
    }
    

}

