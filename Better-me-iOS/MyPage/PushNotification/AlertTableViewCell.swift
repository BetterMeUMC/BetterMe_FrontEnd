//
//  AlertTableViewCell.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit

class AlertTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alertTitleLabel: UILabel!
    
    @IBOutlet weak var alertSubTitleLabel: UILabel!
    
    @IBOutlet weak var alertSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
