//
//  HeaderTableViewCell.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import UIKit
import SDWebImageSVGCoder

class HeaderTableViewCell: UITableViewCell {

    public class var identifier: String {
        return String(describing: self)
    }
    
    public var weatherModel: WeatherModel?
    
    private var nameLabel = UILabel()
    private var conditionLabel = UILabel()
    private var tempLabel = UILabel()
    private var minMaxLabel = UILabel()
    private var weatherConditionImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(weatherConditionImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(minMaxLabel)
        
        configuringNameLabel()
        configuringConditionLabel()
        configuringTempLabel()
        configuringMinMaxLabel()
        
        setNameLabelConstraints()
        setConditionLabelConstraints()
        setTempLabelConstraints()
        setMinMaxLabelConstraints()
        setWeatherConditionImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuringNameLabel() {
        nameLabel.font = UIFont.roundedFont(ofSize: 30, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .center
        nameLabel.text = "Загрузка..."
    }
    
    private func configuringConditionLabel() {
        conditionLabel.font = UIFont.roundedFont(ofSize: 20, weight: .medium)
        conditionLabel.textColor = .label
        conditionLabel.textAlignment = .center
        conditionLabel.text = "Загрузка..."
    }
    
    private func configuringTempLabel() {
        tempLabel.font = UIFont.roundedFont(ofSize: 40, weight: .medium)
        tempLabel.textColor = .label
        tempLabel.textAlignment = .center
        tempLabel.text = "0°C"
    }
    
    private func configuringMinMaxLabel() {
        minMaxLabel.font = UIFont.roundedFont(ofSize: 20, weight: .medium)
        minMaxLabel.textColor = .label
        minMaxLabel.textAlignment = .center
        minMaxLabel.text = "Мин: 0°C  Макс: 0°C"
    }
    
    private func setNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
    
    private func setConditionLabelConstraints() {
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conditionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            conditionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setWeatherConditionImageViewConstraints() {
        weatherConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherConditionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherConditionImageView.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 10),
            weatherConditionImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherConditionImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setTempLabelConstraints() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: weatherConditionImageView.bottomAnchor, constant: 10)
        ])
    }
    
    private func setMinMaxLabelConstraints() {
        minMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minMaxLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            minMaxLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            minMaxLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    public func set(city: String?, weather: Weather?) {
        if let city = city, let weather = weather {
            nameLabel.text = city
            conditionLabel.text = weatherModel?.localizationOfWeatherConditions(condition: weather.fact.condition)
            let temp = weather.fact.temp
            tempLabel.text = temp > 0 ? "+\(temp)°C" : "\(temp)°C"
            if let tempMin = weather.forecasts.first?.parts.evening.tempMin, let tempMax = weather.forecasts.first?.parts.day.tempMax {
                minMaxLabel.text = tempMin > 0 ? "Мин: +\(tempMin)  " : "Мин: \(tempMin)  "
                minMaxLabel.text! += tempMax > 0 ? "Макс: +\(tempMax)" : "Макс: \(tempMax)"
            }
            if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weather.fact.icon).svg") {
                weatherConditionImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
}
