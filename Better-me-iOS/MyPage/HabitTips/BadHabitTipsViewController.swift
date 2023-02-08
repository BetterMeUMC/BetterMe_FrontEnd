//
//  GoodHabitTipsViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit

class BadHabitTipsViewController: UIViewController {


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
        self.title = "나쁜습관 쉽게 없애는 법"
    }

    
}
extension BadHabitTipsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BConstants.tipsTitle.count
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
                return CGFloat(tipsDB.getBadTipsNum(index: indexPath.row) * 70)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TipsCell", for: indexPath) as? TipsCell else { return UITableViewCell() }
            
        cell.setUI(with: indexPath.row, 2)
            return cell

    }

    
    
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }
 func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
     if tableView.cellForRow(at: indexPath) is TipsCell {
        
       }
   }
}
enum BConstants {
    static let tipsTitle = ["Tip 1 : 보이지 않게 만들어라",
                            "Tip 2 : 매력적이지 않게 만들어라",
                            "Tip 3 : 하기 어렵게 만들어라",
                            "Tip 4 : 불만족스러운 것으로 만들어라"]
}
