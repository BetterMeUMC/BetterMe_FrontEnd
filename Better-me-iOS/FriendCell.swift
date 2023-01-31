//
//  FriendCell.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/11.
//

import UIKit

class FriendCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hNumLabel: UILabel!
    @IBOutlet weak var friendCellView: UIView!
    @IBOutlet weak var inviteButton: UIButton!
    @IBAction func tapInviteButton(_ sender: UIButton) {
        self.inviteButton.setImage(UIImage(named: "RequestButton"), for: .normal)
    }
}
