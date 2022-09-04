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
    
    // 기본적인 설정 함수
    func setup() {
        userNameTextField.delegate = self
        self.userNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
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
    
    /// 이름 정하기 버튼을 탭하면 이름 확정을 여부를 묻는 팝업 후, 다음 화면으로 이동
    /// - Parameter sender: 터치한 버튼 객체
    @IBAction func confirmNameButtonTapped(_ sender: UIButton) {
        
        lazy var alert = UIAlertController(title: "\(userNameLabel.text!)", message: "정말 이 이름으로 하시겠습니까?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "네!", style: .destructive, handler: {_ in
            // 다음 화면 present 하기
            self.performSegue(withIdentifier: "toRadioVC", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "아니오!", style: .cancel, handler: { _ in
            // 이름 다시 설정하도록 namelabel 바꾸기?
        }))
        
        guard let nameText = userNameTextField.text else {
            print("텍스트 내용 없음")
            userNameLabel.text = "이름이 없습니다! 이름을 정해주세요"
            return
        }
        
        if nameText == "" {
            userNameLabel.text = "이름이 없습니다! 내 이름은...?"
        } else {
            present(alert, animated: true)
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
    
    // 텍스트필드가 클리어되면 라벨도 클리어
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        userNameLabel.text = "내 이름은...?"
        return true
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        userNameLabel.text = userNameTextField.text
    }
    
    // MARK: TO DO
    // 한글의 경우 최대 문자 제한을 깔끔하게 하기.
    
    // 텍스트필드 입력 글자 수 8자로 제한
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
        
        // 특문이 있다면 false
        if !string.hasCharacters() {
            textField.shake()
            return false
        }

        // 글자 수 제한
        guard textField.text!.count < 8 else {
            textField.shake()
            return false
        }
        
        return true
    }
}
