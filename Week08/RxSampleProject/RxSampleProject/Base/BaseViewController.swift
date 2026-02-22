//
//  ViewController.swift
//  RxSampleProject
//
//  Created by Hyojung Jang on 2/22/26.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        bind()
        
        view.backgroundColor = .white
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
    func bind() {}
}
