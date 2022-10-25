//
//  RadioViewController.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/09/05.
//

import UIKit
import Network

class RadioViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var othersTableView: UITableView!
    
    var userName: String?
    var results: [NWBrowser.Result] = [NWBrowser.Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        othersTableView.dataSource = self
        othersTableView.delegate = self
        
        // 이 화면에 진입하는 순간 자동으로 listener / browser 생성
        if sharedBrowser == nil {
            sharedBrowser = PeerBrowser(delegate: self)
        }
        if let listener = sharedListener {
            listener.resetName(userName!)
        } else {
            sharedListener = PeerListener(name: userName!, delegate: self)
        }
    }
    
    func resultRows() -> Int {
        if results.isEmpty {
            return 1
        } else {
            // 최대 8명의 peer까지 보이기
            return min(results.count, 8)
        }
    }
}


// 테이블뷰로 다른 peer들 뿌려주기
// - 추후 좌우로 넘기며 선택하는 디자인 구현하고 싶음..
extension RadioViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "joinRadioCell") as! PeerTableViewCell
        
        if results.isEmpty {
            cell.peerNameLabel.text = "다른 사람을 찾는 중입니다..."
            cell.peerNameLabel.textColor = .systemGray
        } else {
            let peerEndpoint = results[indexPath.row].endpoint
            if case let NWEndpoint.service(name: userName, type: _, domain: _, interface: _) = peerEndpoint {
                cell.peerNameLabel.text = userName
            } else {
                cell.peerNameLabel.text = "Unknown Endpoint..."
            }
        }
        
        return cell
    }
}

extension RadioViewController: UITableViewDelegate {
    
    
}

extension RadioViewController: PeerBrowserDelegate {
    
    // 브라우징 결과 새로고침하는 함수
    func refreshResults(results: Set<NWBrowser.Result>) {
        self.results = [NWBrowser.Result]()
        for result in results {
            if case let NWEndpoint.service(name: userName, type: _, domain: _, interface: _) = result.endpoint {
                if userName != self.userName {
                    self.results.append(result)
                }
            }
        }
    }
    
    // 브라우징 과정 중 에러 발생 시 호출하는 함수
    func displayBrowseError(_ error: NWError) {
        var message = "Error \(error)"
        if error == NWError.dns(DNSServiceErrorType(kDNSServiceErr_NoAuth)) {
            message = "네트워크 접근 권한 없음"
        }
        
        let alert = UIAlertController(title: "네트워크 오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "알겠습니다", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}

extension RadioViewController: PeerConnectionDelegate {
    func connectionReady() {
        
    }
    
    func connectionFailed() {
        
    }
    
    func connectionCanceled() {
        
    }
    
    func receivedAudio(data: Data) {
        
    }
    
    func displayAdvertiseError(_ error: NWError) {
        
    }
    
}
