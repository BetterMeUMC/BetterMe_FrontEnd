//
//  ViewController.swift
//  Better-me-iOS
//
//  Created by 정태우 on 2023/01/09.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var goodHabitView: UIView!
    @IBOutlet weak var badHabitView: UIView!
    @IBOutlet weak var goodHabitCollectionView: UICollectionView!
    @IBOutlet weak var badHabitCollectionView: UICollectionView!
    
    @IBOutlet weak var goodHabitCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addGoodHabitButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var badHabitCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addBadHabitButtonTopConstraint: NSLayoutConstraint!
    
    
    private var todayDate: Date?
    
    private var goodHabitList = [Habit]() {
        didSet {
            self.saveGoodHabitList()
        }
    }
    private var badHabitList = [Habit]() {
        didSet {
            self.saveBadHabitList()
        }
    }
    
    let quotes = [
        Quote(contents: "습관이란 인간으로 하여금 그 어떤 일도 할 수 있게 만들어준다.", name: "- 도스토옙스키"),
        Quote(contents: "가난과 부, 실패와 성공은 모두 습관 때문이다.", name: "- 중국 속담"),
        Quote(contents: "타고난 본성은 비슷하지만, 습관에 의해서 달라진다.", name: "- 공자"),
        Quote(contents: "습관을 바꾸는 것만으로도 자신의 인생을 바꿀 수 있다.", name: "- 윌리엄 제임스"),
        Quote(contents: "지루해지는 비결은 모든 것을 이야기 하는 것이다.", name: "- 볼테르"),
        Quote(contents: "타인의 습관처럼 고쳐야 할 필요가 있는 것은 없다.", name: "- 마트 트웨인"),
        Quote(contents: "너 자신을 더욱 깨끗하게 밝게 유지하라. 너는 세상을 보기 위한 창문이니", name: "- 조지 버나드 쇼"),
        Quote(contents: "오랜 관습에는 심오한 의미가 담겨 있다.", name: "- 요한 프리드리히 폰 쉴러"),
        Quote(contents: "습관의 영속성은 일반적으로 습관의 불합리성과 정비례한다.", name: "- 마르셀 프로스트"),
        Quote(contents: "나쁜 습관을 떨쳐버리는 가장 좋은 방법은 절대 시작하지 않는 것이다.", name: "- 제임스 C. 페니"),
        Quote(contents: "습관은 성격으로 변한다.", name: "- 오비디우스"),
        Quote(contents: "사소한 습관 하나로 큰 범죄에 이를 수도 있다.", name: "- 한나 모어"),
        Quote(contents: "불행히도 좋은 습관은 나쁜 습관보다 포기하기가 쉽다.", name: "- 윌리엄 모음"),
        Quote(contents: "습관은 밧줄과도 같다. 날마다 한 올 한 올 엮다 보면 결국 끊지 못하게 된다.", name: "- 호레이스 만"),
        Quote(contents: "생활은 습관이 짜낸 천에 불과하다.", name: "- 아미엘"),
        Quote(contents: "네가 집착하는 것 외에 평생 너를 따라다니는 습관은 없다.", name: "- 가드너 헌팅"),
        Quote(contents: "습관은 삶의 훌륭한 안내자다.", name: "- 데이비드 흄"),
        Quote(contents: "하찮은 것일지라도 자연스러운 기질의 함양은 성품과 지론에 관한 문제다.", name: "- 존 S 호슨"),
        Quote(contents: "모두가 대문을 닫는다면 모든 거리가 깨끗해진다.", name: "- 요한 볼프강 폰 쾨테"),
        Quote(contents: "피로감 역시 술버릇과 마찬가지로 부적절한 것이다. 둘 다 나쁜 습관의 증거다.", name: "- L.G 프리먼"),
        Quote(contents: "우리의 욕구는 자연이 아닌 교육과 습관에서 비롯된다.", name: "- 헨리 필딩"),
        Quote(contents: "습관은 인간을 실수로 인도할 수도 있다. 이 경우 습관은 정당화되지 못한다.", name: "- 헨리 필딩"),
        Quote(contents: "손톱이 자라면서 없어지듯 습관은 습관에 의해 정복된다.", name: "- 에라스무스"),
        Quote(contents: "습관은 최상의 하인이 될 수도 있고, 최악의 주인이 될 수도 있다.", name: "- 나다니엘 에몬스"),
        Quote(contents: "인간의 습관과 생활방식은 큰 가지의 잎사귀처럼 변하게 마련이다. 어떤 잎은 떨어지고 새 잎이 난다.", name: "- 단테"),
        Quote(contents: "인간의 본성은 서로 비슷하지만, 후천적 습관에 의해 서로 멀어진다.", name: "- 공자"),
        Quote(contents: "비애는 만사를 귀찮하는 사람들의 몫이다. 모든 일도 그들을 싫어할 테니까 말이다.", name: "- G.K 채스터톤"),
        Quote(contents: "우리는 자연의 법칙에 따라 생각하고, 규칙에 따라 말하며, 습관에 따라 행동한다.", name: "- 프란시스 베이컨"),
        Quote(contents: "성공한 삶의 가장 큰 비밀은 목표를 정하고 성취해내는 것이다.", name: "- Henry Ford"),
        Quote(contents: "처음에는 우리가 습관을 만들지만 그 다음에는 습관이 우리를 만든다", name: "- 존 드라이든"),
        Quote(contents: "습관이 인간 생활의 위대한 안내자이다.", name: "- 데이비드 흄"),
        Quote(contents: "습관은 제 2의 천성으로 제 1의 천성을 파괴한다.", name: "- 파스칼"),
        Quote(contents: "습관은 나무 껍질에 새겨 놓은 문자 같아서 그 나무가 자라남에 따라 확대된다.", name: "- 새뮤얼 스마일스"),
        Quote(contents: "우유부단한 것만이 습관화되어 있는 사람보다 더 비참한 사람은 없다.", name: "- 제임스"),
        Quote(contents: "젊음의 잘못된 습관을 치료할 수 있는 유일한 의사가 바로 시간이다.", name: "- 그라시안"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "BetterMeLogo")
        let date = dateToString(date: Date())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: date, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        self.resetCheck()
        self.quoteGeneration()
        self.configureQuoteView()
        self.configureGoodHabitCollectionView()
        self.loadGoodHabitList()
        self.loadBadHabitList()
        self.navigationController?.addCustomBottomLine(color: UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0), height: 1)
    }
    
    
    private func configureGoodHabitCollectionView() {
        self.goodHabitCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.goodHabitCollectionView.delegate = self
        self.goodHabitCollectionView.dataSource = self
        self.badHabitCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.badHabitCollectionView.delegate = self
        self.badHabitCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addHabitViewController = segue.destination as? AddGoodHabitViewController {
            addHabitViewController.delegate = self
        }
        if let removeBadHabitViewController = segue.destination as? RemoveBadHabitViewController {
            removeBadHabitViewController.delegate = self
        }
    }
    
    private func saveGoodHabitList() {
        let data = self.goodHabitList.map {
            [
                "title": $0.title,
                "contents": $0.contents,
                "emoji": $0.emoji,
                "date": $0.date,
                "hNum": $0.hNum,
                "isCheck": $0.isCheck,
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "goodHabitList")
    }
    private func saveBadHabitList() {
        let data = self.badHabitList.map {
            [
                "title": $0.title,
                "contents": $0.contents,
                "emoji": $0.emoji,
                "date": $0.date,
                "hNum": $0.hNum,
                "isCheck": $0.isCheck,
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "badHabitList")
    }
    
    private func loadGoodHabitList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "goodHabitList") as? [[String: Any]] else { return }
        self.goodHabitList = data.compactMap {
            guard let title =  $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let emoji = $0["emoji"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let hNum = $0["hNum"] as? Int else { return nil }
            guard let isCheck = $0["isCheck"] as? Bool else { return nil }
            return Habit(title: title, emoji: emoji, contents: contents, hNum: hNum, isCheck: isCheck, date: date)
        }
        self.goodHabitList = self.goodHabitList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    private func loadBadHabitList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "badHabitList") as? [[String: Any]] else { return }
        self.badHabitList = data.compactMap {
            guard let title =  $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let emoji = $0["emoji"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let hNum = $0["hNum"] as? Int else { return nil }
            guard let isCheck = $0["isCheck"] as? Bool else { return nil }
            return Habit(title: title, emoji: emoji, contents: contents, hNum: hNum, isCheck: isCheck, date: date)
        }
        self.badHabitList = self.badHabitList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    private func quoteGeneration() {
        let random = Int(arc4random_uniform(UInt32(quotes.count)))
        self.quoteLabel.text = quotes[random].contents
        self.nameLabel.text = quotes[random].name
    }
    
    private func configureQuoteView() {
        self.quoteView.layer.cornerRadius = 10.0
    }
    

    private func dateToString(date: Date) -> String{
        let formmater = DateFormatter()
        formmater.dateFormat = "M월 d일 E요일"
        formmater.locale = Locale(identifier: "ko-KR")
        return formmater.string(from: date)
    }
    
    @objc func deleteGoodHabit(_ notification: Notification) {
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        self.goodHabitList.remove(at: indexPath.row)
        self.goodHabitCollectionView.deleteItems(at: [indexPath])
    }
    private func resetCheck() {
        let calendar = Calendar.current
        let now = Date()
        let date = calendar.date(
            bySettingHour: 0,
            minute: 0,
            second: 0,
            of: now)!
        let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(resetCheckButton), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
    }
    
    @objc func resetCheckButton() {
        if goodHabitList.count > 0 {
            for i in 0...(goodHabitList.count - 1) {
                goodHabitList[i].isCheck = false
            }
        }
        if badHabitList.count > 0 {
            for i in 0...(badHabitList.count - 1) {
                badHabitList[i].isCheck = false
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.goodHabitCollectionView {
            if self.goodHabitList.count < 3 {
                self.goodHabitCollectionViewHeight.constant = CGFloat(goodHabitList.count * 55)
                if self.goodHabitList.count == 0 {
                    self.addGoodHabitButtonTopConstraint.constant = CGFloat(0)
                } else {
                    self.addGoodHabitButtonTopConstraint.constant = CGFloat(10)
                }
            } else {
                self.goodHabitCollectionViewHeight.constant = CGFloat(170)
            }
            return self.goodHabitList.count
        } else {
            if self.badHabitList.count < 3 {
                self.badHabitCollectionViewHeight.constant = CGFloat(badHabitList.count * 55)
                if self.badHabitList.count == 0 {
                    self.addBadHabitButtonTopConstraint.constant = CGFloat(0)
                } else {
                    self.addBadHabitButtonTopConstraint.constant = CGFloat(10)
                }
            } else {
                self.badHabitCollectionViewHeight.constant = CGFloat(170)
            }
            return self.badHabitList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.goodHabitCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodHabitCell", for: indexPath) as? GoodHabitCell else { return UICollectionViewCell() }
            let habit = self.goodHabitList[indexPath.row]
            cell.titleLabel.text = habit.title
            cell.emojiLabel.text = habit.emoji
            cell.completionLabel.text = "\(habit.hNum)/30"
            if habit.isCheck {
                cell.isCheckButton.setImage(UIImage(named: "IsCheckImage"), for: .normal)
            } else {
                cell.isCheckButton.setImage(UIImage(named: "IsCheckBackground"), for: .normal)
            }
            cell.completionProgressView.progressTintColor = UIColor(red: 255/255, green: 122/255, blue: 110/255, alpha: 1.0)
            cell.completionProgressView.progress = Float(habit.hNum) / 30
            cell.completion = habit.hNum
            cell.isCheck = habit.isCheck
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadHabitCell", for: indexPath) as? BadHabitCell else { return UICollectionViewCell() }
            let habit = self.badHabitList[indexPath.row]
            cell.titleLabel.text = habit.title
            cell.emojiLabel.text = habit.emoji
            cell.completionLabel.text = "\(habit.hNum)/30"
            if habit.isCheck {
                cell.isCheckButton.setImage(UIImage(named: "IsCheckImage"), for: .normal)
            } else {
                cell.isCheckButton.setImage(UIImage(named: "IsCheckBackground"), for: .normal)
            }
            cell.completionProgressView.progressTintColor = UIColor(red: 255/255, green: 122/255, blue: 110/255, alpha: 1.0)
            cell.completionProgressView.progress = Float(habit.hNum) / 30
            cell.completion = habit.hNum
            cell.isCheck = habit.isCheck
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 36
        return CGSize(width: width, height: 50)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.goodHabitCollectionView {
            guard let goodHabitDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "GoodHabitDetailViewController") as? GoodHabitDetailViewController else { return }
            let habit = self.goodHabitList[indexPath.row]
            goodHabitDetailViewController.habit = habit
            goodHabitDetailViewController.indexPath = indexPath
            goodHabitDetailViewController.hNum = habit.hNum
            goodHabitDetailViewController.isCheck = habit.isCheck
            goodHabitDetailViewController.date = habit.date
            goodHabitDetailViewController.delegate = self
            self.navigationController?.pushViewController(goodHabitDetailViewController, animated: true)
        } else {
            guard let badHabitDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "BadHabitDetailViewController") as? BadHabitDetailViewController else { return }
            let habit = self.badHabitList[indexPath.row]
            badHabitDetailViewController.habit = habit
            badHabitDetailViewController.indexPath = indexPath
            badHabitDetailViewController.hNum = habit.hNum
            badHabitDetailViewController.isCheck = habit.isCheck
            badHabitDetailViewController.date = habit.date
            badHabitDetailViewController.delegate = self
            self.navigationController?.pushViewController(badHabitDetailViewController, animated: true)
        }
    }
}

extension HomeViewController: AddGoodHabitViewDelegate {
    func didSelectRegister(habit: Habit) {
        self.goodHabitList.append(habit)
        self.goodHabitList = self.goodHabitList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.goodHabitCollectionView.reloadData()
    }
}

extension HomeViewController: RemoveBadHabitViewDelegate {
    func didBadSelectRegister(habit: Habit) {
        self.badHabitList.append(habit)
        self.badHabitList = self.badHabitList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.badHabitCollectionView.reloadData()
    }
}

extension HomeViewController: GoodHabitDetailViewDelegate {
    func didSelectDelete(indexPath: IndexPath) {
        self.goodHabitList.remove(at: indexPath.row)
        self.goodHabitCollectionView.deleteItems(at: [indexPath])
    }
    func didSelectEdit(indexPath: IndexPath, habit: Habit) {
        self.goodHabitList[indexPath.row] = habit
        self.goodHabitCollectionView.reloadData()
    }
}

extension HomeViewController: BadHabitDetailViewDelegate {
    func didBadSelectDelete(indexPath: IndexPath) {
        self.badHabitList.remove(at: indexPath.row)
        self.badHabitCollectionView.deleteItems(at: [indexPath])
    }
    func didBadSelectEdit(indexPath: IndexPath, habit: Habit) {
        self.badHabitList[indexPath.row] = habit
        self.badHabitCollectionView.reloadData()
    }
}

extension HomeViewController: GoodHabitCellDelegate {
    func didSelectIsCheck(indexPath:IndexPath, completion: Int, isCheck: Bool) {
        self.goodHabitList[indexPath.row].hNum = completion
        self.goodHabitList[indexPath.row].isCheck = isCheck
        print(goodHabitList[indexPath.row])
    }
}

extension HomeViewController: BadHabitCellDelegate {
    func didBadSelectIsCheck(indexPath: IndexPath, completion: Int, isCheck: Bool) {
        self.badHabitList[indexPath.row].hNum = completion
        self.badHabitList[indexPath.row].isCheck = isCheck
    }
}

//extension HomeViewController: AlertViewControllerDelegate {
//    func didSelectDelete(indexPath: IndexPath, isGood: Bool) {
//        if isGood {
//            self.goodHabitList.remove(at: indexPath.row)
//            self.goodHabitCollectionView.deleteItems(at: [indexPath])
//        } else {
//            self.badHabitList.remove(at: indexPath.row)
//            self.badHabitCollectionView.deleteItems(at: [indexPath])
//        }
//    }
//}


extension UINavigationController
{
    func addCustomBottomLine(color:UIColor,height:Double)
    {
        navigationBar.setValue(true, forKey: "hidesShadow")
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)

        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
    }
}
