
//  Created by Phil on 2023/01/15.
//

import UIKit

class MyPageTableFooterView: UIView {
    
    //MARK: - Properties
    
    let button : UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1).cgColor
        
        view.setTitle("로그아웃", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1), for: .normal)
        
        
        
        return view
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
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: topAnchor, constant: 13),
                                     button.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
                                     button.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
                                     button.heightAnchor.constraint(equalToConstant: 43)])
    }
    
    
    
}
