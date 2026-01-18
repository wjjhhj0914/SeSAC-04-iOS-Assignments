//
//  HotPlacesViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/15/26.
//

import UIKit

class HotPlacesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var hotPlacesCollectionView: UICollectionView!
    
    let touristSpots = TouristSpotInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHotPlacesCollectionView()

        navigationItem.title = "Hot 명소"
    }
    
    func configureHotPlacesCollectionView() {
        hotPlacesCollectionView.delegate = self
        hotPlacesCollectionView.dataSource = self
        
        let hotPlacesXib = UINib(nibName: HotPlacesCollectionViewCell.identifier, bundle: nil)
        hotPlacesCollectionView.register(hotPlacesXib, forCellWithReuseIdentifier: HotPlacesCollectionViewCell.identifier)
        
        let adXib = UINib(nibName: AdCollectionViewCell.identifier, bundle: nil)
        hotPlacesCollectionView.register(adXib, forCellWithReuseIdentifier: AdCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        
        let collectionViewWidth = hotPlacesCollectionView.bounds.width
        
        let width = (collectionViewWidth - (spacing * 4)) / 3 // 양 옆 여백 포함 4번 뺌
        
        layout.itemSize = CGSize(width: width, height: width * 0.8)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        hotPlacesCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return touristSpots.spots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let locationInfo = touristSpots.spots[indexPath.item]
//        print(locationInfo)
        
        // 광고
        if locationInfo.ad {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCollectionViewCell.identifier, for: indexPath) as! AdCollectionViewCell
            
            cell.adNameLabel.text = locationInfo.koreanName
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotPlacesCollectionViewCell.identifier, for: indexPath) as! HotPlacesCollectionViewCell
            
            cell.placeNameLabel.text = locationInfo.koreanName
            cell.cityNameLabel.text = locationInfo.city
                        return cell
        }
    }

}
