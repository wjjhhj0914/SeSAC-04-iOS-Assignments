//
//  TouristViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/14/26.
//

import UIKit

class TouristViewController: UIViewController {
    
    @IBOutlet var touristCityLabel: UILabel!
    @IBOutlet var touristLocationLabel: UILabel!
    @IBOutlet var anotherCityButton: UIButton!
    
    var clickedCityData: City?

    override func viewDidLoad() {
        super.viewDidLoad()

        touristCityLabel.text = clickedCityData?.city_name
        touristLocationLabel.text = clickedCityData?.city_explain
        
        anotherCityButton.addTarget(self, action: #selector(anotherCityButtonPopped), for: .touchUpInside)
    }

    @objc func anotherCityButtonPopped() {
        navigationController?.popViewController(animated: true)
    }
}
