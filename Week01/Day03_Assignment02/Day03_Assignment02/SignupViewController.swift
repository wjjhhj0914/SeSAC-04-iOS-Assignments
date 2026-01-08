//
//  SignupViewController.swift
//  Day03_Assignment02
//
//  Created by Hyojung Jang on 1/4/26.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var welcomeCodeTextField: UITextField!
    @IBOutlet var signupBtn: UIButton!
    @IBOutlet var switchBtn: UISwitch!
    
    @IBAction func signupBtnClicked(_ sender: UIButton) {
        print("버튼 클릭됨")
        
        print(emailTextField.text!)
        print(passwordTextField.text!)
        print(nicknameTextField.text!)
        print(locationTextField.text!)
        print(welcomeCodeTextField.text!)
        
        view.endEditing(true)
    }
    
    @IBAction func signupTextFieldDidEndOnExit(_ sender: UITextField) {
        print("Did End On Exit")
    }
    
    @IBAction func signupTapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setTextFieldDesign(name: UITextField, text: String) {
        name.placeholder = text
        name.textColor = UIColor.white
        name.textAlignment = NSTextAlignment.center
        name.layer.cornerRadius = 4
        name.clipsToBounds = true
        name.backgroundColor = UIColor.systemGray4
        
        if name == passwordTextField {
            name.isSecureTextEntry = true
        }
        
        name.keyboardType = (name == emailTextField) ? .emailAddress : .default
    }
    
    func setSignupButtonDesign(button: UIButton, text: String) {
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldDesign(name: emailTextField, text: "이메일 주소 또는 전화번호")
        setTextFieldDesign(name: passwordTextField, text: "비밀번호")
        setTextFieldDesign(name: nicknameTextField, text: "닉네임")
        setTextFieldDesign(name: locationTextField, text: "위치")
        setTextFieldDesign(name: welcomeCodeTextField, text: "추천 코드 입력")

        setSignupButtonDesign(button: signupBtn, text: "회원가입")
        
        switchBtn.setOn(true, animated: true)
        switchBtn.onTintColor = UIColor(red: 206/255, green: 80/255, blue: 64/255, alpha: 1)
    }
}
