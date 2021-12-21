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
    
    // MARK: - Public Properties
    
    public static var shared: Cities = CitiesImpl()
    /// Список городов
    public var list: [String] { return arrayOfCities }
    /// Словарь Город:Погода
    public var listWithWeather: [String: Weather] { return  dictionaryOfCitiesWithWeather }
    /// Кол-во городов
    public var count: Int { return arrayOfCities.count }
    
    // MARK: - Private Properties
    
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
    
    // MARK: - Public Methods
    
    // Добавление нового города
    public func add(city: String) {
        arrayOfCities.append(city.capitalized)
    }
    
    // Удаление города
    public func removeCity(at index: Int) {
        arrayOfCities.remove(at: index)
    }
    
    // Сохранение погоды для города
    public func addWeatherFor(city: String, weather: Weather) {
        dictionaryOfCitiesWithWeather[city.capitalized] = weather
    }
    
}

// MARK: - Extension NSCopying

extension CitiesImpl: NSCopying {
    // Защита от случайного копирования
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
