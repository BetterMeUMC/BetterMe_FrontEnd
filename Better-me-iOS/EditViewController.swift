//
//  EditViewController.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/02/03.
//

import UIKit

protocol EditViewDelegate: AnyObject {
    func didCheckDelete()
    func didCheckEdit()
    func didCancel()
}

class EditViewController: UIViewController {

    
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    weak var delegate: EditViewDelegate?
    
    var habitTitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureButton()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    private func configureButton() {
        self.editView.backgroundColor = .white
        self.editView.layer.cornerRadius = 27.0
        self.editButton.layer.cornerRadius = 22.0
        self.deleteButton.layer.cornerRadius = 22.0
        self.editButton.layer.borderWidth = 1.5
        self.editButton.layer.borderColor = UIColor(red: 251/255, green: 20/255, blue: 0/255, alpha: 1.0).cgColor
        self.cancelButton.layer.addBorder([.top], color: UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0), width: 1.0)
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        self.delegate?.didCheckEdit()
        self.dismiss(animated: true)
    }
    
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.didCancel()
        self.dismiss(animated: true)
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        self.delegate?.didCheckDelete()
        self.dismiss(animated: true)
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.delegate?.didCancel()
        self.dismiss(animated: true)
    }
}

extension EditViewController: AlertViewControllerDelegate {
    func didSelectDelete() {
        self.delegate?.didCheckDelete()
        self.navigationController?.popViewController(animated: true)
    }
}
