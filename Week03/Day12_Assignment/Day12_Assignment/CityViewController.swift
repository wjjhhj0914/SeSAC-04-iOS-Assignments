//
//  CityViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/14/26.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet var headerTitleLabel: UILabel!
    @IBOutlet var headerSegmentedControl: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerTitleLabel.text = "인기 도시"
        headerTitleLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        headerTitleLabel.textAlignment = .center
        
        headerSegmentedControl.setTitle("모두", forSegmentAt: 0)
        headerSegmentedControl.setTitle("국내", forSegmentAt: 1)
        headerSegmentedControl.setTitle("해외", forSegmentAt: 2)
        

    }


}
