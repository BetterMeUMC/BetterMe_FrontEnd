//
//  HeaderView.swift
//  Better-me
//
//  Created by Phil on 2023/01/15.
//

import UIKit


class MyPageTableHeaderView: UIView {
    
    //MARK: - Properties
    let headLabel : UILabel = {
        let view = UILabel()
        view.text = "Tips!"
        view.frame = CGRect(x: 0, y: 0, width: 37, height: 25)
        view.textColor = UIColor(red: 1, green: 0.478, blue: 0.433, alpha: 1)
        view.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        return view
    }()
    
    
    lazy var button1 : UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.925, blue: 0.921, alpha: 1)
        view.layer.cornerRadius = 23
        view.setTitle("좋은 습관 \n잘 만드는 법", for: .normal)
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(.black, for: .normal)

        return view
    }()
    
    
    let button2 : UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.925, blue: 0.921, alpha: 1)
        view.layer.cornerRadius = 23
        view.setTitle("나쁜습관 \n쉽게 없애는 법", for: .normal)
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.numberOfLines = 2
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLabel()
        configureButton()
    }
    required init?(coder:NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureLabel() {
        
        addSubview(headLabel)
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        headLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14).isActive = true
        headLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 19).isActive = true
        
    }
    func configureButton() {
    
        addSubview(button1)
        button1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button1.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 22),
                                     button1.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
                                     button1.widthAnchor.constraint(equalToConstant: 155),
                                     button1.heightAnchor.constraint(equalToConstant: 90)])
        
        
        addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button2.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 22),
                                     button2.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
                                     button2.widthAnchor.constraint(equalToConstant: 155),
                                     button2.heightAnchor.constraint(equalToConstant: 90)])
    }
    

    
}
