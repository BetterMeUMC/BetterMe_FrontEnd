//
//  ViewController.swift
//  Better-me
//
//  Created by Phil on 2023/01/10.
//

import UIKit

private let cellID = "Cell"

class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIView!
    
    @IBAction func ProfileEditBtn(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProfileEditController"){
        
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    let tableView =  UITableView(frame: .zero, style: .grouped)
    let myPageMenu = ["비밀번호 변경","피드백 작성하기","푸시알림 설정","회원탈퇴"]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureProfileViewUI()
        configureTableViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Helpers
    func configureProfileViewUI() {
        profileView.layer.cornerRadius = 18
        shadowing(view: profileView)
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        shadowing(view: profileImageView)
    }
    
    func configureTableViewUI() {
        
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPageCell.self, forCellReuseIdentifier: cellID)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo:    profileView.bottomAnchor, constant: 28),
                                     tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
    }

}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MyPageCell
        
        cell.menuLabel.text = myPageMenu[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
  
}

extension MyPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = FooterView()
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 176
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "PWEditController"){
            self.navigationController?.pushViewController(controller, animated: true)
        }
        case 1:
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "FeedBackController"){
            self.navigationController?.pushViewController(controller, animated: true)
        }
            
        default:
            
            return
            
        }
    }
}

func shadowing(view : UIView) {
    view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 5
    view.layer.shadowOffset = CGSize(width: 1, height: 1)
}

