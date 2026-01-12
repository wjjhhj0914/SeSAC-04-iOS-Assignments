//
//  BooksTableViewController.swift
//  Day09_Assignment02
//
//  Created by Hyojung Jang on 1/11/26.
//

import UIKit

import Toast

class BooksTableViewController: UITableViewController {
    
    var currentIndex = 0
    var searchedBookList: [Book] = []
    
    @IBOutlet var textFieldView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var paginationView: UIView!
    
    @IBOutlet var chevronLeftButton: UIButton!
    @IBOutlet var paginationLabel: UILabel!
    @IBOutlet var chevronRightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paginationView.isHidden = true
        resultLabel.isHidden = true
        
        textFieldView.layer.cornerRadius = 14
        searchTextField.layer.cornerRadius = 6
        searchTextField.clipsToBounds = true
        searchTextField.placeholder = "제목 또는 작가 검색"
        
        searchButton.layer.cornerRadius = 8
        
        resultLabel.textAlignment = .center
//        resultLabel.text = ""
        resultLabel.textColor = .lightGray
        resultLabel.font = .systemFont(ofSize: 14)
        
        paginationView.layer.cornerRadius = 24
        chevronLeftButton.tintColor = .lightGray
        chevronRightButton.tintColor = .lightGray
        paginationLabel.font = .systemFont(ofSize: 14)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchedBookList.count
        return searchedBookList.isEmpty ? 0 : 1
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "더 이상 보여드릴 도서가 없어요", message: "다른 도서를 검색해 보세요", preferredStyle: .alert)
        let button = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(button)
        present(alert, animated: true)
    }
    
    @IBAction func chevronRightButtonClicked(_ sender: UIButton) {

        if currentIndex < searchedBookList.count - 1 {
            currentIndex += 1
            tableView.reloadData()
            paginationLabel.text = "\(currentIndex + 1) / \(searchedBookList.count)"
        } else {
//            view.makeToast("더 이상 보여드릴 도서가 없어요", duration: 1, position: .top)
            showAlert()
        }
        
//        print(currentIndex)
    }
    
    @IBAction func chevronLeftButtonClicked(_ sender: UIButton) {
        
        if currentIndex > 0 {
            currentIndex -= 1
            tableView.reloadData()
            paginationLabel.text = "\(currentIndex + 1) / \(searchedBookList.count)"
        } else {
//            view.makeToast("더 이상 보여드릴 도서가 없어요", duration: 1, position: .top)
            showAlert()
        }
        
//        print(currentIndex)
    }
    
    func formattedNumber(num: Int) -> String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        let formattedString = formatter.string(from: NSNumber(value: num))
        
        return formattedString!
    }
    
    func searchBook() {
        searchedBookList.removeAll()
        tableView.reloadData()
        
        let text = searchTextField.text
        
        let result = books.filter { $0.title.contains(text!) || $0.author.contains(text!) }
        searchedBookList.append(contentsOf: result)
        
        currentIndex = 0
        
//        if searchedBookList.count > 0 {
//            resultLabel.text = "\(searchedBookList.count)개의 검색 결과가 나왔습니다."
//        } else {
//            resultLabel.text = "검색 결과가 없습니다."
//        }
        resultLabel.text = searchedBookList.isEmpty ? "검색 결과가 없습니다." : "\(searchedBookList.count)개의 검색 결과가 나왔습니다."
        paginationLabel.text = searchedBookList.isEmpty ? "0 / 0" : "1 / \(searchedBookList.count)"
        
        tableView.reloadData()
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        searchBook()
    }
    
    @IBAction func returnKeyPressed(_ sender: UITextField) {
        print(#function)
        searchBook()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell", for: indexPath) as! BooksTableViewCell
        
        resultLabel.isHidden = false
        paginationView.isHidden = false
        
        // 처음 가지고 올 때 실행
        // 근데, searchedBookList는 사용자가 입력하기 전까지는 0
//        let data = searchedBookList[indexPath.row]
        let data = searchedBookList[currentIndex]
        
        cell.bookTitleLabel.text = data.title
        cell.authorNameLabel.text = data.author
        cell.priceOfBookLabel.text = "\(formattedNumber(num: data.price))원"
        cell.ratingOfBookLabel.text = "\(data.rating) / 5.0"
        cell.pageOfBookLabel.text = "\(data.pageCount)p"
        cell.yearOfPublicationLabel.text = "\(data.publishYear)년"
        
//        if searchedBookList[currentIndex].isBestseller == false {
//            cell.bestsellerBadget.isHidden = true
//        } else {
//            cell.bestsellerBadget.isHidden = false
//        }
        cell.bestsellerBadget.isHidden = data.isBestseller ? false : true
        
        var genreName = ""
        switch data.genre {
        case 100: genreName = "소설"
        case 200: genreName = "에세이"
        case 300: genreName = "자기계발"
        case 400: genreName = "역사"
        case 500: genreName = "과학"
        case 600: genreName = "시/문학"
        case 700: genreName = "경제/경영"
            
        default:
            genreName = "장르"
        }
        
        cell.genreLabel.text = "장르: \(genreName)"
        
        return cell
    }
    

    
}
