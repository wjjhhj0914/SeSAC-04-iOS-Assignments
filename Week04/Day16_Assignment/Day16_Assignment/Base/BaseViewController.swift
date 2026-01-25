//
//  BaseViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/25/26.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {
        view.backgroundColor = .black
    }
    func showAlert() {}
    func keyboardDismiss() {
        view.endEditing(true)
    }
}
