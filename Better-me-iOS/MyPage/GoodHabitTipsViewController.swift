//
//  GoodHabitTipsViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit

class GoodHabitTipsViewController: UIViewController {


    //MARK: - Properties
    private let tipsTitle = ["Tip 1 : 분명하게 만들어라","Tip 2 : 매력적으로 만들어라","Tip 3 : 하기 쉽게 만들어라","Tip 4 : 만족스럽게 만들어라"]

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()

    }
    //MARK: - Helpers
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "좋은습관 잘 만드는 법"
    }

    
}
extension GoodHabitTipsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = GoodTipsHeader()
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoodTipsCell", for: indexPath) as? GoodTipsCell else { return UITableViewCell() }
            
        cell.tipsListTitle.text = tipsTitle[indexPath.row]
            return cell

    }
}
