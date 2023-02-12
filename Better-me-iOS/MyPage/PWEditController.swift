//
//  File.swift
//  Better-me
//
//  Created by Phil on 2023/01/16.
//

import UIKit

class PWEditController: UIViewController{
    //MARK: - Properties

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var checkLabel: UILabel! {
        didSet {
            checkLabel.isHidden = true
        }
    }

    let saveBtn : UIBarButtonItem = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.906, green: 0.906, blue: 0.906, alpha: 1)
        view.layer.cornerRadius = 15
        view.setTitle("저장", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 55),
            view.heightAnchor.constraint(equalToConstant: 31)])
        
        view.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
        return UIBarButtonItem(customView: view)
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
        textFieldCustom(textField:passwordField)
        textFieldCustom(textField:passwordCheckField)
        
        
      
        passwordField.textContentType = .newPassword
        passwordCheckField.textContentType = .newPassword
        
        self.passwordField.addTarget(self, action: #selector(self.TextFieldChange(_:)), for: .editingChanged)
        self.passwordCheckField.addTarget(self, action: #selector(self.TextFieldChange(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PasswordTextDidChange(_:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: passwordField)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PasswordTextDidChange(_:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: passwordCheckField)
        
    }

    
    //MARK: - Helpers
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "비밀번호 변경"
        self.navigationItem.rightBarButtonItem = self.saveBtn
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
    func textFieldCustom (textField: UITextField) {
       
        textField.layer.cornerRadius = 17
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.679, green: 0.679, blue: 0.679, alpha: 1).cgColor
        textField.textAlignment = .center
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
     
          self.view.endEditing(true)
     
    }
    
   
    @objc func saveBtnClicked(_sender: UIButton) {
        UserDataManager().patchPassword(password: passwordField.text!, viewController: self)
    
        passwordField.text = ""
        passwordCheckField.text = ""
    }
    
    func isSameBoth(_ first: UITextField, _ second: UITextField) -> Bool { //비번 일치 확인
        if(first.text == second.text) {
            return true
        } else {
            return false
        }
    }
    
    func isValidPassword(str:String) -> Bool {
        let passwordEx = "^[A-Za-z0-9.-]{6,20}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordEx).evaluate(with: str)
    }
    
    @objc func TextFieldChange (_ sender: UITextField) { //버튼 활성화, 비활성화 설정
        
        if (isValidPassword(str: passwordField.text!)) && (isSameBoth(passwordField, passwordCheckField)) &&  passwordField.text!.count < 21 { //비밀번호, 이메일 확인되면 버튼 활성화
            
            saveBtn.isEnabled = true
            saveBtn.customView?.backgroundColor = .BtnColor
            saveBtn.customView?.tintColor = .WhiteTextColor

        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordField {
            passwordField.isSecureTextEntry = true
            passwordField.textContentType = .newPassword
        }
        
        else if textField == passwordCheckField {
            passwordCheckField.isSecureTextEntry = true
            passwordCheckField.textContentType = .newPassword
        }
        return true
    }
    
    @objc private func PasswordTextDidChange(_ notification: Notification) {
        let maxLength = 20
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {

                        checkLabel.isHidden = false
                        checkLabel.text = "비밀번호는 20자 미만으로 입력해주세요."
                    }
                    
                    else if !isSameBoth(passwordField, passwordCheckField) { //비번 불일치
                         checkLabel.isHidden = false
                         checkLabel.text = "비밀번호와 비밀번호 재입력이 일치하지 않습니다."
                     }
                    else if !isValidPassword(str: passwordField.text!) { //비번 유효성
                         checkLabel.text = "비밀번호 규칙을 확인해주세요."
                         checkLabel.isHidden = false
                     }
                     else if !(isValidPassword(str: passwordField.text!)) && !(isSameBoth(passwordField, passwordCheckField)){ //비번 유효성, 불일치 틀릴 경우
                         checkLabel.text = "비밀번호 규칙을 확인해주세요."
                         checkLabel.isHidden = false
                     }
  
                     else {
                         checkLabel.isHidden = true
                     }
                    if text.count >= maxLength {
                                      let index = text.index(text.startIndex, offsetBy: maxLength)
                                      let newString = text[text.startIndex..<index]
                                      textField.text = String(newString)
                                  }
                 
                }
            }
        }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder() // TextField 비활성화
           return true
       }

    
}
