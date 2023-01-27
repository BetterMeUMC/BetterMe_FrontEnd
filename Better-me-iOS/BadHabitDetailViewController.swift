//
//  GoodHabitDetailViewController.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/16.
//

import UIKit

protocol BadHabitDetailViewDelegate: AnyObject {
    func didBadSelectDelete(indexPath: IndexPath)
    func didBadSelectEdit(indexPath: IndexPath, habit: Habit)
}

class BadHabitDetailViewController: UIViewController {

    
    @IBOutlet weak var emojiTextField: EmojiTextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var inviteTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    weak var delegate: BadHabitDetailViewDelegate?
    var habit: Habit?
    var indexPath: IndexPath?
    var hNum: Int?
    var isCheck: Bool?
    var date: Date?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureEmojiTextField()
        self.configureTitleTextField()
        self.configureContentsTextView()
        self.configureInviteTextField()
        self.configureDeleteButton()
        self.emojiTextField.delegate = self
        self.navigationController?.navigationBar.tintColor = .black
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange(_:)),
            name: UITextField.textDidChangeNotification,
            object: self.emojiTextField
        )
    }
    
    private func configureView() {
        guard let habit = self.habit else { return }
        self.titleTextField.text = habit.title
        self.contentsTextView.text = habit.contents
        self.emojiTextField.text = habit.emoji
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
    
    private func configureDeleteButton() {
        self.deleteButton.tintColor = .black
        self.deleteButton.layer.addBorder([.top], color: UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0), width: 1.0)
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
        self.editButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.contentsTextView.text?.isEmpty ?? true) && !(self.emojiTextField.text?.isEmpty ?? true)
    }
    

    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let alertViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController else { return }
        alertViewController.alertName = "앗!"
        alertViewController.habitName = self.titleTextField.text ?? ""
        alertViewController.contents = "습관을 삭제하시겠습니까?"
        alertViewController.delegate = self
        alertViewController.definesPresentationContext = true
        alertViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.present(alertViewController, animated: false, completion: nil)
    }
    
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let indexPath = self.indexPath else { return }
        guard let title = self.titleTextField.text else { return }
        guard let emoji = self.emojiTextField.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let hNum = self.hNum else { return }
        guard let isCheck = self.isCheck else { return }
        guard let date = self.date else { return }
        let habit = Habit(title: title, emoji: emoji, contents: contents, hNum: hNum, isCheck: isCheck, date: date)
        self.delegate?.didBadSelectEdit(indexPath: indexPath, habit: habit)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tapSearchButton(_ sender: UIButton) {
        guard let modalViewController = self.storyboard?.instantiateViewController(identifier: "SearchFriendViewController") as? SearchFriendViewController else { return }
        modalViewController.definesPresentationContext = true
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.inviteText = self.inviteTextField.text ?? ""
        navigationController?.present(modalViewController, animated: true, completion: nil)
    }
}

extension BadHabitDetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.contentsTextView.text.isEmpty {
            self.contentsTextView.text =  "습관 내용을 입력해주세요."
            self.contentsTextView.textColor = self.grayColor
        } else {
            self.contentsTextView.textColor = UIColor.black
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
extension BadHabitDetailViewController: UITextFieldDelegate {
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

extension BadHabitDetailViewController: AlertViewControllerDelegate {
    func didSelectDelete(isDelete: Bool) {
        guard let indexPath = self.indexPath else { return }
        self.delegate?.didBadSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
}
