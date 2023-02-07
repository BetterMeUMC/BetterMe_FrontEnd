//
//  GoodTipsCell.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/02.
//

import UIKit

class TipsCell: UITableViewCell {
    let TVC = GoodHabitTipsViewController()
    @IBOutlet weak var tipsListTitle: UILabel!
    
    @IBOutlet weak var tipsContent: UILabel!
    var isClicked = false
    @IBOutlet weak var toggleBtn: UIButton!
    @IBAction func toggleBtn(_ sender: Any) {
        isClicked = !isClicked
        TVC.settingData(isClicked,cell: self)
        
    }

    @IBOutlet weak var tipsContentHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
   

}

