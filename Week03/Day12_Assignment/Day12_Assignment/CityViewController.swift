//
//  CityViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/14/26.
//

import UIKit

class CityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var headerTitleLabel: UILabel!
    @IBOutlet var headerSegmentedControl: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        
        headerTitleLabel.text = "인기 도시"
        headerTitleLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        headerTitleLabel.textAlignment = .center
        
        headerSegmentedControl.setTitle("모두", forSegmentAt: 0)
        headerSegmentedControl.setTitle("국내", forSegmentAt: 1)
        headerSegmentedControl.setTitle("해외", forSegmentAt: 2)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: 170, height: 270)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        cityCollectionView.collectionViewLayout = layout
    }
    
    @objc func cityButtonClicked(sender: UIButton) {
        let index = sender.tag
        let selectedCity = CityInfo().city[index]
//        print("\(selectedCity.city_name) 클릭됨!!")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 국내
        if selectedCity.domestic_travel {
            let vc = sb.instantiateViewController(withIdentifier: "TouristViewController") as! TouristViewController
            
            vc.clickedCityData = selectedCity
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // 해외일 때
            let vc = sb.instantiateViewController(withIdentifier: "OverseasViewController") as! OverseasViewController
            
            vc.clickedCityData = selectedCity
            
            present(vc, animated: true)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        
        cell.cityButton.tag = indexPath.item
        
        cell.cityButton.addTarget(self, action: #selector(cityButtonClicked), for: .touchUpInside)
        
        return cell
    }
    



}
