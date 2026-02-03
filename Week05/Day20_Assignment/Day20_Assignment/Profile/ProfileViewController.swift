//
//  ProfileViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 2/3/26.
//

import UIKit
import SnapKit

enum ValidationError: Error, LocalizedError {
    case invalidYear
    case invalidMonth
    case invalidDay
    
    var errorDescription: String? {
        switch self {
        case .invalidYear:
            return "부적절한 연도입니다. 1900년부터 2026년 사이로 입력해 주세요."
        case .invalidMonth:
            return "부적절한 달입니다. 월은 1월부터 12월 사이로 입력해 주세요."
        case .invalidDay:
            return "부적절한 날짜입니다. 일은 1일부터 31일 사이로 입력해 주세요."
        }
    }
}

final class ProfileViewController: BaseViewController {
    
    private let yearTextField = UITextField()
    private let monthTextField = UITextField()
    private let dayTextField = UITextField()
    private let allSetButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "프로필 설정"
    }
    
    private func validateUserInput() throws(ValidationError) -> Bool {
        let yearUserInput = yearTextField.text ?? ""
        let monthUserInput = monthTextField.text ?? ""
        let dayUserInput = dayTextField.text ?? ""
        
        guard yearUserInput.count == 4, let validYear = Int(yearUserInput), (1900...2026).contains(validYear) else {
            throw .invalidYear
        }
        
        guard monthUserInput.count < 3, let validMonth = Int(monthUserInput), (1...12).contains(validMonth) else {
            throw .invalidMonth
        }
        
        guard dayUserInput.count < 3, let validDay = Int(dayUserInput), (1...31).contains(validDay) else {
            throw .invalidDay
        }
        
        return true
    }
    
    @objc private func allSetButtonTapped() {
        do {
            let result = try validateUserInput()
            
            allSetButton.setTitle("생년월일이 정상적으로 저장되었습니다!", for: .normal)
            allSetButton.titleLabel?.font = .systemFont(ofSize: 12)
            allSetButton.backgroundColor = .systemBlue
            view.endEditing(true)
        } catch {
            switch error {
            case .invalidYear, .invalidMonth, .invalidDay:
                allSetButton.setTitle(error.localizedDescription, for: .normal)
            }
            allSetButton.backgroundColor = .systemRed
            allSetButton.titleLabel?.font = .systemFont(ofSize: 12)
        }
    }
    
    override func configureHierarchy() {
        [yearTextField, monthTextField, dayTextField, allSetButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(yearTextField)
            make.height.equalTo(yearTextField)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(monthTextField)
            make.height.equalTo(monthTextField)
        }
        
        allSetButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(yearTextField)
            make.height.equalTo(55)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        [yearTextField, monthTextField, dayTextField].forEach {
            $0.keyboardType = .numberPad
            $0.borderStyle = .none
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray6.cgColor
            $0.layer.cornerRadius = 12
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            $0.leftViewMode = .always
            $0.font = .systemFont(ofSize: 14)
        }
        
        yearTextField.placeholder = "태어난 연도를 입력하세요 (ex: 90년생이면 1990)"
        monthTextField.placeholder = "태어난 달을 입력하세요"
        dayTextField.placeholder = "태어난 날짜를 입력하세요"
        
        allSetButton.setTitle("확인", for: .normal)
        allSetButton.backgroundColor = .lightGray
        allSetButton.layer.cornerRadius = 12
        allSetButton.addTarget(self, action: #selector(allSetButtonTapped), for: .touchUpInside)
    }
}
