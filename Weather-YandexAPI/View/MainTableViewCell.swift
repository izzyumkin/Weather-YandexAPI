//
//  MainTableViewCell.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var nameLabel = UILabel()
    var tempLabel = UILabel()
    var conditionImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(tempLabel)
        addSubview(conditionImageView)
        
        configureNameLabel()
        configureTempLabel()
        configureConditionImageView()
        
        setNameLabelConstraints()
        setTempLabelConstraints()
        setConditionImageViewConstraints()
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
    }
    
    func configureConditionImageView() {
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.contentMode = .scaleAspectFit
    }
    
    func setNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    func setTempLabelConstraints() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16)
        ])
    }
    
    func setConditionImageViewConstraints() {
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conditionImageView.heightAnchor.constraint(equalToConstant: 40),
            conditionImageView.widthAnchor.constraint(equalToConstant: 40),
            conditionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            conditionImageView.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10)
        ])
    }
    
}
