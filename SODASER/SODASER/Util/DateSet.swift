//
//  DateSet.swift
//  SODASER
//
//  Created by 유영웅 on 2023/03/06.
//

import Foundation

extension Date {
    
    func StringToDate(stringDate:String) -> Date{
        let dateFormatter = DateFormatter()
       // print(stringDate)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"  //"2023-03-04T05:34:50"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        //print(dateFormatter.date(from: stringDate)?.addingTimeInterval(32400) ?? Date())
        return dateFormatter.date(from: stringDate)?.addingTimeInterval(32400) ?? Date()
    }
    func DatetoString(stringDate:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter.string(from: stringDate)
    }
    
    func relativeTime(postingDate:Date) -> String{
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateTimeStyle = .named    //지금 .numeric = 0초전
        return formatter.localizedString(for: postingDate, relativeTo: .now)
    }
}
