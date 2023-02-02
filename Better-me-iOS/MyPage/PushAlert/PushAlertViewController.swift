//
//  PushAlertViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit

class PushAlertViewController: UIViewController {

    private let alertTitle = ["매일 습관 체크 알림","습관 초대 알림","친구 요청 알림","친구 어워드 알림"]
    private let alertSubTitle = ["매일 정해진 시간에 습관 체크 알림을 보냅니다",
                         "습관 초대를 받을경우 알림을 보냅니다",
                         "친구 요청을 수신하거나 \n보낸 친구 요청이 수락되었을 때 알림을 보냅니다",
                         "친구가 어워드를 획득할 경우 알림을 보냅니다"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
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

