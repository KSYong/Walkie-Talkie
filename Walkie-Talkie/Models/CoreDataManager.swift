//
//  CoreDataManager.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/08/27.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // 싱글턴 패턴 사용
    static let shared = CoreDataManager()
    private init() {}
    
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "WalkieTalkieData"
    
    
}
