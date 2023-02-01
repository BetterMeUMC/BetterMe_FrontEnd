//
//  GoodHabitTipsViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit

class GoodHabitTipsViewController: UIViewController {


    //MARK: - Properties
    
    let handImageView : UIImageView = {
        let aImageView = UIImageView()
        aImageView.image = UIImage(named: "image 123")
       
        return aImageView
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
        configureUI()
    }
    //MARK: - Helpers
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "좋은습관 잘 만드는 법"
    }
    func configureUI() {
        view.addSubview(handImageView)
        handImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([handImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 126),
                handImageView.widthAnchor.constraint(equalToConstant: 68),
                                     handImageView.heightAnchor.constraint(equalToConstant: 68)])
    }
    
}
