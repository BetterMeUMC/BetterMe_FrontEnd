//
//  WithdrawalViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit


class WithdrawalViewController: UIViewController {

    //MARK: - Properties
    
    let handImageView : UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "image 123")
       
        return aImageView
    }()
    
    let label = UILabel()
    
    let  yesButton : UIButton = {
        let view = UIButton()
        view.backgroundColor = .red
        view.layer.cornerRadius = 22
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1).cgColor
        
        view.setTitle("네! 다음에 봐요", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(.white, for: .normal)
        
        view.addTarget(self, action: #selector(yesClicked), for: .touchUpInside)
        
        return view
    }()
    
    let  noButton : UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1).cgColor
        
        view.setTitle("아니요, 계속 사용할래요", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1), for: .normal)
        
        view.addTarget(self, action: #selector(noClicked), for: .touchUpInside)
        
        return view
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
        configureUI()
        configureButtonUI()
        
    }
    //MARK: - Helpers
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "회원탈퇴"
    }
    
    func configureUI() {
        view.addSubview(handImageView)
        handImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([handImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 178),
                                     handImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     handImageView.widthAnchor.constraint(equalToConstant: 71),
                                     handImageView.heightAnchor.constraint(equalToConstant: 71)])
        
        
        label.text = " 이때까지 정말로 감사했어요! \n정말로 회원탈퇴 하시겠습니까?"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.widthAnchor.constraint(equalToConstant: 257),
                                     label.heightAnchor.constraint(equalToConstant: 50),])
    }
    
    func configureButtonUI() {
        view.addSubview(yesButton)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([yesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -186),
                                     yesButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
                                     yesButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
                                     yesButton.heightAnchor.constraint(equalToConstant: 43)])
        
        view.addSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([noButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -104),
                                     noButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
                                     noButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
                                     noButton.heightAnchor.constraint(equalToConstant: 43)])
    }
    @objc func yesClicked ( _ sender : UIButton) {
        UserDataManager().deleteAccount(viewController: self)
    }
    @objc func noClicked ( _ sender : UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
     
          self.view.endEditing(true)
     
    }

}
