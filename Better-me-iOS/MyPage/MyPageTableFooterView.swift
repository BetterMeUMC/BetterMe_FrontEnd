
//  Created by Phil on 2023/01/15.
//

import UIKit

class MyPageTableFooterView: UIView {

    //MARK: - Properties

    let button1 : UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1).cgColor
        
        view.setTitle("로그아웃", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1), for: .normal)
        
        view.addTarget(self, action: #selector(logOutButtonClicked), for: .touchUpInside)
        
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
        addSubview(button1)
        button1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button1.topAnchor.constraint(equalTo: topAnchor, constant: 13),
                                     button1.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
                                     button1.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
                                     button1.heightAnchor.constraint(equalToConstant: 43)])
    }
   @objc func logOutButtonClicked() {
       let alret = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
       let yes = UIAlertAction(title: "확인", style: .default, handler: nil)
       let no = UIAlertAction(title: "취소", style: .default, handler: nil)
       alret.addAction(yes)
       alret.addAction(no)
//       present(alret, animated: true, completion: nil)
    }

    
}
