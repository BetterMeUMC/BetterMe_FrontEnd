//
//  DeleteAlertViewController.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/18.
//

import UIKit

protocol AlertViewControllerDelegate: AnyObject {
    func didSelectDelete()
}

class AlertViewController: UIViewController{
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var habitLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    weak var delegate: AlertViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCustomAlertView()
        self.changeTextColor()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    var alertName: String = ""
    var habitName: String = ""
    var contents: String = ""
    private func setCustomAlertView() {
        self.alertView.layer.cornerRadius = 20
        self.alertView.backgroundColor = .white
        self.alertLabel.text = self.alertName
        self.habitLabel.text = "[\(self.habitName)]"
        self.contentsLabel.text = self.contents
        
        /// 취소 버튼 둥글기 적용 및 폰트 설정
        self.cancelButton.layer.cornerRadius = 18
        self.cancelButton.layer.borderColor = UIColor(red: 251/255, green: 20/255, blue: 0/255, alpha: 1.0).cgColor
        self.cancelButton.layer.borderWidth = 1.5
        
        /// 확인 버튼 둥글기 적용 및 폰트 설정
        self.confirmButton.layer.cornerRadius = 18
        self.confirmButton.layer.borderColor = UIColor(red: 251/255, green: 20/255, blue: 0/255, alpha: 1.0).cgColor
        self.cancelButton.layer.borderWidth = 1.5
    }
    private func changeTextColor() {
        guard let text = self.habitLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "["))
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "]"))
        self.habitLabel.attributedText = attributeString
        
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tapConfirmButton(_ sender: UIButton) {
        self.delegate?.didSelectDelete()
        self.dismiss(animated: true)
    }
}
