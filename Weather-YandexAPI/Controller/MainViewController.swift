//
//  MainViewController.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var cities = CitiesImpl.shared
    var tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
    
    private lazy var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Погода"
        view.backgroundColor = .secondarySystemGroupedBackground
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.updateUI()
        }
        
        view.addSubview(tableView)
        
        configureTableView()
        configureSearchBar()
        setTableViewConstraints()
    }

    func configureTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Найти"
    }
    
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateUI() {
        let networkService: NetworkService = NetworkServiceImpl()
        cities.list.forEach { [weak self] city in
            guard let self = self else { return }
            networkService.getWeather(for: city) { result in
                switch result {
                case .success(let weather):
                    self.cities.addWeatherFor(city: city, weather: weather)
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(type(of: self), #function, error.localizedDescription)
                }
            }
        }
    }

}

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
    }
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Tap for search")
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
}
