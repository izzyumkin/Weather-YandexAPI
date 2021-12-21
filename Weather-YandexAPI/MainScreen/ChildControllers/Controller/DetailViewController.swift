//
//  DetailViewController.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var city: String? {
        didSet {
            guard let city = city else { return }
            setWeather(city: city)
        }
    }
    
    public var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            additionalInformationsValue = weatherModel.configuringAdditionalInformationValues(weather: weather)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    private let weatherModel: WeatherModel = WeatherModelImpl()
    private let networkService: NetworkService = NetworkServiceImpl()
    
    private var additionalInformationsValue: [String] = []
    private var cities = CitiesImpl.shared
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
        
        configuringTableView()
        setTableViewConstraints()
    }
    
    // MARK: - Private Methods
    
    private func configuringTableView() {
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tableView.register(DayOfTheWeekTableViewCell.self, forCellReuseIdentifier: DayOfTheWeekTableViewCell.identifier)
        tableView.register(AdditionalInformationTableViewCell.self, forCellReuseIdentifier: AdditionalInformationTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Если погода еще не была сохранена, делаем запрос и сохраняем, если была - указываем ее
    private func setWeather(city: String) {
        if let weather = cities.listWithWeather[city] {
            self.weather = weather
        } else {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                self.networkService.getWeather(for: city) { weather in
                    if let weather = weather {
                        DispatchQueue.main.async {
                            self.weather = weather
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Extension UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        case 2:
            return weatherModel.namesOfAdditionalInformation.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as? HeaderTableViewCell {
                cell.setupData(city: city, weather: weather)
                cell.weatherModel = weatherModel
                return cell
            } else {
                return UITableViewCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DayOfTheWeekTableViewCell.identifier, for: indexPath) as? DayOfTheWeekTableViewCell {
                let dayNames = Date.getTheNamesOfTheDaysOfTheWeek()
                let dayName = dayNames[indexPath.row]
                if let icon = weather?.forecasts[indexPath.row + 1].parts.day.icon,
                   let minTemp = weather?.forecasts[indexPath.row + 1].parts.evening.tempMin,
                   let maxTemp = weather?.forecasts[indexPath.row + 1].parts.day.tempMax {
                    cell.setupData(dayName: dayName, icon: icon, minTemp: minTemp, maxTemp: maxTemp)
                }
                return cell
            } else {
                return UITableViewCell()
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalInformationTableViewCell.identifier, for: indexPath) as? AdditionalInformationTableViewCell {
                let description = weatherModel.namesOfAdditionalInformation[indexPath.row]
                var value = ""
                if !additionalInformationsValue.isEmpty {
                    value = additionalInformationsValue[indexPath.row]
                }
                cell.setupData(description: description, value: value)
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Extension UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 293
        } else {
            return 52
        }
    }
}
