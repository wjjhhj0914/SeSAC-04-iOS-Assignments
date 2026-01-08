//
//  HomeViewController.swift
//  Day03_Assignment02
//
//  Created by Hyojung Jang on 1/5/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    let imageList: [String] = ["더퍼스트슬램덩크", "밀수", "범죄도시3", "서울의봄", "스즈메의문단속", "아바타물의길", "오펜하이머", "육사오", "콘크리트유토피아"]

    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var trendingMovieImageView1: UIImageView!
    @IBOutlet var trendingMovieImageView2: UIImageView!
    @IBOutlet var trendingMovieImageView3: UIImageView!
    
    @IBOutlet var trendingMovieBadgeImageView1: UIImageView!
    @IBOutlet var trendingMovieBadgeImageView2: UIImageView!
    
    func imageViewDesign(name: UIImageView, title: String, num: CGFloat) {
        name.image = UIImage(named: title)
        name.layer.cornerRadius = num
        name.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewDesign(name: mainImageView, title: "노량", num: 16)
        
        imageViewDesign(name: trendingMovieImageView1, title: "아바타물의길", num: 4)
        imageViewDesign(name: trendingMovieImageView2, title: "스즈메의문단속", num: 4)
        imageViewDesign(name: trendingMovieImageView3, title: "오펜하이머", num: 4)
        
        trendingMovieBadgeImageView1.image = UIImage(named: "top10 badge")
        trendingMovieBadgeImageView2.image = UIImage(named: "wordmark")
    }
    
    @IBAction func translateImageViewButton(_ sender: UIButton) {
        mainImageView.image = UIImage(named: "\(imageList[Int.random(in: 0...imageList.count - 1)])")
        
        
    }
}
