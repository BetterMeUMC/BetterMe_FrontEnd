//
//  AddGoodHabitViewController.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/09.
//

import UIKit

protocol AddGoodHabitViewDelegate: AnyObject {
    func didSelectRegister(habit: Habit)
}

class AddGoodHabitViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var inviteTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    @IBOutlet weak var emojiTextField: UITextField!
    weak var delegate: AddGoodHabitViewDelegate?
    private var todayDate: Date?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureEmojiTextField()
        self.configureTitleTextField()
        self.configureContentsTextView()
        self.configureInviteTextField()
        self.confirmButton.isEnabled = false
        self.emojiTextField.delegate = self
        self.navigationController?.navigationBar.tintColor = .black
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange(_:)),
            name: UITextField.textDidChangeNotification,
            object: self.emojiTextField
        )
        self.todayDate = Date()
    }
    let grayColor: UIColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1.0)
    
    private func configureEmojiTextField() {
        self.emojiTextField.font = .systemFont(ofSize: 28)
        self.emojiTextField.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        self.emojiTextField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.5, height: 0.0))
        self.emojiTextField.leftViewMode = .always
        self.emojiTextField.tintColor = UIColor.clear
        self.emojiTextField.layer.cornerRadius = 5.0
        self.emojiTextField.layer.borderWidth = 0.0
        self.emojiTextField.layer.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0).cgColor
        self.emojiTextField.attributedPlaceholder = NSAttributedString(string: "⊕", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    }
    
    private func configureTitleTextField() {
        let borderColor = self.grayColor
        self.titleTextField.layer.borderColor = borderColor.cgColor
        self.titleTextField.layer.borderWidth = 1.0
        self.titleTextField.layer.cornerRadius = 5.0
    }
    
    private func configureContentsTextView() {
        self.contentsTextView.delegate = self
        let borderColor = self.grayColor
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 1.0
        self.contentsTextView.layer.cornerRadius = 5.0
        self.contentsTextView.text = "습관 내용을 입력해주세요."
        self.contentsTextView.textColor = self.grayColor
        self.contentsTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15);
    }
    private func configureInviteTextField() {
        let borderColor = self.grayColor
        self.inviteTextField.layer.borderColor = borderColor.cgColor
        self.inviteTextField.layer.borderWidth = 1.0
        self.inviteTextField.layer.cornerRadius = 5.0
    }
    
    
    private func configureInputField() {
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
    }
    

    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                print(text.count)
                if text.count > 0 {
                    self.emojiTextField.resignFirstResponder()
                }
                if text.count >= 1 {
                    let index = text.index(text.startIndex, offsetBy: 1)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.contentsTextView.resignFirstResponder()
    }
    
    private func validateInputField() {
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.contentsTextView.text?.isEmpty ?? true) && !(self.emojiTextField.text?.isEmpty ?? true)
    }
    
    @IBAction func tapSearchButton(_ sender: UIButton) {
        guard let modalViewController = self.storyboard?.instantiateViewController(identifier: "SearchFriendViewController") as? SearchFriendViewController else { return }
        modalViewController.definesPresentationContext = true
        modalViewController.modalPresentationStyle = .overFullScreen
        modalViewController.inviteText = self.inviteTextField.text ?? ""
        navigationController?.present(modalViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func tapConfirmButton(_ sender: UIButton) {
        guard let title = self.titleTextField.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let date = self.todayDate else { return }
        guard let emoji = self.emojiTextField.text else { return }
        let habit = Habit(title: title, emoji: emoji, contents: contents, hNum: 0, isCheck: false, date: date)
        self.delegate?.didSelectRegister(habit: habit)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AddGoodHabitViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.contentsTextView.text.isEmpty {
            self.contentsTextView.text =  "습관 내용을 입력해주세요."
            self.contentsTextView.textColor = self.grayColor
            
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.contentsTextView.textColor == self.grayColor {
            self.contentsTextView.text = nil
            self.contentsTextView.textColor = UIColor.black
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}

extension AddGoodHabitViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = self.emojiTextField.text else {return false}
        if text.count >= 1 {
            return false
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = self.emojiTextField.text {
            if text.count > 0 {
                self.emojiTextField.text = ""
            }
        }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.validateInputField()
    }
}
