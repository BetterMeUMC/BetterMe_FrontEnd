//
//  SearchFriendViewController.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/11.
//

import UIKit

class SearchFriendViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var friendCollectionView: UICollectionView!
    
    var inviteText: String = ""
    private var friendList = [
        Friend(name: "신디", hNum: 17),
        Friend(name: "리미", hNum: 8),
        Friend(name: "범", hNum: 16),
        Friend(name: "주니", hNum: 3),
        Friend(name: "벨라", hNum: 2),
        Friend(name: "매버릭", hNum: 10),
        Friend(name: "피딕", hNum: 21),
        Friend(name: "포디", hNum: 21),
        Friend(name: "hi", hNum: 11),
    ]
    
    
    var filteredFriend = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureSFView()
        self.configureSearchView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.configureSFView()
        self.configureCollectionView()
    }
    
    private func configureCollectionView() {
        if inviteText == "" {
            for i in friendList {
                filteredFriend.append(i)
            }
        } else {
            self.filteredFriend = self.friendList.filter{
                $0.name.contains(self.searchTextField.text ?? "")
            }
            self.friendCollectionView.reloadData()
        }
        self.friendCollectionView.reloadData()
        self.friendCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.friendCollectionView.delegate = self
        self.friendCollectionView?.dataSource = self
    }
    
    private func configureSFView() {
        self.modalView.backgroundColor = .white
        self.backButton.backgroundColor = .clear
        self.modalView.layer.cornerRadius = 27.0
    }
    private func configureSearchView() {
        self.searchTextField.borderStyle = .none
        self.searchTextField.delegate = self
        self.searchTextField.text = inviteText
        self.searchView.layer.addBorder([.bottom], color: UIColor.black, width: 1.0)
    }
    
    @IBAction func tapCancleButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSearchButton(_ sender: UIButton) {
        self.filteredFriend = self.friendList.filter{
            $0.name.contains(self.searchTextField.text ?? "")
        }
        self.friendCollectionView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension SearchFriendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredFriend.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as? FriendCell else { return UICollectionViewCell() }
        let friend = self.filteredFriend[indexPath.row]
        cell.nameLabel.text = friend.name
        cell.hNumLabel.text = String(friend.hNum)
        cell.layer.cornerRadius = 6.0
        return cell
    }
    
}

extension SearchFriendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 36, height: 55)
    }
}

extension SearchFriendViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.filteredFriend = self.friendList.filter{
            $0.name.contains(textField.text ?? "")
        }
        self.friendCollectionView.reloadData()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            for i in friendList {
                filteredFriend.append(i)
            }
            self.friendCollectionView.reloadData()
        }
    }
}


extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
