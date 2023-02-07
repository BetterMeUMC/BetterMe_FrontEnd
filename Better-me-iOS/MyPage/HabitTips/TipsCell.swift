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
        settingData(isClicked)
        
    }

    @IBOutlet weak var tipsContentHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        settingData(false)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func settingData(_ isClicked : Bool)
    
    {
        if isClicked == true
        {

            self.tipsContent.isHidden = false
            self.tipsListTitle.textColor = .black
            self.toggleBtn.tintColor = .black

        }
        else
        {
            self.tipsContent.isHidden = true
            self.tipsListTitle.textColor = .gray
            self.toggleBtn.tintColor = .gray

        }
    }

}

