//
//  SettingsTableViewController.swift
//  Day08_Assignment
//
//  Created by Hyojung Jang on 1/8/26.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    let sample1 = ["공지사항", "실험실", "버전 정보"]
    let sample2 = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let sample3 = ["고객센터/도움말"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
    }
    
    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // 셀 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sample1.count
        } else if section == 1 {
            return sample2.count
        } else if section == 2 {
            return sample3.count
        } else {
            return 0
        }
    }
    
    // 셀 디자인 및 데이터 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = sample1[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = sample2[indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = sample3[indexPath.row]
        }
        return cell
    }
    
    // 셀 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // 셀 헤더
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else if section == 2 {
            return "기타"
        } else {
            return "전체 설정"
        }
    }
}
