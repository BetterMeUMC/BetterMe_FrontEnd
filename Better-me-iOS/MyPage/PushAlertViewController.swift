//
//  PushAlertViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit

class PushAlertViewController: UIViewController {

    let alertTitle = ["매일 습관 체크 알림","습관 초대 알림","친구 요청 알림","친구 어워드 알림"]
    let alertSubTitle = ["매일 습관 체크 알림","습관 초대 알림","친구 요청 알림","친구 어워드 알림"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
        // Do any additional setup after loading the view.
    }
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "푸시알림 설정"
    }

    
    
}


extension PushAlertViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertTitle.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell", for: indexPath) as? AlertTableViewCell else { return UITableViewCell() }
        cell.alertTitleLabel.text = alertTitle[indexPath.row]
        cell.alertSubTitleLabel.text = alertSubTitle[indexPath.row]
               return cell
    }

}

