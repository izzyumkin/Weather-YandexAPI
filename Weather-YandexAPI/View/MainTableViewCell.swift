//
//  MainTableViewCell.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import UIKit
import SDWebImageSVGCoder

class MainTableViewCell: UITableViewCell {
    
    public class var identifier: String {
        return String(describing: self)
    }
    
    public var city: String? {
        didSet {
            guard let city = city else { return }
            set(city: city)
        }
    }
    
    public var weather: Weather? {
        didSet {
            guard let city = city else { return }
            set(city: city)
        }
    }
    
    private var nameLabel = UILabel()
    private var tempLabel = UILabel()
    private var weatherConditionImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(tempLabel)
        addSubview(weatherConditionImageView)
        
        configureNameLabel()
        configureTempLabel()
        
        setNameLabelConstraints()
        setTempLabelConstraints()
        setWeatherConditionImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNameLabel() {
        nameLabel.font = UIFont.roundedFont(ofSize: 20, weight: .medium)
        nameLabel.textColor = .label
    }
    
    private func configureTempLabel() {
        tempLabel.font = UIFont.roundedFont(ofSize: 30, weight: .medium)
        tempLabel.textColor = .label
        tempLabel.textAlignment = .right
    }
    
    private func setNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -10)
        ])
    }
    
    private func setTempLabelConstraints() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: weatherConditionImageView.leadingAnchor, constant: -10)
        ])
    }
    
    private func setWeatherConditionImageViewConstraints() {
        weatherConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherConditionImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherConditionImageView.heightAnchor.constraint(equalToConstant: 40),
            weatherConditionImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherConditionImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    public func set(city: String) {
        nameLabel.text = city
        
        // Настраиваем погоду:
        guard let weather = weather else { return }
        let temp = weather.fact.temp
        tempLabel.text = temp > 0 ? "+\(temp)°С" : "\(temp)°С"
        
        if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weather.fact.icon).svg") {
            weatherConditionImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
