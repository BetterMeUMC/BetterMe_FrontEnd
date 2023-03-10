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
    @IBOutlet weak var photoImageView: UIImageView!
    
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
        
        guard let newImageData = photoImageView.image!.pngData() else{return}
        print(newImageData)
        ProfileImageDataManager().patchProfilePhoto(imgData: newImageData)
        UserDataManager().patchUserData(nickName: self.nameTextField.text ?? "", promise: self.messageTextField.text ?? "",viewController: self)
        
    }
    
    
    func navigationBarUI() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "프로필 수정"
        self.navigationItem.rightBarButtonItem = self.saveBtn
    }
    
    func configureProfileUI(){
        shadowing(view: profileView)
        profileView.layer.cornerRadius = profileView.frame.height/2
        photoImageView.layer.cornerRadius = photoImageView.frame.height/2
        photoImageView.layer.borderWidth = 1
        photoImageView.clipsToBounds = true
        photoImageView.layer.borderColor = UIColor.clear.cgColor
        configureUserInfo()
    }
    func textFieldCustom (textField: UITextField) {
        textField.clearsOnBeginEditing = false
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.679, green: 0.679, blue: 0.679, alpha: 1).cgColor
    }
    
    func configureUserInfo() {
        self.nameTextField.text = UserDefaults.standard.string(forKey: "nickName")
        self.messageTextField.text = UserDefaults.standard.string(forKey: "promise")
        
        if UserDefaults.standard.string(forKey: "photo") == "server x" {
            self.photoImageView.image = UIImage(named: "defaultPhoto")
        }
        else {
            guard let photoURL = URL(string: UserDefaults.standard.string(forKey: "photo") ?? "") else { return }
            DispatchQueue.global().async {
                if let photoData = try? Data(contentsOf: photoURL) {
                    if let image = UIImage(data: photoData) {
                        DispatchQueue.main.async {
                            self.photoImageView.image = image
                        }
                    }
                }
            }
        }
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
        self.photoImageView.image = newImage
        
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
    }
}

