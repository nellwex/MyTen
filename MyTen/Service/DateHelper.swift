//
//  DateHelper.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import Foundation

extension Date{
    
    func descriptiveString(dateStyle: DateFormatter.Style = .short) -> String{
        
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        
        let dayBetween = self.dayBetween(date:Date())
        
        if dayBetween == 0 {
            return "Today"
        }
        
        else if dayBetween == 1 {
            return "YesterDay"
        }
        else if dayBetween < 5 {
            let weekdayIndex = Calendar.current.component(.weekday, from: self) - 1
            return formatter.weekdaySymbols[weekdayIndex]
        }
        return formatter.string(from: self)
    }
    
    func dayBetween (date: Date) -> Int {
        
        let calender = Calendar.current
        let date1 = calender.startOfDay(for: self)
        let date2 = calender.startOfDay(for: date)
        if let dayBetween = calender.dateComponents([.day], from: date1, to: date2).day{
            return dayBetween
        }
        return 0
    }
    
    
}
