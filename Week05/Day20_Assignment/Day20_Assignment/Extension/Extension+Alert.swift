//
//  Extension+Alert.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/27/26.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
