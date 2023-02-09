//
//  ViewController.swift
//  Better-me
//
//  Created by Phil on 2023/01/10.
//

import UIKit



class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIView!
    
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var promise: UILabel!
    
    
    
    @IBAction func ProfileEditBtn(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProfileEditController"){
        
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private  let tableView =  UITableView(frame: .zero, style: .grouped)
    private let cellID = "Cell"
    private let myPageMenu = ["비밀번호 변경","피드백 작성하기","푸시알림 설정","회원탈퇴"]
    let GPDS = GetPersonDataService()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureNaviBar()
        configureProfileViewUI()
        configureTableViewUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.nickName.text = (UserDefaults.standard.string(forKey: "nickName") ?? " ") + " 님"
        self.promise.text = UserDefaults.standard.string(forKey: "promise")
        
    }
    

    
    //MARK: - Helpers
    func dateToString(date: Date) -> String{
        let formmater = DateFormatter()
        formmater.dateFormat = "M월 d일 E요일"
        formmater.locale = Locale(identifier: "ko-KR")
        return formmater.string(from: date)
    }
    
    func configureNaviBar() {
        let image = UIImage(named: "BetterMeLogo")
        let date = dateToString(date: Date())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: date, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func configureProfileViewUI() {
        self.nickName.text = UserDefaults.standard.string(forKey: "nickName")
        self.promise.text = UserDefaults.standard.string(forKey: "promise")
        
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
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 28),
                                     tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    @objc func btn1Clicked(_ sender: UIButton) {
        
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "GoodHabitTipsViewController"){
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    @objc func btn2Clicked(_ sender: UIButton) {
        
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "BadHabitTipsViewController"){
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func logOutButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default){
            _ in
            UserDefaults.standard.removeObject(forKey: "token")
            self.navigationController?.popToRootViewController(animated: true)
        }
        let no = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)

            self.present(alert, animated: false)
    
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
        let header = MyPageTableHeaderView()
        header.button1.addTarget(self, action: #selector(btn1Clicked), for: .touchUpInside)
        header.button2.addTarget(self, action: #selector(btn2Clicked), for: .touchUpInside)
        return header
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = MyPageTableFooterView()
        footer.button.addTarget(self, action: #selector(logOutButtonClicked), for: .touchUpInside)
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 176
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
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
    
        case 2:
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "PushAlertViewController"){
                self.navigationController?.pushViewController(controller, animated: true)
            }
        case 3:
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalViewController"){
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

