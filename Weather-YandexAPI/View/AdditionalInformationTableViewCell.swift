//
//  AdditionalInformationTableViewCell.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import UIKit

class AdditionalInformationTableViewCell: UITableViewCell {

    public class var identifier: String {
        return String(describing: self)
    }
    
    private var descriptionLabel = UILabel()
    private var valueLabel = UILabel()
    private var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        
        configuringDescriptionLabel()
        configuringValueLabel()
        configuringStackView()
        
        setStackViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuringDescriptionLabel() {
        descriptionLabel.font = UIFont.roundedFont(ofSize: 12, weight: .regular)
        descriptionLabel.textColor = .lightGray
    }
    
    private func configuringValueLabel() {
        valueLabel.font = UIFont.roundedFont(ofSize: 20, weight: .medium)
        valueLabel.textColor = .label
    }
    
    private func configuringStackView() {
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(valueLabel)
        
    }
    
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    public func set(description: String, value: String) {
        descriptionLabel.text = description
        valueLabel.text = value
    }
    
}
