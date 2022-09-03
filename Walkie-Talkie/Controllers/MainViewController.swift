//
//  ViewController.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/08/26.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properites
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var confirmUserNameButton: UIButton!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    /// 델리게이트 설정 함수
    func setup() {
        userNameTextField.delegate = self
    }
    
    // UI 설정 함수
    func configureUI() {
        // 이름 입력란 텍스트필드 테두리 둥글게 처리
        userNameTextField.clipsToBounds = true
        userNameTextField.layer.cornerRadius = 8
        
        // 이름 입력란 텍스트필드 테두리 얇게 처리
        userNameTextField.layer.borderWidth = 0
        userNameTextField.borderStyle = .roundedRect
        
        // 한 번에 삭제 모드 추가
        userNameTextField.clearButtonMode = .whileEditing
        
        // 자동 문법 교정 없애기
        userNameTextField.autocorrectionType = .no
        userNameTextField.autocapitalizationType = .none
        
        // 이름 정하는 버튼 테두리 둥글게 및 배경색 + 글자색 바꾸기
        confirmUserNameButton.clipsToBounds = true
        confirmUserNameButton.layer.cornerRadius = 10
        
        confirmUserNameButton.backgroundColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1)
        confirmUserNameButton.setTitleColor(.white, for: .normal)
    }
    
    /// 이름 정하기 버튼 터치 시 실행되는 함수
    /// - Parameter sender: 터치한 버튼 객체
    @IBAction func confirmNameButtonTapped(_ sender: UIButton) {
        guard let nameText = userNameTextField.text else {
            print("텍스트 내용 없음")
            userNameLabel.text = "이름이 없습니다! 이름을 정해주세요"
            return
        }
        
        if nameText == "" {
            userNameLabel.text = "이름이 없습니다! 내 이름은...?"
        } else {
            userNameLabel.text = nameText
        }
    }
}

// MARK: - UITextField Delegate
extension MainViewController: UITextFieldDelegate {
    
    // 텍스트필드가 아닌 곳 터치하면 키보드 내려가게 하기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTextField.resignFirstResponder()
    }
    
    // 텍스트필드 입력 시작하면 테두리 강조
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userNameTextField.layer.borderWidth = 1
    }
    
    // 텍스트필드 입력 끝나면 테두리 강조 해제
    func textFieldDidEndEditing(_ textField: UITextField) {
        userNameTextField.layer.borderWidth = 0

    }
    
    // 텍스트필드 입력 글자 수 8자로 제한
    // 또한 텍스트필드에 문자열을 입력할 떄 마다 "내 이름은...?" 문자열이 실시간으로 입력한 문자로 바뀐다.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 붙여넣기 막기
        if string.count > 1 {
            textField.shake()
            return false
        }
        
        // 백스페이스 가능!
        if string.isEmpty {
            return true
        }
        
        // 글자 수 제한
        guard textField.text!.count < 8 else {
            textField.shake()
            return false
        }
        
        // 이름 라벨에 표시되는 텍스트 수정하기c
        userNameLabel.text = textField.text! + string
        return true
    }
}
