//
//  RadioViewController.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/09/05.
//

import UIKit
import Network

class RadioViewController: UIViewController {
    
    @IBOutlet weak var othersTableView: UITableView!
    
    var userName: String?
    var results: [NWBrowser.Result] = [NWBrowser.Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


// 현재는 테이블뷰로 구현w
// - 추후 좌우로 넘기며 선택하는 디자인 구현하고 싶음..
//extension RadioViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}

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

