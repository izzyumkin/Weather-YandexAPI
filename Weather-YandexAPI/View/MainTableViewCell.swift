//
//  MainTableViewCell.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import UIKit
import SwiftSVG

class MainTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    var city: String? {
        didSet {
            guard let city = city else { return }
            set(city: city)
        }
    }
    
    var weather: Weather? {
        didSet {
            guard let city = city else { return }
            set(city: city)
        }
    }
    
    var nameLabel = UILabel()
    var conditionLabel = UILabel()
    var tempLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(conditionLabel)
        addSubview(tempLabel)
        
        configureNameLabel()
        configureConditionLabel()
        configureTempLabel()
        
        setNameLabelConstraints()
        setConditionLabelConstraints()
        setTempLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNameLabel() {
        nameLabel.font = UIFont.roundedFont(ofSize: 20, weight: .medium)
        nameLabel.textColor = .label
    }
    
    func configureTempLabel() {
        tempLabel.font = UIFont.roundedFont(ofSize: 30, weight: .medium)
        tempLabel.textColor = .label
        tempLabel.textAlignment = .right
        tempLabel.text = "0°С"
    }
    
    func configureConditionLabel() {
        conditionLabel.font = UIFont.roundedFont(ofSize: 12, weight: .medium)
        conditionLabel.textAlignment = .right
        conditionLabel.textColor = .lightGray
        conditionLabel.text = "Загрузка..."
    }
    
    func setNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: conditionLabel.leadingAnchor, constant: -10)
        ])
    }
    
    func setConditionLabelConstraints() {
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conditionLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -10),
            conditionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            conditionLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])
    }
    
    func setTempLabelConstraints() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tempLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 75)
        ])
    }
    
    private func set(city: String) {
        nameLabel.text = city
        
        // Настраиваем погоду:
        guard let weather = weather else { return }
        let temp = weather.fact.temp
        if temp > 0 {
            tempLabel.text = "+\(temp)°С"
        } else {
            tempLabel.text = "\(temp)°С"
        }
        setNameLabelConstraints()
        setConditionLabelConstraints()
        setTempLabelConstraints()
        
        conditionLabel.text = setConditionDescription(condition: weather.fact.condition)
    }
    
    private func setConditionDescription(condition: String) -> String {
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

    
}
