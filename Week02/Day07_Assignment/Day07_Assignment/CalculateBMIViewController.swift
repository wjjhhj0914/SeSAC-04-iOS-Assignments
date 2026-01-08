//
//  CalculateBMIViewController.swift
//  Day07_Assignment
//
//  Created by Hyojung Jang on 1/7/26.
//

import UIKit

class CalculateBMIViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var eyeButton: UIButton!
    
    @IBOutlet var calculateRandomBmiButton: UIButton!
    
    @IBOutlet var resultButton: UIButton!
    
    @IBOutlet var bmiResultLabel: UILabel!
    
    func setTextFieldDesign(myTextField: UITextField) {
        myTextField.layer.borderColor = UIColor.black.cgColor
        myTextField.layer.cornerRadius = 14
        myTextField.layer.borderWidth = 1
    }
    
    func setTextFieldErrorDesign(myTextField: UITextField) {
        myTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = .boldSystemFont(ofSize: 22)
        subtitleLabel.font = .systemFont(ofSize: 14)
        
        mainImage.image = UIImage(named: "image")
        
        setTextFieldDesign(myTextField: heightTextField)
        setTextFieldDesign(myTextField: weightTextField)
        
        eyeButton.tintColor = UIColor.systemGray
        
        calculateRandomBmiButton.tintColor = UIColor.systemBrown
        
        resultButton.backgroundColor = UIColor.purple
        resultButton.tintColor = UIColor.white
        
        bmiResultLabel.textAlignment = NSTextAlignment.center
    }
    
    
    @IBAction func returnButtonClicked(_ sender: UITextField) {
        print(#function)
    }

    @IBAction func secondReturnButtonClicked(_ sender: UITextField) {
        view.endEditing(true)
//        bmiCalculator()
        showResult()
    }
    
    @IBAction func thirdReturnButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
//        bmiCalculator()
        showResult()
    }
    
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 눈 이미지 변경하기
    @IBAction func eyeButtonClicked(_ sender: UIButton) {
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        // 흠...........
    }
    
    // 로직 분리
    func onlyCalculateBmi(height: Double, weight: Double) -> Dictionary<String, String> {
        let heightInMeter = height * 0.01
        let calculateBmi = weight / (heightInMeter * heightInMeter)
//        print(calculateBmi)
        
        var result: String = ""
        
        switch calculateBmi {
        case ..<18.5:
            result = "저체중"
        case 18.5..<23.0:
            result = "정상"
        case 23..<25.0:
            result = "비만 전 단계"
        case 25..<30.0:
            result = "1단계 비만"
        case 30..<35.0:
            result = "2단계 비만"
        case 35.0...:
            result = "3단계 비만"
        default: print("다시")
        }
        
        let finalBmiValue = String(format: "%.1f", calculateBmi)
        
        return ["BMI": finalBmiValue, "상태": result]
    }
    
    // UI 출력 분리
    func showResult() {
        heightTextField.layer.borderColor = UIColor.black.cgColor
        weightTextField.layer.borderColor = UIColor.black.cgColor
        bmiResultLabel.text = ""
        
        guard let userHeightInput = heightTextField.text, let userWeightInput = weightTextField.text, let isHeightNumber = Double(userHeightInput), let isWeightNumber = Double(userWeightInput), isHeightNumber > 0 && isHeightNumber < 300, isWeightNumber < 500 else {
            bmiResultLabel.text = "키와 몸무게를 적절한 수치로 입력해 주세요"
            
            setTextFieldErrorDesign(myTextField: heightTextField)
            setTextFieldErrorDesign(myTextField: weightTextField)
            return
        }
        
        let userBmiData = onlyCalculateBmi(height: isHeightNumber, weight: isWeightNumber)
        
        let finalBmiValue = userBmiData["BMI"]
        let finalBmiStatus = userBmiData["상태"]
        

        bmiResultLabel.text = "사용자님의 BMI는 \(finalBmiValue ?? "0.0")(으)로 \(finalBmiStatus ?? "")입니다."
    }
    
    
