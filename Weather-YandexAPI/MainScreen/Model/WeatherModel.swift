//
//  WeatherModel.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import Foundation

protocol WeatherModel {
    var namesOfAdditionalInformation: [String] { get }
    func configuringAdditionalInformationValues(weather: Weather) -> [String]
    func localizationOfWeatherConditions(condition: String) -> String
    func localizationOfTheWindDirection(windDirection: String) -> String
}

final class WeatherModelImpl: WeatherModel {
    
    // MARK: - Public Properties
    
    // Список названий параметров для дополнительной информации
    let namesOfAdditionalInformation: [String] = ["ВОСХОД СОЛНЦА",
                                                  "ЗАХОД СОЛНЦА",
                                                  "ОЩУЩАЕТСЯ КАК",
                                                  "ВЛАЖНОСТЬ",
                                                  "ВЕТЕР",
                                                  "ДАВЛЕНИЕ"]
    
    // MARK: - Public Methods
    
    // Список значений параметров для дополнительной информации
    public func configuringAdditionalInformationValues(weather: Weather) -> [String] {
        var result: [String] = []
        if let day = weather.forecasts.first {
            result.append("\(day.sunrise)")
            result.append("\(day.sunset)")
            result.append(weather.fact.feelsLike > 0 ? "+\(weather.fact.feelsLike)°C" : "\(weather.fact.feelsLike)°C")
            result.append("\(weather.fact.humidity)")
            result.append("\(localizationOfTheWindDirection(windDirection: weather.fact.windDirection)) \(weather.fact.windSpeed) м/с")
            result.append("\(weather.fact.pressure) мм рт. ст.")
        }
        return result
    }
    
    // Локализация погодных условий
    public func localizationOfWeatherConditions(condition: String) -> String {
        switch condition {
        case "clear":
            return "Ясно"
        case "partly-cloudy":
            return "Малооблачно"
        case "cloudy":
            return "Облачно с прояснениями"
        case "overcast":
            return "Пасмурно"
        case "drizzle":
            return "Морось"
        case "light-rain":
            return "Небольшой дождь"
        case "rain":
            return "Дождь"
        case "moderate-rain":
            return "Умеренно сильный дождь"
        case "heavy-rain":
            return "Сильный дождь"
        case "continuous-heavy-rain":
            return "Длительный сильный дождь"
        case "showers":
            return "Ливень"
        case "wet-snow":
            return "Дождь со снегом"
        case "light-snow":
            return "Небольшой снег"
        case "snow":
            return "Снег"
        case "snow-showers":
            return "Снегопад"
        case "hail":
            return "Град"
        case "thunderstorm":
            return "Гроза"
        case "thunderstorm-with-rain":
            return "Дождь с грозой"
        case "thunderstorm-with-hail":
            return "Гроза с градом"
        default:
            return ""
        }
    }
    
    // Локализация направления ветра
    public func localizationOfTheWindDirection(windDirection: String) -> String {
        switch windDirection {
        case "nw":
            return "Северо-западный"
        case "n":
            return "Северный"
        case "ne":
            return "Северо-восточный"
        case "e":
            return "Восточный"
        case "se":
            return "Юго-восточный"
        case "s":
            return "Южный"
        case "sw":
            return "Юго-заподный"
        case "w":
            return "Заподный"
        case "с":
            return "Штиль"
        default:
            return ""
        }
    }
}
