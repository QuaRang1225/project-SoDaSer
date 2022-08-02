//
//  FormatterClass.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/27.
//
import SwiftUI

class FormatterClass{
    var yearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'년' MM'월' dd'일' a HH':'mm':'ss"
        return formatter

    }
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm a"
        return formatter
        
    }
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm':'ss a"
        return formatter

    }
    
    var timerFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm':'ss"
        return formatter

    }
    var yearsettingFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'년' MM'월' dd'일' a HH':'mm':'00"
        return formatter

    }
}
