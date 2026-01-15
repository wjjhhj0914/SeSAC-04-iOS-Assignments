//
//  CityViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/14/26.
//

import UIKit

import Kingfisher

class CityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var headerSegmentedControl: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    @IBOutlet var userBarButtonItem: UIBarButtonItem!
    @IBOutlet var hotPlacesBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        
        navigationItem.title = "인기 도시"
        
        userBarButtonItem.image = UIImage(systemName: "person.fill")
        hotPlacesBarButtonItem.image = UIImage(systemName: "flame.fill")
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let savedUserNickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
  
        if savedUserNickname.isEmpty {
            navigationItem.title = "인기 도시"
        } else {
            navigationItem.title = "\(savedUserNickname)님 환영합니다!"
        }
    }
    
    var cityDetails = CityInfo()
    var filteredCityList: [City] = CityInfo().city
    
    func filterCity() {
        if headerSegmentedControl.selectedSegmentIndex == 1 {
            filteredCityList = cityDetails.domesticCities
//            print("국내: \(filteredCityList)")
        } else if headerSegmentedControl.selectedSegmentIndex == 2 {
            filteredCityList = cityDetails.internationalCities
//            print("해외: \(filteredCityList)")
        } else {
            filteredCityList = cityDetails.city
        }
        
        cityCollectionView.reloadData()
    }
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        filterCity()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        
        cell.cityButton.tag = indexPath.item
        cell.cityButton.addTarget(self, action: #selector(cityButtonClicked), for: .touchUpInside)
        
        let data = filteredCityList[indexPath.item]
        cell.cityName.text = "\(data.city_name) | \(data.city_english_name)"
        cell.locationLabel.text = data.city_explain
        
        let url = URL(string: data.city_image)
        cell.cityImage.kf.setImage(with: url)
        
        return cell
    }
    
    @IBAction func userBarButtonClicked(_ sender: UIBarButtonItem) {
//        print(#function, "버튼 클릭됨!!")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SetNicknameTableViewController") as! SetNicknameTableViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func cityButtonClicked(sender: UIButton) {
        let index = sender.tag
        let selectedCity = filteredCityList[index]
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
}
