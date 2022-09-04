//
//  RadioViewController.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/09/05.
//

import UIKit

class RadioViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var frequencyTextField: UITextField!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    var nameText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = nameText
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
