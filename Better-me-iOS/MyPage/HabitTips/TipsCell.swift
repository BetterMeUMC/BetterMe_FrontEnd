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

    func setUI(with index: Int) {
        cellView.setUI(with: Constants.tipsTitle[index],
                       image: UIImage(named: "YellowStar") ?? UIImage())
        detailView.setUI(with: TDB.getTips(index: index),
                         image: UIImage(named: "image 122") ?? UIImage())
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
    }

    func hideDetailView() {
        detailView.isHidden = true
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

    
   



