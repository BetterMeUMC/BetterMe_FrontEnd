//
//  wordViewController.swift
//  login
//
//  Created by 심윤주 on 2023/01/17.
//

import UIKit

class wordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var wordField: UITextField!
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
    
    var checkUserInfo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordField.borderAttribute()
        wordField.addLeftPadding()
       
        self.hideKeyboardWhenTappedAround()

        self.navigationController?.navigationBar.topItem?.title = ""
        
        wordField.delegate = self
        
        //행간
        let attrString = NSMutableAttributedString(string: wordLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        wordLabel.attributedText = attrString
        
        NotificationCenter.default.addObserver(self,
                                                       selector: #selector(textDidChange(_:)),
                                                       name: UITextField.textDidChangeNotification,
                                                       object: wordField)
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
    
    @IBAction func nextViewBtn(_ sender: Any) {
        let user = UserInfo.shared
        user.promise = wordField.text
        if let email = user.email, let password = user.password, let nickname = user.nickName, let promise = user.promise {
            PostDataManager().PostUserData(email: email, password: password, nickName: nickname, promise: promise)
            checkUserInfo = true
            //다음 뷰
            self.performSegue(withIdentifier: "tabView", sender: nil)
        } else {
            print("data is nil")
            checkUserInfo = false
        }
        
        /*sns로그인 관련 포스트할 정보들
        if let email = SnsUser.email
         */
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "nickNameView" {
            if checkUserInfo {
                self.performSegue(withIdentifier: "tabView", sender: nil)
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
    
    @objc private func textDidChange(_ notification: Notification) {
        let maxLength = 30
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {
                        // 8글자 넘어가면 자동으로 키보드 내려감
                        checkLabel.isHidden = false
                        checkLabel.text = "한줄다짐은 최대 30자 이내로 입력해주세요."
                        okBtn.isEnabled = false
                        okBtn.configuration?.background.backgroundColor = .OriginBtnColor
                        okBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
                    }
                    else if text.count == 0 {
                        checkLabel.isHidden = false
                        checkLabel.text = "한줄다짐을 입력해주세요."
                        okBtn.configuration?.background.backgroundColor = .OriginBtnColor
                        okBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
                        okBtn.isEnabled = false
                    }
                    else if !text.isEmpty && text.count < 30 { //비어있지 않고 21자 미만이면
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
        
        //self.view.frame.origin.y = -100
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
        self.view.frame.origin.y = 0
        }
    }

}
