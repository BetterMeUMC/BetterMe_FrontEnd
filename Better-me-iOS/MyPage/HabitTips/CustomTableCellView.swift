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
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let title = UILabel()
    private let imageView = UIImageView()
    func setUI(with string: String, image: UIImage) {
        title.text = string
        title.textAlignment = .left
        title.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        title.numberOfLines = 1
        imageView.image = image
    }
    
    func commonInit() {
        addSubview(title)
        addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -10).isActive = true

        title.leadingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor,constant: 20).isActive = true
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
    private let imageView = UIImageView()

    func setUI(with string: String, image: UIImage) {
        title.text = string
        title.textAlignment = .left
        title.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)
        title.numberOfLines = 15
        imageView.image = image
    }
    
    func commonInit() {
        addSubview(title)
        addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -10).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        title.leadingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
