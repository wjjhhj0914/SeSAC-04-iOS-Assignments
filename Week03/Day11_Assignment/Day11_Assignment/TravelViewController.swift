//
//  TravelViewController.swift
//  Day11_Assignment
//
//  Created by Hyojung Jang on 1/13/26.
//

import UIKit

class TravelViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {

    @IBOutlet var headerTitleLabel: UILabel!
    @IBOutlet var headerDividerView: UIView!
    @IBOutlet var headerSegmentedControl: UISegmentedControl!
    @IBOutlet var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        cityTableView.delegate = self
//        cityTableView.dataSource = self
        
        headerTitleLabel.text = "인기 도시"
        headerTitleLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        
        headerDividerView.backgroundColor = .systemGray6
        
        headerSegmentedControl.setTitle("도시", forSegmentAt: 0)
        headerSegmentedControl.setTitle("국내", forSegmentAt: 1)
        headerSegmentedControl.setTitle("해외", forSegmentAt: 2)
        
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: String, for: <#T##IndexPath#>)
//    }


}
