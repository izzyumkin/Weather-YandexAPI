//
//  Weather.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import Foundation

struct Weather: Codable {
    let fact: Fact
    let forecasts: [Forecast]
}

struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let condition: String
    let icon: String
    let windSpeed: Double
    let windDirection: String
    let pressure: Int
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
        case icon
        case windSpeed = "wind_speed"
        case windDirection = "wind_dir"
        case pressure = "pressure_mm"
        case humidity
    }
}

struct Forecast: Codable {
    let date: String
    let sunrise: String
    let sunset: String
    let parts: Parts
}

struct Parts: Codable {
    let day: Day
    let evening: Evening
}

struct Day: Codable {
    let tempMin: Int
    let tempMax: Int
    let condition: String
    let icon: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case condition
        case icon
    }
}

struct Evening: Codable {
    let tempMin: Int
    let tempMax: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case condition
    }
}
