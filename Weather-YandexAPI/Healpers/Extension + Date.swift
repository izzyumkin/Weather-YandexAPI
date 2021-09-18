//
//  Extension + Date.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import Foundation

extension Date {
    
    static var dyaNameFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    static func getTheNamesOfTheDaysOfTheWeek() -> [String] {
        var resultArray: [String] = []
        for i in 1...7 {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: Date()) {
                resultArray.append(Date.dyaNameFormatter.string(from: date).capitalized)
            }
        }
        return resultArray
    }

}
