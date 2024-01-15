//
//  String+Extension.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/12/24.
//

import Foundation

extension String {
    var convertToChatRoomDate: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = inputDateFormatter.date(from: self) else { return "" }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.locale = Locale(identifier: "ko-KR")
        outputDateFormatter.dateFormat = "HH:mm a"
        
        return outputDateFormatter.string(from: date)
    }
    
    var convertToChatListDate: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = inputDateFormatter.date(from: self) else { return "" }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.locale = Locale(identifier: "ko-KR")
        outputDateFormatter.dateFormat = "yy.MM.dd"
        
        return outputDateFormatter.string(from: date)
    }
    
    var convertToDateString: String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = inputDateFormatter.date(from: self) else { return "" }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.locale = Locale(identifier: "ko-KR")
        outputDateFormatter.dateFormat = "yyyy년 M월 d일 E요일"
        
        return outputDateFormatter.string(from: date)
    }
}
