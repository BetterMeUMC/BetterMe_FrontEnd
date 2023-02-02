//
//  GoodTipsCell.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/02.
//

import UIKit

class TipsCell: UITableViewCell {

    @IBOutlet weak var tipsListTitle: UILabel!
    
    @IBAction func toggleBtn(_ sender: Any) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
