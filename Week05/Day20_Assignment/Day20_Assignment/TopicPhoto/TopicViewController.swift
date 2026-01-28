//
//  TopicViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/27/26.
//

import UIKit

class TopicViewController: BaseViewController {
    
    var goldenHourList: [Photo] = []
    var businessList: [Photo] = []
    var architectureList: [Photo] = []
    
    let topics = ["golden-hour", "business-work", "architecture-interior"]

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func fetchData() {
        NetworkManager.shared.callRequestTopic(topicName: topics[0]) { photos in
            self.goldenHourList = photos
            print("Golden hour data arrived!!!")
        }
        
        NetworkManager.shared.callRequestTopic(topicName: topics[1]) { photos in
            self.businessList = photos
            print("Business data arrived ~")
        }
        
        NetworkManager.shared.callRequestTopic(topicName: topics[2]) { photos in
            self.architectureList = photos
            print("Architecture interior data arrived!!")
        }
    }
    

}
