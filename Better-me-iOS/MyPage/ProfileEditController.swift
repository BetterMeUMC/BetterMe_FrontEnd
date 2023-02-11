//
//  File.swift
//  Better-me
//
//  Created by Phil on 2023/01/16.
//

import UIKit
import AVFoundation
import Photos




class ProfileEditController: UIViewController{
    
    //MARK: - Properties

    @IBOutlet weak var profileView: UIView!
    
    @IBAction func editBtn(_ sender: Any) {
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBOutlet weak var userCommentImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    
    let imagePickerController = UIImagePickerController()
    let alertController = UIAlertController(title: "올릴 방식을 선택하세요", message: "사진 찍기 또는 앨범에서 선택", preferredStyle: .actionSheet)

    lazy var saveBtn : UIBarButtonItem = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.984, green: 0.078, blue: 0, alpha: 1)
        view.layer.cornerRadius = 15
        view.setTitle("완료", for: .normal)
        view.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        view.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 55),
            view.heightAnchor.constraint(equalToConstant: 31)])
        
        view.addTarget(self, action: #selector(clickedSavedBtn), for: .touchUpInside)
        
        
        return UIBarButtonItem(customView: view)
    }()
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePickerController.sourceType = .photoLibrary // 앨범에서 가져옴
        self.imagePickerController.allowsEditing = true // 수정 가능 여부
        self.imagePickerController.delegate = self
        
        navigationBarUI()
        configureProfileUI()

        textFieldCustom(textField: nameTextField)
        textFieldCustom(textField: messageTextField)
        enrollAlertEvent()
    }
    
    //MARK: - Helpers
    @objc func clickedSavedBtn(_ sender: UIButton) {
        UserDefaults.standard.setValue(self.nameTextField.text, forKey: "nickName")
        UserDefaults.standard.setValue(self.messageTextField.text, forKey: "promise")
        
        
        let alret = UIAlertController(title: "저장!", message: "프로필이 수정되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)

        alret.addAction(ok)
        present(alret, animated: true, completion: nil)
        print("저장")
    }
    
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "프로필 수정"
        self.navigationItem.rightBarButtonItem = self.saveBtn
    }
    func configureProfileUI(){
        shadowing(view: profileView)
        
        self.nameTextField.text = UserDefaults.standard.string(forKey: "nickName")
        self.messageTextField.text = UserDefaults.standard.string(forKey: "promise")
        
        profileView.layer.cornerRadius = profileView.frame.height/2
        userCommentImageView.layer.cornerRadius = userCommentImageView.frame.height/2
        userCommentImageView.layer.borderWidth = 1
        userCommentImageView.clipsToBounds = true
        userCommentImageView.layer.borderColor = UIColor.clear.cgColor
        userCommentImageView.clipsToBounds = true
    }
    func textFieldCustom (textField: UITextField) {
        textField.clearsOnBeginEditing = false
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.679, green: 0.679, blue: 0.679, alpha: 1).cgColor
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
     
          self.view.endEditing(true)
     
    }
    
    //MARK: - Camera
    func enrollAlertEvent() {
            let photoLibraryAlertAction = UIAlertAction(title: "사진 앨범", style: .default) {
                (action) in
                self.openAlbum()
            }
            let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) {(action) in
                self.openCamera()
            }
            let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            self.alertController.addAction(photoLibraryAlertAction)
            self.alertController.addAction(cameraAlertAction)
            self.alertController.addAction(cancelAlertAction)
            guard let alertControllerPopoverPresentationController
                    = alertController.popoverPresentationController
            else {return}
            prepareForPopoverPresentation(alertControllerPopoverPresentationController)
    }
    
  
    
    func openAlbum() {
            self.imagePickerController.sourceType = .photoLibrary
            present(self.imagePickerController, animated: false, completion: nil)
    }
    
    func openCamera() {
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                self.imagePickerController.sourceType = .camera
                present(self.imagePickerController, animated: false, completion: nil)
            }
            else {
                print ("Camera's not available as for now.")
            }
        }

    
}


extension ProfileEditController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        if let popoverPresentationController =
      self.alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect
            = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}

extension ProfileEditController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        } else {
            print("error detected in didFinishPickinMediaWithInfo method")
        }
        
        self.userCommentImageView.image = newImage // 받아온 이미지를 update
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
    }
    
    

}

