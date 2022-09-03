//
//  String+Extensions.swift
//  Walkie-Talkie
//
//  Created by SEUNGYONG KWON on 2022/09/03.
//

import Foundation

extension String {
    
    // 주어진 문자열에서 특문이 있는지 없는지 판단하는 함수
    // 특문이 없다면 true, 특문이 있다면 false 반환
    func hasCharacters() -> Bool{
        do{
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ\\s]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)){
                return true
            }
        }catch{
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
}
