//
//  WalkieTalkieData+CoreDataProperties.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/08/27.
//
//

import Foundation
import CoreData


extension WalkieTalkieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WalkieTalkieData> {
        return NSFetchRequest<WalkieTalkieData>(entityName: "WalkieTalkieData")
    }

    @NSManaged public var userName: String?

}

extension WalkieTalkieData : Identifiable {

}
