//
//  AwardImageViewController.swift
//  Better-me-iOS
//
//  Created by 염승범 on 2023/02/15.
//

import UIKit

class AwardImageViewController:UIViewController{
    // MARK: @IBOutlet
    @IBOutlet weak var AwardImg: UIImageView!
    @IBOutlet weak var AwardNameLabel: UILabel!
    @IBOutlet weak var SecondTitleLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var AwardInfoLabel: UILabel!
    @IBOutlet weak var SecAwardNameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var NowDateLabel: UILabel!
    @IBOutlet weak var BetterMeLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureAwardNameViewUI()

        configureAwardImgViewUI()

    }
    func parentDo(Entity:UILabel, Width:CGFloat, Height:CGFloat, X:CGFloat , Y:CGFloat )->Void{
        let parent = Entity
        view.addSubview(Entity)
        //view.bringSubviewToFront(parent)
        Entity.translatesAutoresizingMaskIntoConstraints = false
        Entity.widthAnchor.constraint(equalToConstant: Width).isActive = true
        Entity.heightAnchor.constraint(equalToConstant: Height).isActive = true
        Entity.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: X).isActive = true
        Entity.topAnchor.constraint(equalTo: parent.topAnchor, constant: Y).isActive = true
        
        
    }
    func configureAwardImgViewUI(){
        let image0 = self.AwardImg
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
 }
    func configureAwardNameViewUI(){
        view.backgroundColor = .white

        AwardNameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        SecondTitleLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        NameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        AwardInfoLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        SecAwardNameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        DateLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        NowDateLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        BetterMeLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 13)
        AwardInfoLabel.numberOfLines = 3


        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineHeightMultiple = 1.17
        AwardNameLabel.attributedText = NSMutableAttributedString(string: "상장명 : 일어나자마자 이불개기😎 ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        SecondTitleLabel.attributedText = NSMutableAttributedString(string: "부문 : 좋은 습관 만들기", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        NameLabel.attributedText = NSMutableAttributedString(string: "이름 : 김유니", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        AwardInfoLabel.attributedText = NSMutableAttributedString(string: "위 사람은 긴 기간동안 성실하게 정진하여\n다음과 같은 훌륭한 습관을 형성하였으므로\n이 상장을 수여하여 칭찬합니다.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        SecAwardNameLabel.attributedText = NSMutableAttributedString(string: "[ 일어나자마자 이불개기 ]", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        DateLabel.attributedText = NSMutableAttributedString(string: "2022.01.01 ~ 2022.01.22", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        NowDateLabel.attributedText = NSMutableAttributedString(string: "2023.02.16", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        BetterMeLabel.attributedText = NSMutableAttributedString(string: "Better me", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        //parentDo(Entity: AwardNameLabel, Width: 174, Height: 18, X: 56, Y: 248)

    }
}
