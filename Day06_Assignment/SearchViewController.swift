//
//  SearchViewController.swift
//  Day06_Assignment
//
//  Created by Hyojung Jang on 1/6/26.
//

import UIKit

class SearchViewController: UIViewController {
    
    let wordsDictionary: [String: String] = ["감다뒤": "감이 뒤떨어지네의 줄임말", "막나귀": "막상 나가려니 귀찮다의 줄임말", "위쑤시개": "스트레스 받을 때 먹는 매운 음식", "느좋": "느낌의 좋다의 줄임말", "추구미": "내가 추구하는 이미지의 줄임말", "콜건적": "콜라만 건강하게 먹는 사람들을 일컫는 말", "억텐": "억지 텐션의 줄임말", "가나디": "MZ세대가 강아지를 귀엽게 부르는 말", "레게노": "Legend의 변형으로, 대단하다는 의미", "스불재": "스스로 불러온 재앙의 줄임말", "랜선생님": "랜선(온라인)으로 큰 가르침을 주는 사람", "JMT": "정말 맛있다의 줄임말", "윰차": "유모차의 줄임말", "실매": "실시간 매니저의 줄임말, 주로 유튜브나 라이브 방송 등에서 쓰임", "만만잘부": "만나서 반가워 잘 부탁해의 줄임말", "꾸안꾸": "꾸민 듯 안 꾸민 듯의 줄임말", "알잘딱깔센": "알아서 잘 딱 깔끔하고 센스 있게의 줄임말"]
    
    let wordsList = ["감다뒤", "막나귀", "위쑤시개", "느좋", "추구미", "콜건적", "억텐", "가나디", "레게노", "스불재", "렌선생님", "JMT", "윰차", "실매", "만만잘부", "꾸안꾸", "알잘딱깔센"]
    
    let wordsMeaningList = ["감이 뒤떨어지네의 줄임말", "막상 나가려니 귀찮다의 줄임말", "스트레스 받을 때 먹는 매운 음식", "느낌이 좋다의 줄임말", "내가 추구하는 이미지의 줄임말", "콜라만 건강하게 먹는 사람들을 일컫는 말", "억지 텐션의 줄임말", "MZ세대가 강아지를 귀엽게 부르는 말", "Legend의 변형으로, 대단하다는 의미", "스스로 불러온 재앙의 줄임말", "랜선(온라인)으로 큰 가르침을 주는 사람", "정말 맛있다의 줄임말", "유모차의 줄임말", "실시간 매니저의 줄임말, 주로 유튜브나 라이브 방송 등에서 쓰임", "만나서 반가워 잘 부탁해의 줄임말", "꾸민 듯 안 꾸민 듯의 줄임말", "알아서 잘 딱 깔끔하고 센스 있게의 줄임말"]

    // 1 단계: Outlet 연결 및 UI 구성
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButtonIcon: UIButton!
    
    @IBOutlet var searchResultBtn1: UIButton!
    @IBOutlet var searchResultBtn2: UIButton!
    @IBOutlet var searchResultBtn3: UIButton!
    @IBOutlet var searchResultBtn4: UIButton!
    
    @IBOutlet var renderResultImage: UIImageView!
    @IBOutlet var renderResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchTextFieldStyle(myTextField: searchTextField)
        
        setSearchButtonIconStyle(button: searchButtonIcon)
        
        setSearchResultButtonStyle(button: searchResultBtn1, text: "윰차")
        setSearchResultButtonStyle(button: searchResultBtn2, text: "실매")
        setSearchResultButtonStyle(button: searchResultBtn3, text: "만만잘부")
        setSearchResultButtonStyle(button: searchResultBtn4, text: "꾸안꾸")
        
        renderResultImage.image = UIImage(named: "background")
        
        renderResultLabel.text = ""
    }
    
    // 텍스트 필드 하단의 추천 버튼과 레이블 연결
    @IBAction func searchResultBtnClicked(_ sender: UIButton) {
        searchTextField.text = sender.currentTitle
    }
    
    // 텍스트 필드 버튼 검색 아이콘 스타일링 함수
    func setSearchButtonIconStyle(button: UIButton) {
        button.backgroundColor = .black
        button.layer.borderColor = UIColor.black.cgColor
        button.tintColor = .white
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
    
    // 텍스트 필드 스타일링 함수
    func setSearchTextFieldStyle(myTextField: UITextField) {
        myTextField.borderStyle = .line
        myTextField.layer.borderWidth = 2
        myTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    // 버튼 스타일링 함수
    func setSearchResultButtonStyle(button: UIButton, text: String) {
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        button.setTitle(text, for: .normal)
    }
    
    // 배열로 구현
//    func searchingWordInArray() {
//        if let searchText = searchTextField.text {
//            if let index = wordsList.firstIndex(of: searchText) {
//                renderResultLabel.text = wordsMeaningList[index]
//            } else {
//                renderResultLabel.text = "검색 결과가 없습니다"
//            }
//        }
//    }
    
    // 딕셔너리로 구현
    func searchingWordInDictionary() {
        if let searchText = searchTextField.text {
            if let resultWord = wordsDictionary[searchText] {
                renderResultLabel.text = resultWord
            } else {
                renderResultLabel.text = "검색 결과가 없습니다"
            }
        }
    }
    
    // 2 단계: Tap Gesture
    @IBAction func myTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 3 단계: 검색 기능 구현
    // 검색 버튼을 눌렀을 때
    @IBAction func searchButtonClicked(_ sender: UIButton) {
//        searchingWordInArray()
        searchingWordInDictionary()
    }
    
    // 키보드의 Return 키를 눌렀을 때
    @IBAction func searchTextFieldWithPrimaryActionTriggered(_ sender: UITextField) {
//        searchingWordInArray()
        searchingWordInDictionary()
    }
    

}
