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
    
    // Список городов
    var list: [String] { return arrayOfCities }
    // Словарь Город:Погода
    var listWithWeather: [String: Weather] { return  dictionaryOfCitiesWithWeather }
    // Кол-во городов
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
    
    // Словарь с погодой по ключу "Город"
    private var dictionaryOfCitiesWithWeather: [String: Weather] = [:]
    
    private init() {}
    
    // Добавление нового города
    func add(city: String) {
        arrayOfCities.append(city.capitalized)
    }
    
    // Удаление города
    func removeCity(at index: Int) {
        arrayOfCities.remove(at: index)
    }
    
    // Сохранение погоды для города
    func addWeatherFor(city: String, weather: Weather) {
        dictionaryOfCitiesWithWeather[city.capitalized] = weather
    }
    
}

extension CitiesImpl: NSCopying {
    // Защита от случайного копирования
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
