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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    


}

extension RadioViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
     
}

extension RadioViewController: UITableViewDelegate {
    
    
}
