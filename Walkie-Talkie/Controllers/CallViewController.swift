//
//  CallViewController.swift
//  Walkie-Talkie
//
//  Created by 권승용 on 2022/10/26.
//

import UIKit
import Network

class CallViewController: UIViewController {

    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var cancelCallButton: UIButton!
    
    var browseResult: NWBrowser.Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI() {
        cancelCallButton.clipsToBounds = true
        cancelCallButton.layer.cornerRadius = 20
        
        if let browseResult = browseResult, case let NWEndpoint.service(name: name, type: _, domain: _, interface: _) = browseResult.endpoint {
            opponentNameLabel.text = name
        }
    }

    @IBAction func cancelCallButtonTapped(_ sender: UIButton) {
        if let sharedConnection = sharedConnection {
            sharedConnection.cancel()
        }
        sharedConnection = nil
        sharedBrowser = nil
        sharedListener = nil
        dismiss(animated: true)
    }

}
