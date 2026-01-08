//
//  EmotionViewController.swift
//  Day03_Assignment
//
//  Created by Hyojung Jang on 1/4/26.
//

import UIKit

class EmotionViewController: UIViewController {
    @IBOutlet var emotionBtn1: UIButton!
    @IBOutlet var emotionBtn2: UIButton!
    @IBOutlet var emotionBtn3: UIButton!
    @IBOutlet var emotionBtn4: UIButton!
    @IBOutlet var emotionBtn5: UIButton!
    @IBOutlet var emotionBtn6: UIButton!
    @IBOutlet var emotionBtn7: UIButton!
    @IBOutlet var emotionBtn8: UIButton!
    @IBOutlet var emotionBtn9: UIButton!
    
    @IBOutlet var emotionBtnList: [UIButton]!
    @IBOutlet var emotionNameList: [UILabel]!
    @IBOutlet var emotionCountList: [UILabel]!
    
    let emotionNameDescription = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "행복해", "행복해"]
    
    var counts = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, button) in emotionBtnList.enumerated() {
            let imageName = "mono_slime\(index + 1)"
            let image = UIImage(named: imageName)
            button.setImage(image, for: UIControl.State.normal)
        }
        
        for (index, name) in emotionNameList.enumerated() {
            let string = emotionNameDescription[index]
            name.text = string
        }
    }

    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        let clickedIndex = sender.tag
        print(clickedIndex)
        
        counts[clickedIndex] += 1
        
        emotionCountList[clickedIndex].text = "\(counts[clickedIndex])"
        
//        let number = Int.random(in: 0...100)
//        emotionCount.text = "\(number)"
    }
}
