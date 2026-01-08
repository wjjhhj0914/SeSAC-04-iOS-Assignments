//
//  SearchViewController.swift
//  Day03_Assignment02
//
//  Created by Hyojung Jang on 1/5/26.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var releaseContentsButton: UIButton!
    @IBOutlet var popularContentsButton: UIButton!
    @IBOutlet var topContentsButton: UIButton!
    
    @IBOutlet var resultLabel1: UILabel!
    
    
    func setButtonDesign(name: UIButton) {
        name.layer.cornerRadius = 12
        name.setTitleColor(.white, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonDesign(name: releaseContentsButton)
        setButtonDesign(name: popularContentsButton)
        setButtonDesign(name: topContentsButton)
        
        releaseContentsButton.setTitleColor(.black, for: .normal)
        releaseContentsButton.setTitleColor(.red, for: .highlighted)
    }
    
    @IBAction func contentsButtonClicked(_ sender: UIButton) {
        resultLabel1.text = sender.currentTitle
    }
    
    
    

}
