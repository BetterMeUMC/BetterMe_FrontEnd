//
//  nicknameViewController.swift
//  login
//
//  Created by 심윤주 on 2023/01/16.
//

import UIKit

class nicknameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var okBtn: UIButton!{
        didSet {
            okBtn.isEnabled = false
        }
    }
    
    @IBOutlet weak var checkLabel: UILabel!{
        didSet {
            checkLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var nickName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickName.borderAttribute()
        nickName.addLeftPadding()
        
        self.hideKeyboardWhenTappedAround()

        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        nickName.delegate = self
   
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: nickName)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //noti등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //noti해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func NextViewOkBtn(_ sender: Any) {
        let user = UserInfo.shared
        user.nickName = nickName.text
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "wordViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
    
    @objc private func textDidChange(_ notification: Notification) {
        let maxLength = 20
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {
                        // 8글자 넘어가면 자동으로 키보드 내려감
                        checkLabel.isHidden = false
                        checkLabel.text = "닉네임은 최대 20자리를 입력해주세요."
                        okBtn.isEnabled = false
                        okBtn.configuration?.background.backgroundColor = .OriginBtnColor
                        okBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
                    }
                    else if text.count == 0 {
                        checkLabel.isHidden = false
                        checkLabel.text = "닉네임을 입력해주세요."
                        okBtn.configuration?.background.backgroundColor = .OriginBtnColor
                        okBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
                        okBtn.isEnabled = false
                    }
                    else if !text.isEmpty && text.count < 21 { //닉네임 비어있지 않고 21자 미만이면
                        okBtn.isEnabled = true
                        checkLabel.isHidden = true
                        okBtn.configuration?.background.backgroundColor = .BtnColor
                        okBtn.configuration?.attributedTitle?.foregroundColor = .WhiteTextColor
                    } else {
                        okBtn.configuration?.background.backgroundColor = .OriginBtnColor
                        okBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
                        okBtn.isEnabled = false
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
                let distance = keyboardSize.height - okBtn.frame.height
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
