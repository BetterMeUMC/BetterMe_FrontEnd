//
//  SocialViewController.swift
//  Better-me-iOS
//
//  Created by 황인성 on 2023/02/01.
//

import UIKit
import SwiftUI

class SocialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        // Do any additional setup after loading the view.
    }
    

    @IBSegueAction func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContentView())
    }
    
//    @IBSegueAction func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
//        return UIHostingController(coder: coder, rootView: ContentView())
//    }
    private func dateToString(date: Date) -> String{
        let formmater = DateFormatter()
        formmater.dateFormat = "M월 d일 E요일"
        formmater.locale = Locale(identifier: "ko-KR")
        return formmater.string(from: date)
    }
    
    private func configureNaviBar() {
        let image = UIImage(named: "BetterMeLogo")
        let date = dateToString(date: Date())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: date, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