//    func bmiCalculator() {
//        // 값 초기화
//        heightTextField.layer.borderColor = UIColor.black.cgColor
//        weightTextField.layer.borderColor = UIColor.black.cgColor
//        bmiResultLabel.text = ""
//        
//        // 값 체크
//        guard let userHeightInput = heightTextField.text, let userWeightInput = weightTextField.text, let isHeightNumber = Double(userHeightInput), let isWeightNumber = Double(userWeightInput), isHeightNumber > 0 && isHeightNumber < 300, isWeightNumber < 500 else {
//            bmiResultLabel.text = "키와 몸무게를 적절한 수치로 입력해 주세요"
//            
//            setTextFieldErrorDesign(myTextField: heightTextField)
//            setTextFieldErrorDesign(myTextField: weightTextField)
//            return
//            
//        }
//        
////        print(isHeightNumber)
////        print(isWeightNumber)
//        
//        // BMI 계산
//        let heightInMeter = isHeightNumber * 0.01
////        print(heightInMeter)
//        let calculateBmi = isWeightNumber / (heightInMeter * heightInMeter)
//        print(calculateBmi)
//        
//        var result: String = ""
//        
////        if calculateBmi < 18.5 {
////            result = "저체중"
////        } else if calculateBmi < 23.0 {
////            result = "정상"
////        } else if calculateBmi < 25.0 {
////            result = "비만 전 단계"
////        } else if calculateBmi < 30.0 {
////            result = "1단계 비만"
////        } else if calculateBmi < 35.0 {
////            result = "2단계 비만"
////        } else {
////            result = "3단계 비만"
////        }
//        
//        switch calculateBmi {
//        case ..<18.5:
//            result = "저체중"
//        case 18.5..<23.0:
//            result = "정상"
//        case 23..<25.0:
//            result = "비만 전 단계"
//        case 25..<30.0:
//            result = "1단계 비만"
//        case 30..<35.0:
//            result = "2단계 비만"
//        case 35.0...:
//            result = "3단계 비만"
//        default: print("다시")
//        }
//        
//        // UI로 출력
//        let finalBmiValue = String(format: "%.1f", calculateBmi)
//        bmiResultLabel.text = "사용자님의 BMI는 \(finalBmiValue)(으)로 \(result)입니다."
//    }
    
    // 랜덤으로 BMI 계산하기
    @IBAction func calculateRandomBmiButtonClicked(_ sender: UIButton) {
        let randomHeight = Double.random(in: 130...200)
        let randomWeight = Double.random(in: 30...200)
        
        heightTextField.text = String(format: "%.1f", randomHeight)
        weightTextField.text = String(format: "%.1f", randomWeight)
        
        let userRandomBmiData = onlyCalculateBmi(height: randomHeight, weight: randomWeight)
        
        let finalBmiValue = userRandomBmiData["BMI"]
        let finalBmiStatus = userRandomBmiData["상태"]
        
        bmiResultLabel.text = "무작위로 생성한 키와 몸무게의 BMI는 \(finalBmiValue ?? "0.0")(으)로 \(finalBmiStatus ?? "")입니다."
        
//        let randomHeight = String(format: "%.1f", (Double.random(in: 130...200)))
//        heightTextField.text = randomHeight
//        
//        let randomWeight = String(format: "%.1f", (Double.random(in: 30...200)))
//        weightTextField.text = randomWeight
//        
//        onlyCalculateBmi(height: randomHeight, weight: randomWeight)
    }
    
    @IBAction func calculateBmiButton(_ sender: UIButton) {
//        bmiCalculator()
        showResult()
        
//        print(isHeightNumber)
//        print(isWeightNumber)
//        let number = isHeightNumber * 0.01
//        print(number)
//        print(isWeightNumber / (number * number))
//        let result = Double(String(format: "%.1f", isWeightNumber / (number * number)))
//        print(result!)
//        
////        let result = round((isWeightNumber / (number * number) * 100) / 100)
//        
//        if result < 18.5 {
//            print("저체중")
//        } else if result >= 18.5 && result < 22.9 {
//            print("정상")
//        } else if result >= 23 && result < 24.9 {
//            print("비만 전 단계")
//        } else if result >= 25 && result < 29.9 {
//            print("1단계 비만")
//        } else if result >= 30 && result < 24.9 {
//            print("2단계 비만")
//        } else if result > 35 {
//            print("3단계 비만")
//        } else {
//            print("읭?")
//        }
    }
    
}
