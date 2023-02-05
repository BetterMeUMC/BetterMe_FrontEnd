//
//  JoinViewController.swift
//  login
//
//  Created by 심윤주 on 2023/01/11.
//

import UIKit
import SwiftUI

class JoinViewController: UIViewController, UITextFieldDelegate {
    var EmailDuplicateMsg: String = ""
    var checkDuplicate: Bool = false
    var serverCheck: Bool = false
    
    @IBOutlet weak var joinComment: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var checkLabel: UILabel! {
        didSet {
            checkLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var okBtn: UIButton!{
        didSet {
            okBtn.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //back 지움
        self.navigationController?.navigationBar.topItem?.title = ""
   
        self.hideKeyboardWhenTappedAround()
        
        emailField.borderAttribute()
        passwordField.borderAttribute()
        passwordCheckField.borderAttribute()
        
        emailField.addLeftPadding()
        passwordField.addLeftPadding()
        passwordCheckField.addLeftPadding()
        
        //텍스트필드 delegate설정으로 return시 키보드 내려가도록 설정
        emailField.delegate = self
        passwordField.delegate = self
        passwordCheckField.delegate = self
        
        //string password 관련
     
            passwordField.textContentType = .newPassword
            passwordCheckField.textContentType = .newPassword
        
        
        //행간
        let attrString = NSMutableAttributedString(string: joinComment.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        joinComment.attributedText = attrString
        
        //텍스트 입력 감지
        self.emailField.addTarget(self, action: #selector(self.TextFieldChange(_:)), for: .editingChanged)
        self.passwordField.addTarget(self, action: #selector(self.TextFieldChange(_:)), for: .editingChanged)
        self.passwordCheckField.addTarget(self, action: #selector(self.TextFieldChange(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: emailField)
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(PasswordTextDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: passwordField)
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(PasswordTextDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: passwordCheckField)
        
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
    
    @IBAction func okBtn_next(_ sender: Any) {
        
        if checkDuplicate {
            print("중복입니다") //test
            checkLabel.isHidden = false
            checkLabel.text = EmailDuplicateMsg
            okBtn.configuration?.background.backgroundColor = .OriginBtnColor
            okBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
            okBtn.isEnabled = false
        } else {
            let user = UserInfo.shared
            user.email = emailField.text
            user.password = passwordField.text
            
            checkLabel.isHidden = true
            okBtn.isEnabled = true
            okBtn.configuration?.background.backgroundColor = .BtnColor
            okBtn.configuration?.attributedTitle?.foregroundColor = .WhiteTextColor
            self.performSegue(withIdentifier: "nickNameView", sender: nil)
    }
        if serverCheck {
            print("서버 오류입니다.")
        }
    }
    
    //유효성 검사
    func isSameBoth(_ first: UITextField, _ second: UITextField) -> Bool { //비번 일치 확인
        if(first.text == second.text) {
            return true
        } else {
            return false
        }
    }
    
    @objc func TextFieldChange (_ sender: UITextField) { //버튼 활성화, 비활성화 설정
        
        if (isValidPassword(str: passwordField.text!)) && (isSameBoth(passwordField, passwordCheckField)) && (isValidEmail(testStr: emailField.text!)) && emailField.text!.count < 31 && passwordField.text!.count < 21 { //비밀번호, 이메일 확인되면 버튼 활성화
            
            okBtn.isEnabled = true
            okBtn.configuration?.background.backgroundColor = .BtnColor
            okBtn.configuration?.attributedTitle?.foregroundColor = .WhiteTextColor
            
            let email = emailField.text!
            //이메일 중복검사
            GetMsgDataManager().duplicateEmail(checkEmail: email, viewController: self)
          
        } else {
            okBtn.configuration?.background.backgroundColor = .OriginBtnColor
            okBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
            okBtn.isEnabled = false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "nickNameView" {
            if !checkDuplicate {
                self.performSegue(withIdentifier: "nickNameView", sender: nil)
            } else {
                return false
            }
        }
        return true
    }
    
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
    
    func isValidEmail(testStr:String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,30}"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailTest.evaluate(with: testStr)
    }
    
    func isValidPassword(str:String) -> Bool { //비밀번호 유효성 검사
        let passwordEx = "^[A-Za-z0-9.-]{6,20}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordEx).evaluate(with: str)
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        let maxLength = 30
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {
                        // 8글자 넘어가면 자동으로 키보드 내려감
                        checkLabel.isHidden = false
                        checkLabel.text = "이메일은 30자리 미만으로 입력해주세요."
                    }
                    
                    else if !isValidEmail(testStr: emailField.text!) {
                        checkLabel.isHidden = false
                        checkLabel.text = "이메일 형식을 지켜주세요."
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
    
    @objc private func PasswordTextDidChange(_ notification: Notification) {
        let maxLength = 20
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {
                        // 8글자 넘어가면 자동으로 키보드 내려감
                       
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
                    else if !isValidEmail(testStr: emailField.text!) && isSameBoth(passwordField, passwordCheckField) {
                        checkLabel.text = "이메일 형식을 지켜주세요."
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
    
    
    //return시 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder() // TextField 비활성화
           return true
       }
    
    @objc func keyboardWillshow(notification: NSNotification) {
        //키보드 값 가져오기 (옵셔널 값)
        if self.view.frame.origin.y == 0 {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]as? NSValue)?.cgRectValue {
            
            if(keyboardSize.height < okBtn.frame.origin.y) { //키보드가 버튼을 덮는 경우 화면 올릴 값을 구함(distance)
                let distance = keyboardSize.height - (okBtn.frame.height + 10)
                self.view.frame.origin.y -= distance
                
                //distance만큼만 올리면 너무 위로 올라가기 때문에 버튼 height만큼 더해줘서 올라가는 값을 줄여준다
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
