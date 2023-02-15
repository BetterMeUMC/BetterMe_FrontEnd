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
    
    @IBOutlet weak var switchView: UISwitch!
    
    var index:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchView.isOn = false
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        let switchTag = self.index
            let switchState = sender.isOn

            switch switchTag {
            case 0:
                if switchState {
                    print("Switch 1 is on")
                    NotificationManager().patchHabitCheckOn()
                } else {
                    print("Switch 1 is off")
                    NotificationManager().patchHabitCheckOff()
                }
            case 1:
                if switchState {
                    print("Switch 2 is on")
                    NotificationManager().patchHabitInviteCheckOn()
                } else {
                    print("Switch 2 is off")
                    NotificationManager().patchHabitInviteCheckOff()
                }
            case 2:
                if switchState {
                    print("Switch 3 is on")
                } else {
                    print("Switch 3 is off")
                }
            case 3:
                if switchState {
                    print("Switch 4 is on")
                } else {
                    print("Switch 4 is off")
                }
            // add more cases for each switch
            default:
                break
            }

        }
}
