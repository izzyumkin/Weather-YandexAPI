//
//  DayOfTheWeekTableViewCell.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import UIKit

final class DayOfTheWeekTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        return label
    }()
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.roundedFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()
    private let weatherConditionImageView = UIImageView()
    
    // MARK: - Inittializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setNameLabelConstraints()
        setWeatherConditionImageView()
        setMinTempLabelConstraints()
        setMaxTempLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func setupData(dayName: String, icon: String, minTemp: Int, maxTemp: Int) {
        nameLabel.text = dayName
        minTempLabel.text = "\(minTemp)"
        maxTempLabel.text = "\(maxTemp)"
        if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(icon).svg") {
            weatherConditionImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(weatherConditionImageView)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(maxTempLabel)
    }
    
    private func setNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setWeatherConditionImageView() {
        NSLayoutConstraint.activate([
            weatherConditionImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherConditionImageView.heightAnchor.constraint(equalToConstant: 40),
            weatherConditionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherConditionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setMaxTempLabelConstraints() {
        NSLayoutConstraint.activate([
            maxTempLabel.widthAnchor.constraint(equalToConstant: 30),
            maxTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: minTempLabel.leadingAnchor, constant: -10)
        ])
    }
    
    private func setMinTempLabelConstraints() {
        NSLayoutConstraint.activate([
            minTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minTempLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            minTempLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
