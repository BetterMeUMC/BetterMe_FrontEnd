//
//  PushNotiViewController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/02/01.
//

import UIKit

class PushNotiViewController: UIViewController {
    
    private let alertTitle = ["매일 습관 체크 알림","습관 초대 알림","친구 요청 알림","친구 어워드 알림"]
    private let alertSubTitle = ["매일 정해진 시간에 습관 체크 알림을 보냅니다",
                                 "습관 초대를 받을경우 알림을 보냅니다",
                                 "친구 요청을 수신하거나 \n보낸 친구 요청이 수락되었을 때 알림을 보냅니다",
                                 "친구가 어워드를 획득할 경우 알림을 보냅니다"]

    var isExpanded = false
    var selectedTime: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
    }
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "푸시알림 설정"
    }
    
    
    @IBAction func notificationTime(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        selectedTime = dateFormatter.string(from: sender.date)
    }
    
    
    @IBAction func notificationTimeSaved(_ sender: UIButton) {
        print(selectedTime ?? "")
        let alret = UIAlertController(title: "저장!", message: "습관체크 알림 시간이 저장 되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alret.addAction(ok)
        self.present(alret, animated: true, completion: nil)
    }
    
    
    
}


extension PushNotiViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0  && isExpanded {
            return 150
        } else {
            return 94
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            isExpanded = true
            UIView.animate(withDuration: 0.3) {
                tableView.performBatchUpdates(nil)
            }
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            isExpanded = false
            UIView.animate(withDuration: 0.3) {
                tableView.performBatchUpdates(nil)
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell", for: indexPath) as? AlertTableViewCell else { return UITableViewCell() }
        cell.alertTitleLabel.text = alertTitle[indexPath.row]
        cell.alertSubTitleLabel.text = alertSubTitle[indexPath.row]
        cell.selectionStyle = .none

        cell.index = indexPath.row
        
        return cell
    }

}

