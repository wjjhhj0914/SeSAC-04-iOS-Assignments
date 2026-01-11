//
//  ShoppingListsTableViewController.swift
//  Day09_Assignment01
//
//  Created by Hyojung Jang on 1/10/26.
//

import UIKit

struct ShoppingList {
    let title: String
    let date: String
    var taskDone: Bool
    var favourite: Bool
}

class ShoppingListsTableViewController: UITableViewController {
    
    // 오늘 날짜 가져오기
    func getToday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        
        return formatter.string(from: Date())
    }
    
    var shoppingLists: [ShoppingList] = []
    
    @IBOutlet var shoppingListTextField: UITextField!
    @IBOutlet var filteredResultView: UIView!
    @IBOutlet var taskDoneView: UIView!
    @IBOutlet var filteredResultLabel: UILabel!
    @IBOutlet var filteredResultCountLabel: UILabel!
    @IBOutlet var taskDoneLabel: UILabel!
    @IBOutlet var taskDoneCountLabel: UILabel!
    @IBOutlet var headerLabel: UILabel!
    
    // labelView 함수
    func setLabelViewDesign(view: UIView) {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
    }
    
    // label 함수
    func setResultLabelDesign(label: UILabel, title: String, fontSize: CGFloat, fontWeight: UIFont.Weight, colour: UIColor) {
        label.text = title
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.textColor = colour
    }
    
    func updateFilteredCount() {
        setResultLabelDesign(label: filteredResultCountLabel, title: "\(shoppingLists.count)개", fontSize: 17, fontWeight: .heavy, colour: .black)
    }
    
    func updateDoneCount() {
        let doneCount = shoppingLists.filter { $0.taskDone == true }.count
        
        setResultLabelDesign(label: taskDoneCountLabel, title: "\(doneCount)개", fontSize: 17, fontWeight: .heavy, colour: .systemIndigo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let today = getToday()
        
        shoppingLists = [
            ShoppingList(title: "나무 수저", date: today, taskDone: true, favourite: false),
            ShoppingList(title: "보조 배터리", date: today, taskDone: false, favourite: false),
            ShoppingList(title: "수건", date: today, taskDone: false, favourite: false),
            ShoppingList(title: "애플워치", date: today, taskDone: false, favourite: true)
        ]
        
        print(shoppingLists)
        
        shoppingListTextField.layer.cornerRadius = 16
        shoppingListTextField.clipsToBounds = true
        shoppingListTextField.placeholder = "새로운 품목 추가"
        
        setLabelViewDesign(view: filteredResultView)
        setLabelViewDesign(view: taskDoneView)
        
        setResultLabelDesign(label: filteredResultLabel, title: "필터 결과", fontSize: 12, fontWeight: .bold, colour: .gray)
        updateFilteredCount()
        setResultLabelDesign(label: taskDoneLabel, title: "완료 항목", fontSize: 12, fontWeight: .bold, colour: .gray)
        
        updateDoneCount()
        
        headerLabel.textColor = UIColor.gray
        headerLabel.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
    }
    
    // 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingLists.count
    }
    
    // 셀 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListsTableViewCell", for: indexPath) as! ShoppingListsTableViewCell
        let row = shoppingLists[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.dateLabel.text = row.date

        // 즐겨찾기 버튼
        let favouriteButtonImage = !row.favourite ? "star" : "star.fill"
        cell.favouriteButton.setImage(UIImage(systemName: favouriteButtonImage), for: .normal)
        
        // 체크 버튼
        if row.taskDone {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            cell.checkButton.tintColor = .systemIndigo
            cell.titleLabel.textColor = .lightGray
        } else {
            cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            cell.checkButton.tintColor = .gray
            cell.titleLabel.textColor = .black
        }
        
        // 텍스트필드 클릭 이벤트 연결
        shoppingListTextField.addTarget(self, action: #selector(textFieldClicked), for: .editingDidEndOnExit)
        // 즐겨찾기 버튼 클릭 이벤트 연결
        cell.favouriteButton.addTarget(self, action: #selector(favouriteButtonClicked), for: .touchUpInside)
        // 클릭한 즐겨찾기 버튼 연결
        cell.favouriteButton.tag = indexPath.row
        // 체크 버튼 클릭 이벤트 연결
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        // 클릭한 체크 버튼 연결
        cell.checkButton.tag = indexPath.row

        
//        let today = "26-01-10"
        let today = getToday()
        
        if shoppingLists[indexPath.row].date == today {
            cell.expirationLabel.isHidden = true
        } else {
            cell.expirationLabel.text = "기한 지남"
        }

        return cell
    }
    
    // 스와이핑 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            shoppingLists.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        updateFilteredCount()
    }
    
    // 체크 버튼
    @objc func checkButtonClicked(_ sender: UIButton) {
        shoppingLists[sender.tag].taskDone.toggle()
        
        updateDoneCount()
        
        tableView.reloadData()
//        print("여기 맞나?")
        
    }
    
    // 즐겨찾기
    @objc func favouriteButtonClicked(_ sender: UIButton) {
        shoppingLists[sender.tag].favourite.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    // 목록 추가
    @objc func textFieldClicked(_ sender: UITextField) {
        let text = shoppingListTextField.text
        shoppingLists.append(ShoppingList(title: text!, date: getToday(), taskDone: false, favourite: true))
        
        updateFilteredCount()
        
        tableView.reloadData()
    }
    
    @IBOutlet var showNickname: UINavigationItem!
    
    let nickname = ["지렁이", "물개", "형돈아", "개미", "명수", "곰발바닥", "감태", "미역", "몽땅연필", "미숫가루"]
    
    @IBAction func unWindToHome(_ sender: UIStoryboardSegue) {
        let randomNickname = Int.random(in: 0..<nickname.count)
        showNickname.title = "\(nickname[randomNickname])님의 쇼핑 목록"
    }
}
