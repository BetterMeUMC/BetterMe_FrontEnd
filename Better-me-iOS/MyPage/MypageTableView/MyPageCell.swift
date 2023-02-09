//
//  MyPageCell.swift
//  Better-me
//
//  Created by Phil on 2023/01/15.
//

import UIKit

class MyPageCell: UITableViewCell {
    
    
    //MARK: - Properties
    let menuLabel = UILabel()
    
    //MARK: - Lifecyle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init? (coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configureUI() {
        addSubview(menuLabel)
        menuLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuLabel.centerYAnchor.constraint (equalTo: centerYAnchor),
            menuLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 19)])
    }
    
    

    
}
