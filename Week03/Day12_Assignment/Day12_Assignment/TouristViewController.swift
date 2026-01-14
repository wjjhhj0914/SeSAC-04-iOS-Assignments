//
//  TouristViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/14/26.
//

import UIKit

import Kingfisher

class TouristViewController: UIViewController {
    
    @IBOutlet var touristCityLabel: UILabel!
    @IBOutlet var touristLocationLabel: UILabel!
    @IBOutlet var anotherCityButton: UIButton!
    @IBOutlet var touristCityImage: UIImageView!
    
    var clickedCityData: City?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "관광지 화면"
        
        let url = URL(string: clickedCityData?.city_image ?? "")
        touristCityImage.kf.setImage(with: url)
        touristCityImage.layer.cornerRadius = 14

        touristCityLabel.text = clickedCityData?.city_name
        touristLocationLabel.text = clickedCityData?.city_explain
        
        touristCityLabel.textAlignment = .center
        touristCityLabel.font = .systemFont(ofSize: 28, weight: .heavy)
        
        touristLocationLabel.textAlignment = .center
        touristLocationLabel.textColor = .gray
        
        anotherCityButton.backgroundColor = .systemBlue
        anotherCityButton.tintColor = .white
        anotherCityButton.setTitle("다른 관광지 보러 가기", for: .normal)
        
        anotherCityButton.addTarget(self, action: #selector(anotherCityButtonPopped), for: .touchUpInside)
        
        
    }

    @objc func anotherCityButtonPopped() {
        navigationController?.popViewController(animated: true)
    }
}
