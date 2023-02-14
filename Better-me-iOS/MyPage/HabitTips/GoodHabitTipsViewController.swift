//
//  GoodHabitTipsViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit

class GoodHabitTipsViewController: UIViewController {
    
    
    //MARK: - Properties
    let tipsDB = TipsData()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
        
    }
    //MARK: - Helpers
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "좋은습관 쉽게 만드는 법"
    }
    
    
}
extension GoodHabitTipsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GConstants.tipsTitle.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //        return CGFloat(tipsDB.getNum(index: indexPath.row) * 70)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tipsDB.getGoodTipsNum(index: indexPath.row) * 70)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TipsCell", for: indexPath) as? TipsCell else { return UITableViewCell() }
        
        cell.setUI(with: indexPath.row,1)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TipsCell {
            cell.hideDetailView()
        }
    }
}
enum GConstants {
    static let tipsTitle = ["Tip 1 : 분명하게 만들어라",
                            "Tip 2 : 매력적으로 만들어라",
                            "Tip 3 : 하기 쉽게 만들어라",
                            "Tip 4 : 만족스럽게 만들어라"]
}
