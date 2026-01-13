//
//  TravelViewController.swift
//  Day11_Assignment
//
//  Created by Hyojung Jang on 1/13/26.
//

import UIKit

import Kingfisher

class TravelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 인스턴스 생성
    let cityInformation = CityInfo()
    
    var filteredCityList: [City] = []

    @IBOutlet var headerTitleLabel: UILabel!
    @IBOutlet var headerDividerView: UIView!
    @IBOutlet var headerSegmentedControl: UISegmentedControl!
    @IBOutlet var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        filteredCityList = cityInformation.city
//        print(list)
        
        headerTitleLabel.text = "인기 도시"
        headerTitleLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        
        headerDividerView.backgroundColor = .systemGray6
        
        headerSegmentedControl.setTitle("도시", forSegmentAt: 0)
        headerSegmentedControl.setTitle("국내", forSegmentAt: 1)
        headerSegmentedControl.setTitle("해외", forSegmentAt: 2)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cityInformation.city.count
        return filteredCityList.count
    }
    
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            filteredCityList = cityInformation.city
        } else if sender.selectedSegmentIndex == 1 {
            print("나 1번")
            filteredCityList = cityInformation.domesticCities
            print(filteredCityList)
        } else if sender.selectedSegmentIndex == 2 {
            print("나 2번")
            filteredCityList = cityInformation.internationalCities
            print(filteredCityList)
        }
        
        cityTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as! TravelTableViewCell
        
//        let row = cityInformation.city[indexPath.row]
        let row = filteredCityList[indexPath.row]
//        print(row)
        
        // 이미지 불러오기
        let url = URL(string: row.city_image)
        cell.cityImageView.kf.setImage(with: url)
        
        cell.cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        cell.cityExplainLabel.text = "  " + row.city_explain
        
        return cell
    }
}
