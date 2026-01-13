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
    @IBOutlet var searchCityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        let xib = UINib(nibName: TravelTableViewCell.identifier, bundle: nil)
        cityTableView.register(xib, forCellReuseIdentifier: TravelTableViewCell.identifier)
        
        searchCityTextField.layer.cornerRadius = 8
        searchCityTextField.layer.borderWidth = 2
        searchCityTextField.layer.borderColor = UIColor.systemGray6.cgColor
        searchCityTextField.clipsToBounds = true
        searchCityTextField.placeholder = "도시를 검색하세요"
        
        filteredCityList = cityInformation.city

        headerTitleLabel.setMainTitleLabel(titleText: "인기 도시")
        headerDividerView.setDivider()
        headerSegmentedControl.setSegmentTitle()
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
        } else if sender.selectedSegmentIndex == 2 {
            print("나 2번")
            filteredCityList = cityInformation.internationalCities
        }
        cityTableView.reloadData()
    }
    
    @IBAction func searchCityTextFieldClicked(_ sender: UITextField) {
        let text = searchCityTextField.text

        let result = cityInformation.city.filter { $0.city_name.contains(text!) || $0.city_english_name.contains(text!) || $0.city_explain.contains(text!)}
        
        filteredCityList.removeAll()
        
        filteredCityList.append(contentsOf: result)
        print(filteredCityList)
        cityTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
        let row = filteredCityList[indexPath.row]
        
        cell.configure(row: row)
        
        return cell
    }
}
