//
//  Cities.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import Foundation

protocol Cities {
    
    var list: [String] { get }
    var listWithWeather: [String: Weather] { get }
    var count: Int { get }
    mutating func add(city: String)
    mutating func removeCity(at index: Int)
    mutating func addWeatherFor(city: String, weather: Weather)
    
}

final class CitiesImpl: Cities {
    
    static var shared: Cities = CitiesImpl()
    
    var list: [String] { return arrayOfCities }
    var listWithWeather: [String: Weather] { return  dictionaryOfCitiesWithWeather }
    var count: Int { return arrayOfCities.count }
    
    private var arrayOfCities: [String] = [
        "Дубай",
        "Женева",
        "Уфа",
        "Норильск",
        "Иркутск",
        "Орск",
        "Рангун",
        "Иркутск",
        "Огайо",
        "Самара"
    ]
    
    private var dictionaryOfCitiesWithWeather: [String: Weather] = [:]
    
    private init() {}
    
    func add(city: String) {
        arrayOfCities.append(city.capitalized)
    }
    
    
    func removeCity(at index: Int) {
        arrayOfCities.remove(at: index)
    }
    
    func addWeatherFor(city: String, weather: Weather) {
        dictionaryOfCitiesWithWeather[city.capitalized] = weather
    }
    
}

// Защита от случайного клонирования
extension CitiesImpl: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
