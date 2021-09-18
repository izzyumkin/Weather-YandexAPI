//
//  DayOfTheWeekTableViewCell.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import UIKit

class DayOfTheWeekTableViewCell: UITableViewCell {

    public class var identifier: String {
        return String(describing: self)
    }
    
    private var nameLabel = UILabel()
    private var weatherConditionImageView = UIImageView()
    private var minTempLabel = UILabel()
    private var maxTempLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(weatherConditionImageView)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(maxTempLabel)
        
        configureNameLabel()
        configureMinTempLabel()
        configureMaxTempLabel()
        
        setNameLabelConstraints()
        setWeatherConditionImageView()
        setMinTempLabelConstraints()
        setMaxTempLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNameLabel() {
        nameLabel.font = UIFont.roundedFont(ofSize: 16, weight: .regular)
        nameLabel.textColor = .label
    }
    
    private func configureMinTempLabel() {
        minTempLabel.font = UIFont.roundedFont(ofSize: 16, weight: .regular)
        minTempLabel.textColor = .lightGray
        minTempLabel.textAlignment = .right
    }
    
    private func configureMaxTempLabel() {
        maxTempLabel.font = UIFont.roundedFont(ofSize: 16, weight: .regular)
        maxTempLabel.textColor = .label
        maxTempLabel.textAlignment = .right
    }
    
    private func setNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setWeatherConditionImageView() {
        weatherConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherConditionImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherConditionImageView.heightAnchor.constraint(equalToConstant: 40),
            weatherConditionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherConditionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setMaxTempLabelConstraints() {
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxTempLabel.widthAnchor.constraint(equalToConstant: 30),
            maxTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: minTempLabel.leadingAnchor, constant: -10)
        ])
    }
    
    private func setMinTempLabelConstraints() {
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minTempLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            minTempLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    public func set(dayName: String, icon: String, minTemp: Int, maxTemp: Int) {
        nameLabel.text = dayName
        minTempLabel.text = "\(minTemp)"
        maxTempLabel.text = "\(maxTemp)"
        if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(icon).svg") {
            weatherConditionImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
}
