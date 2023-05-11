//
//  AwardViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/04/12.
//

import UIKit

class AwardViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var personalMessage: UILabel!
    let userName = "폴"
    let numberOfAward = 20
    let message = "아자아자 화이팅"
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "\(userName) 님은 \n \(numberOfAward)개의 상장을 받았어요."
        personalMessage.text = message
        personalMessage.layer.cornerRadius = 20.5
        personalMessage.layer.masksToBounds = true
    }

}
class AwardViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
}


extension AwardViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // Return the number of cells you want to display
            return numberOfAward
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AwardViewCell", for: indexPath) as! AwardViewCell
        let img = UIImage(named: "AwardAward")
        cell.imageView?.image = img
            return cell
        }
        
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 93, height: 158)
//    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // Handle cell selection
        }

}

