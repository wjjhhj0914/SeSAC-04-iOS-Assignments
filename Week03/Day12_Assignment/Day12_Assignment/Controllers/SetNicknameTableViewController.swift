//
//  SetNicknameTableViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/15/26.
//

import UIKit

class SetNicknameTableViewController: UITableViewController {
    
    @IBOutlet var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet var nicknameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userNickname = UserDefaults.standard.string(forKey: "nickname")
        
        if userNickname != nil {
            nicknameTextField.text = userNickname
        } else {
            nicknameTextField.text = ""
        }
    }
    
    @IBAction func doneBarButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        UserDefaults.standard.set(nicknameTextField.text, forKey: "nickname")
    }
    
    @IBAction func nicknameTextFieldDidEndOnExit(_ sender: UITextField) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
