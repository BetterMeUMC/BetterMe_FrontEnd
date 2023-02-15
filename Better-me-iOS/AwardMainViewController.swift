//
//  AwardViewController.swift
//  Better-me-iOS
//
//  Created by 염승범 on 2023/01/31.
//

import UIKit

class AwardViewController:UIViewController{
    
    // MARK: IBOutlet
    @IBOutlet weak var HeadLabel: UILabel!
    @IBOutlet weak var OneLinerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureHeadLabelViewUI()
        configureOneLinerViewUI()

    }

    func configureHeadLabelViewUI(){
        view.backgroundColor = .white
        //self.HeadLabel.text = "김유니 님은 17개의 상장을 받으셨어요!"
        self.HeadLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        self.HeadLabel.numberOfLines = 2
        self.HeadLabel.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineHeightMultiple = 1.33
        
        let attrString = NSMutableAttributedString(string: HeadLabel.text!)
        self.HeadLabel.attributedText = attrString
        
        self.HeadLabel.attributedText = NSMutableAttributedString(string: "김유니 님은\n2개의 상장을 받으셨어요!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        let parent = self.HeadLabel!

        view.addSubview(HeadLabel)

        HeadLabel.translatesAutoresizingMaskIntoConstraints = false

        HeadLabel.widthAnchor.constraint(equalToConstant: 166).isActive = true

        HeadLabel.heightAnchor.constraint(equalToConstant: 55).isActive = true

        HeadLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 22).isActive = true

        HeadLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 61).isActive = true
    }
    func configureOneLinerViewUI(){
        view.backgroundColor = .white


        self.OneLinerLabel.textColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1)

        self.OneLinerLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)

        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.17
        self.OneLinerLabel.attributedText = NSMutableAttributedString(string: "“ 오늘보다 내일 더 빛나는 내가 되자 ”", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        let parent = self.OneLinerLabel!

        view.addSubview(OneLinerLabel)

        OneLinerLabel.translatesAutoresizingMaskIntoConstraints = false

        OneLinerLabel.widthAnchor.constraint(equalToConstant: 221).isActive = true

        OneLinerLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true

        OneLinerLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 77).isActive = true

        OneLinerLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 342).isActive = true
    }
    
}


