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
    
    @IBOutlet weak var pwdBtn: UIButton!
    var loginCheck : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //키보드 메소드 호출
        
        //back title 지우기
        self.navigationController?.navigationBar.topItem?.title = ""
        
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
 
        addNaviBar()
        swipeRecognizer()
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

    @IBOutlet weak var item: UINavigationItem!
    private func addNaviBar() {

        // safe area
        
        var statusBarHeight: CGFloat = 0
        statusBarHeight = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0

        // navigationBar
        let naviBar = UINavigationBar(frame: .init(x: 0, y: statusBarHeight, width: view.frame.width, height: statusBarHeight))
        naviBar.isTranslucent = false
        naviBar.backgroundColor = .clear
        naviBar.shadowImage = UIImage()
        naviBar.tintColor = .black

        let naviItem = UINavigationItem(title: "")
   
        //우선 이미지로 대체
        let customImage = UIImage(named: "backIcon")
        let newWidth = 13
        let newHeight = 20
        let newImageRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        customImage?.draw(in: newImageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        naviItem.leftBarButtonItem = UIBarButtonItem(image: newImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapDoneButton))
        naviBar.items = [naviItem]
        view.addSubview(naviBar)
    }
    
    @objc func didTapDoneButton() {
        self.presentingViewController?.dismiss(animated: true)
    }
    func swipeRecognizer() {
          let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
          swipeRight.direction = UISwipeGestureRecognizer.Direction.right
          self.view.addGestureRecognizer(swipeRight)
          
      }
      
      @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
          if let swipeGesture = gesture as? UISwipeGestureRecognizer {
              switch swipeGesture.direction{
              case UISwipeGestureRecognizer.Direction.right:
                  // 스와이프 시, 원하는 기능 구현.
                  self.dismiss(animated: true, completion: nil)
              default: break
              }
          }
      }

    
    var emailCk : Bool = false
    var pwdCk : Bool = true
    
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
    

    
    @IBAction func loginBtn(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        
        PostLogin(email: email, password: password)
    
    }
    
    func PostLogin(email: String, password: String) {
        let url = "http://54.180.13.219:3000/app/auth/login"
        
        let params = ["email": email, "password": password]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate()
            .responseDecodable(of: LoginModel.self) { response in
                switch response.result {
                case .success(let response):
             
                    if let jwt = response.result?.jwt {
                        self.loginCheck = true
                        self.performSegue(withIdentifier: "tabBar", sender: self)
          
                    } else {
                        print("토큰 없음")
                            self.alertLabel.isHidden = false
                            self.alertLabel.text = response.message
                            self.loginBtn.isEnabled = false
                            self.loginBtn.configuration?.background.backgroundColor = .OriginBtnColor
                            self.loginBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
                        self.loginCheck = false
                    }
                case .failure(let error):
                    print("서버오류")
                    print(error)
                }
                
            }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "tabBar" {
            if loginCheck {
                self.performSegue(withIdentifier: "tabBar", sender: nil)
            } else {
                return false
            }
        }
        return true
    }
    
    
    
    @IBAction func passwordFindBtn(_ sender: Any) {
                                      
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "passwordFindViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
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

