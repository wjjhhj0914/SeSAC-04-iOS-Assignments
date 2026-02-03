//
//  MainTabBarController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/27/26.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }
    
    private func setupTabs() {
        let topicVC = UINavigationController(rootViewController: TopicViewController())
        topicVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "photo"), tag: 0)
        
        let videoVC = UINavigationController(rootViewController: UIViewController())
        videoVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "play.rectangle"), tag: 1)
        
        let searchVC = UINavigationController(rootViewController: SearchPhotoViewController())
        searchVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        let likeVC = UINavigationController(rootViewController: UIViewController())
        likeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), tag: 3)
        
        setViewControllers([topicVC, videoVC, searchVC, likeVC], animated: true)
    }

}
