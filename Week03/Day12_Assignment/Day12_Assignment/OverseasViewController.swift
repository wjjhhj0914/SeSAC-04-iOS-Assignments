//
//  OverseasViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/14/26.
//

import UIKit

class OverseasViewController: UIViewController {
    
    @IBOutlet var overseasCityLabel: UILabel!
    
    var clickedCityData: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overseasCityLabel.text = "해외 명소: \(clickedCityData?.city_name ?? "없음")"
    }
    
}
