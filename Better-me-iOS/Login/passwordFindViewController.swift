//
//  passwordFindViewController.swift
//  login
//
//  Created by 심윤주 on 2023/01/12.
//

import UIKit

class passwordFindViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var sendPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        //행간
        let attrString = NSMutableAttributedString(string: comment.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        comment.attributedText = attrString
        
        emailField.borderAttribute()
        emailField.addLeftPadding()
        
        self.hideKeyboardWhenTappedAround() //키보드 내리기
        
        emailField.delegate = self
        self.emailField.addTarget(self, action: #selector(self.TextFieldChange(_:)), for: .editingChanged)

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
    
    @IBAction func sendAction(_ sender: Any) {
        let emailValue = emailField.text!
        GetMsgDataManager().checkIdx(userEmail: emailValue, viewController: self)

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
    
    
    @objc func TextFieldChange (_ sender: UITextField) { //버튼 활성화, 비활성화 설정
        
        if !(emailField.text!.isEmpty) { //이메일 확인되면 버튼 활성화
         
            sendPasswordBtn.isEnabled = true
            sendPasswordBtn.configuration?.background.backgroundColor = .BtnColor
            sendPasswordBtn.configuration?.attributedTitle?.foregroundColor = .WhiteTextColor
            
        } else {
            sendPasswordBtn.isEnabled = false
            sendPasswordBtn.configuration?.background.backgroundColor = .OriginBtnColor
            sendPasswordBtn.configuration?.attributedTitle?.foregroundColor = .TextColor
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder() // TextField 비활성화
           return true
       }
    
    @objc func keyboardWillshow(notification: NSNotification) {
        //키보드 값 가져오기 (옵셔널 값)
        if self.view.frame.origin.y == 0 {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]as? NSValue)?.cgRectValue {
            
            if(keyboardSize.height < sendPasswordBtn.frame.origin.y) { //키보드가 버튼을 덮는 경우 화면 올릴 값을 구함(distance)
                let distance = keyboardSize.height - sendPasswordBtn.frame.height
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
