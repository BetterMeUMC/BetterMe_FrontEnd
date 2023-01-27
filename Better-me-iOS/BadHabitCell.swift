//
//  BadHabitCell.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/16.
//

import UIKit



protocol BadHabitCellDelegate: AnyObject {
    func didBadSelectIsCheck(indexPath: IndexPath, completion: Int, isCheck: Bool)
}

class BadHabitCell: UICollectionViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var completionProgressView: UIProgressView!
    @IBOutlet weak var isCheckButton: UIButton!
    
    weak var delegate: BadHabitCellDelegate?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    var isCheck: Bool = false
    var completion: Int = 0
    var indexPath: IndexPath?
    @IBAction func tapIsCheckButton(_ sender: UIButton) {
        isCheck = !isCheck
        if isCheck {
            self.completion += 1
            self.completionLabel.text = "\(self.completion)/30"
            self.isCheckButton.setImage(UIImage(named: "IsCheckImage"), for: .normal)
            guard let indexPath = self.indexPath else { return }
            guard let completion = self.completion as? Int else { return }
            guard let isCheck = self.isCheck as? Bool else { return }
            self.delegate?.didBadSelectIsCheck(indexPath: indexPath, completion: completion, isCheck: isCheck)
        } else {
            self.completion -= 1
            self.completionLabel.text = "\(self.completion)/30"
            self.isCheckButton.setImage(UIImage(named: "IsCheckBackground"), for: .normal)
            guard let indexPath = self.indexPath else { return }
            guard let completion = self.completion as? Int else { return }
            guard let isCheck = self.isCheck as? Bool else { return }
            self.delegate?.didBadSelectIsCheck(indexPath: indexPath, completion: completion, isCheck: isCheck)
        }
        self.completionProgressView.progress = Float(completion) / 30
    }
}
