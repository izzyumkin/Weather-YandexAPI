//
//  MainViewController.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // UI
    private var tableView = UITableView(frame: CGRect.zero, style: .plain)
    private lazy var searchController = UISearchController(searchResultsController: nil)
    private let detailVC = DetailViewController()
    
    // Data
    private var cities = CitiesImpl.shared
    private let networkService: NetworkService = NetworkServiceImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Погода"
        view.backgroundColor = .systemGroupedBackground
        reloadCities(qos: .userInteractive)
        view.addSubview(tableView)
        configuringTableView()
        configuringSearchBar()
        setTableViewConstraints()
    }
    
    // MARK: UI

    private func configuringTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configuringSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Найти"
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

    // Обновляет все города с настраиваемым приоритетом для очереди
    private func reloadCities(qos: DispatchQoS.QoSClass) {
        DispatchQueue.global(qos: qos).async { [weak self] in
            guard let self = self else { return }
            self.updateAllCities()
        }
    }
    
    // Обновляет все города
    private func updateAllCities() {
        cities.list.forEach { [weak self] city in
            guard let self = self else { return }
            networkService.getWeather(for: city) { weather in
                if let weather = weather {
                    self.cities.addWeatherFor(city: city, weather: weather)
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // Обновляет добавленный город
    private func updateNewCity() {
        if let city = cities.list.last {
            networkService.getWeather(for: city) { weather in
                if let weather = weather {
                    self.cities.addWeatherFor(city: city, weather: weather)
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: Actions
    
    // Показывает погоду для поискового запроса
    private func showDetailWeatherFor(city: String) {
        networkService.getWeather(for: city) { [detailVC, searchController] weather in
            if let weather = weather {
                // Город найден, показываем DetailVC
                detailVC.city = city
                detailVC.weather = weather
                DispatchQueue.main.async {
                    let navigationVC = UINavigationController(rootViewController: detailVC)
                    let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(self.hideDetailVC))
                    let addButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(self.addSearchedCity))
                    detailVC.navigationItem.leftBarButtonItem = cancelButton
                    detailVC.navigationItem.rightBarButtonItem = addButton
                    
                    searchController.searchBar.isLoading = false
                    self.present(navigationVC, animated: true, completion: nil)
                }
            } else {
                // Город не найден
                DispatchQueue.main.async {
                    searchController.searchBar.isLoading = false
                    UIAlertController.showUknownLocation()
                }
            }
        }
        
    }
    
    // Закрыть DetailVC
    @objc private func hideDetailVC() {
        detailVC.dismiss(animated: true, completion: nil)
    }
    
    // Добавить новый город и обновить таблицу
    @objc private func addSearchedCity() {
        if let searchedCity = searchController.searchBar.text?.capitalized {
            searchController.isActive = false
            detailVC.dismiss(animated: true, completion: nil)
            cities.add(city: searchedCity)
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                self.updateNewCity()
            }
        }
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell {
            let city = cities.list[indexPath.row]
            cell.city = city
            if let weather = cities.listWithWeather[city] {
                cell.weather = weather
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        let city = cities.list[indexPath.row]
        vc.city = city
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, complete in
            self.cities.removeCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            complete(true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
}

// MARK: UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.isLoading {
            searchBar.isLoading = !searchBar.isLoading
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isLoading = true
        searchBar.resignFirstResponder()
        if let city = searchBar.text?.capitalized, !city.isEmpty {
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                self.showDetailWeatherFor(city: city)
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.isLoading = false
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            searchBar.isLoading = false
        }
    }
    
}
