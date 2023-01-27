//
//  LoginFirstViewController.swift
//  login
//
//  Created by 심윤주 on 2023/01/10.
//

import UIKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //noti등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //noti해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}

