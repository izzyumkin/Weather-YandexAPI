//
//  MainTableViewCell.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import UIKit
import SDWebImageSVGCoder

final class MainTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public var city: String? {
        didSet {
            guard let city = city else { return }
            setupData(city: city)
        }
    }
    
    public var weather: Weather? {
        didSet {
            guard let city = city else { return }
            setupData(city: city)
        }
    }
    
    // MARK: - Private Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedFont(ofSize: 20, weight: .medium)
        label.textColor = .label
        return label
    }()
    private var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()
    private let weatherConditionImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        activityIndicator.startAnimating()
        
        addSubviews()
        setNameLabelConstraints()
        setTempLabelConstraints()
        setWeatherConditionImageViewConstraints()
        setActivityIndicatorConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupData(city: String) {
        nameLabel.text = city
        
        // Настраиваем погоду:
        guard let weather = weather else { return }
        let temp = weather.fact.temp
        tempLabel.text = temp > 0 ? "+\(temp)°С" : "\(temp)°С"
        
        if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weather.fact.icon).svg") {
            weatherConditionImageView.sd_setImage(with: url) { _, _, _, _ in
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherConditionImageView)
        contentView.addSubview(activityIndicator)
    }
    
    private func setNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -10)
        ])
    }
    
    private func setTempLabelConstraints() {
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
    
    private func setActivityIndicatorConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}
