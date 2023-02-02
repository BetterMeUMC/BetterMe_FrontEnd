//
//  GoodTipsHeader.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/02.
//



import UIKit


class BadTipsHeader: UIView {
    
    //MARK: - Properties
    let handImageView : UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "image 121")
       
        return aImageView
    }()

    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    required init?(coder:NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        addSubview(handImageView)
        handImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([handImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     handImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     handImageView.widthAnchor.constraint(equalToConstant: 64),
                                     handImageView.heightAnchor.constraint(equalToConstant: 64)])
    }
    
}
