//
//  FeedBackController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/01/30.
//

import UIKit

class FeedBackController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    
    
    let button : UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1).cgColor
        
        view.setTitle("보내기", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1), for: .normal)
        
        
        return view
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
        configureButtonUI()
        
        titleTextField.clearsOnBeginEditing = true
        contentTextField.clearsOnBeginEditing = true
    }
    //MARK: - Helpers
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "피드백 작성하기"
    }
    
    func configureButtonUI() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -104),
                                     button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
                                     button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
                                     button.heightAnchor.constraint(equalToConstant: 43)])
    }

}
