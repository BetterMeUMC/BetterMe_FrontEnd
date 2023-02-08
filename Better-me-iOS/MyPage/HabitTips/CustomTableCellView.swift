//
//  File.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/08.
//

import UIKit

final class CustomTableCellView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        btnImageView.image = UIImage(named: "arrowtriangle.down.fill")
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title = UILabel()
    private let imageView = UIImageView()
    let btnImageView = UIImageView()
    
    func setUI(with string: String, image: UIImage) {
        title.text = string
        title.textColor = .gray
        title.textAlignment = .left
        title.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        title.numberOfLines = 1
        imageView.image = image
        
    }
    
    func commonInit() {
        addSubview(title)
        addSubview(imageView)
        addSubview(btnImageView)
        
        imageView.widthAnchor.constraint(equalToConstant: 21).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 21).isActive = true
        btnImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        btnImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        btnImageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -10).isActive = true
        
        btnImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        btnImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        btnImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 30).isActive = true
        
        title.leadingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor,constant: 15).isActive = true
    }
}

final class CustomTableDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let title = UILabel()

    func setUI(with string: String) {
        title.text = string
        title.textAlignment = .left
        title.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)
        title.numberOfLines = 15
        title.backgroundColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)
    }
    
    func commonInit() {
        addSubview(title)

        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.topAnchor,constant: 50).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 30).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -30).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
