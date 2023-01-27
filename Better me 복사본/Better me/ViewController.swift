//
//  ViewController.swift
//  login
//
//  Created by 심윤주 on 2023/01/09.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire
import GoogleSignIn
import SwiftUI


class ViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    
    
    func getInfo() {
        let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
            
          guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
          
          if !isValidAccessToken {
            return
          }
          
          guard let tokenType = loginInstance?.tokenType else { return }
          guard let accessToken = loginInstance?.accessToken else { return }
        
          let urlStr = "https://openapi.naver.com/v1/nid/me"
          let url = URL(string: urlStr)!
          
          let authorization = "\(tokenType) \(accessToken)"
          
          let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
          
        req.responseJSON { response in
            guard let body = response.value as? [String: Any] else { return }
                         
                         if let resultCode = body["message"] as? String{
                             if resultCode.trimmingCharacters(in: .whitespaces) == "success"{
                                 let resultJson = body["response"] as! [String: Any]
                                 
                           
                                 let profile = resultJson["profile_image"] as? String ?? ""
                                 let email = resultJson["email"] as? String ?? ""
                                 let nickName = resultJson["nickname"] as? String ?? ""

                                 print("네이버 로그인 프로필사진 ",profile)
                                 print("네이버 로그인 이메일 ",email)
                                 print("네이버 로그인 닉네임 ",nickName)
                             }
                             else{
                                 //실패
                             }
        }
    }
    }
    
    
    @IBAction func naverLogin(_ sender: Any) {

        guard let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance() else { return }
        
        //토큰이 있다면 (로그인이 되어있는 상태라면)
        if loginInstance.isValidAccessTokenExpireTimeNow() {
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "wordViewController")
            self.navigationController?.pushViewController(pushVC!, animated: true)
        }
                    
        loginInstance.delegate = self
        loginInstance.requestThirdPartyLogin()
    }
    

    //로그인 성공시
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("로그인 성공")
        getInfo()
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "wordViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }

    //token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("토큰")
        getInfo()
     
    }
    
    //로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("로그아웃")

    }
    
    //모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("에러관련 = \(error.localizedDescription)")
    }
    
    
    @IBAction func google(_ sender: Any) { //프로필 이미지..?
        
        let id = "79765517261-27iu2q8vtbv8nhdgqvuf62otvg0img5t.apps.googleusercontent.com"
        let signInConfig = GIDConfiguration(clientID: id)
        GIDSignIn.sharedInstance.configuration = signInConfig
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
            if let error = error {
                print(error)
            } else {
                let user = user?.user
                let fullName = user?.profile?.name
                let email = user?.profile?.email
                
            print(email)
              print(fullName)
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "wordViewController")
                self.navigationController?.pushViewController(pushVC!, animated: true)
            }
        }
    }
    
    @IBOutlet weak var joinbtn: UIButton!
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinbtn.layer.borderWidth = 2
        joinbtn.layer.cornerRadius = 25
        joinbtn.layer.borderColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1).cgColor
        
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginFirstViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
        
    }
    
    @IBAction func JoinBtn(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "JoinViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
    @IBAction func kakaoLogin(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
        
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    
                    _ = oauthToken
                }
            }
        } else {
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { [self] (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    _ = oauthToken
                    
                    setUserInfo()
                    //한줄다짐 설정 화면으로 넘어감
                    let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "wordViewController")
                    self.navigationController?.pushViewController(pushVC!, animated: true)
                }
            }
        }
    }
    
    func setUserInfo() { //카카오 정보 가져오기
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("success")
                _ = user
                print(user?.kakaoAccount?.email)
                print(user?.kakaoAccount?.profile?.nickname)
                print(user?.kakaoAccount?.profile?.profileImageUrl) //프로필 이미지 주소
                
                
            }
        }
    }
    
 
    
    
}

