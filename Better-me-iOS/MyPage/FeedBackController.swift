//
//  FeedBackController.swift
//  Better-me-iOS
//
//  Created by Phil on 2023/01/30.
//

import UIKit

class FeedBackController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    
    
    lazy var button : UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1).cgColor
        
        view.setTitle("보내기", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        view.setTitleColor(UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1), for: .normal)
        
        view.addTarget(self, action: #selector(postFeedback), for: .touchUpInside)
        
        return view
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarUI()
        configureButtonUI()
        
        titleTextField.clearsOnBeginEditing = true
        contentTextField.clearsOnBeginEditing = true
    }
    //MARK: - Helpers
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "피드백 작성하기"
    }
    
    func configureButtonUI() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (view.frame.height/7) * -1),
                                     button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
                                     button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
                                     button.heightAnchor.constraint(equalToConstant: 43)])
    }
    
    //MARK: - PostAPI
    @objc func postFeedback() {
        
        let userIdx = 1
        let feedback = PostFeedback(title: self.titleTextField.text ?? "", content: self.contentTextField.text ?? "")
        guard let uploadData = try? JSONEncoder().encode(feedback)
        else {return}
        
        let header = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxLCJpYXQiOjE2NzU5MTI0OTksImV4cCI6MTY3NTk5ODg5OSwic3ViIjoidXNlckluZm8ifQ.PMc1ghN20fi8yGP9UsTGDmUmf5X5DYpfL_Y56xo3hN0","Content-Type": "application/json"]
        // URL 객체 정의
        let url = URL(string: "http://54.180.13.219:3000/app/feedback/\(userIdx)")

        // URLRequest 객체를 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // HTTP 메시지 헤더
        request.allHTTPHeaderFields = header

        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in

            // 서버가 응답이 없거나 통신이 실패
//            let successCode = 1000
////            let noTitleCode = 2044
////            let noContentCode = 2045
//            
//            guard error == nil,
//                let statusCode = (response as? HTTPURLResponse)?.statusCode,
//                successCode == statusCode else {
////                if statusCode == noTitleCode {
////                    print("제목 미작성 오류")
////                } else if statusCode == noContentCode {
////                    print("내용 미작성 오류")
////                }
//                print("missing something")
//     
//                    return
//            }
            
            
            
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            // 응답 처리 로직
            print("feedback post success")
        }
        // POST 전송
        task.resume()
        let alert = UIAlertController(title: "접수완료", message: "피드백이 성공적으로 접수되었습니다!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default){_ in
            self.titleTextField.text = ""
            self.contentTextField.text = ""
        }

        alert.addAction(ok)

        
            self.present(alert, animated: false)
        
    }

}

struct PostFeedback: Codable {
    let title: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case title, content
    }
}


