//
//  GoodTipsCell.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/02.
//

import UIKit

class TipsCell: UITableViewCell {
    private let containerView = UIStackView()
    private let cellView = CustomTableCellView()
    private let detailView = CustomTableDetailView()
    let TDB = TipsData()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
    }
    
    func setUI(with index: Int,_ tag: Int) {
        
        if tag == 1 {
            cellView.setUI(with: GConstants.tipsTitle[index],
                           image: UIImage(named: "YellowStar") ?? UIImage(),
                           btn: UIImage(systemName: "arrowtriangle.down.fill") ?? UIImage())
            detailView.setUI(with: TDB.getGoodTips(index: index))
        }
        else {
            cellView.setUI(with: BConstants.tipsTitle[index],
                           image: UIImage(named: "YellowStar") ?? UIImage(),
                           btn: UIImage(systemName: "arrowtriangle.down.fill") ?? UIImage())
            detailView.setUI(with: TDB.getBadTips(index: index))
        }
        
        
    }
    
    func commonInit() {
        selectionStyle = .none
        detailView.isHidden = true
        
        
        containerView.axis = .vertical
        
        contentView.addSubview(containerView)
        containerView.addArrangedSubview(cellView)
        containerView.addArrangedSubview(detailView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        cellView.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}

extension TipsCell {
    var isDetailViewHidden: Bool {
        return detailView.isHidden
    }
    
    func showDetailView() {
        detailView.isHidden = false
        cellView.title.textColor = .black
        cellView.btnImageView.tintColor = .black
    }
    
    func hideDetailView() {
        detailView.isHidden = true
        cellView.title.textColor = .gray
        cellView.btnImageView.tintColor = .gray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }
}






