//
//  NetworkService.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import Foundation
import CoreLocation

protocol NetworkService {
    func getWeather(for city: String, completion: @escaping (Weather?) -> Void)
}

struct NetworkServiceImpl: NetworkService {
    
    // Константы
    private let scheme = "https"
    private let host = "api.weather.yandex.ru"
    private let path = "/v2/forecast"
    private let headerForKey = "X-Yandex-API-Key"
    private let apiKey = "342d1541-a1f3-4f08-8938-f145f78d5c3b"
    
    private let sharedSession = URLSession.shared
    
    // Обработка запроса
    func getWeather(for city: String, completion: @escaping (Weather?) -> Void) {
        guard let request = getWeatherRequest(for: city) else {
            // Если город не найден, выходим из метода
            return
        }
        switch request {
        case .failure(let error):
            completion(nil)
            print(error.localizedDescription)
        case .success(let request):
            let dataTask = sharedSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(nil)
                    print(error.localizedDescription)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("http status code: \(httpResponse.statusCode)")
                }
                guard let data = data else {
                    completion(nil)
                    print("no data received")
                    return
                }
                let decoder = JSONDecoder()
                if let weather = try? decoder.decode(Weather.self, from: data) {
                    completion(weather)
                }
            }
            dataTask.resume()
        }
    }
    
    // Создаем тело запроса
    private func getWeatherRequest(for city: String) -> Result<URLRequest, CLError>? {
        var locationCoordinate: Result<CLLocationCoordinate2D, CLError>?
        let group = DispatchGroup()
        group.enter()
        getCoordinatesOfCity(city) { result in
            switch result {
            case .success(let coordinate):
                locationCoordinate = .success(coordinate)
            case .failure(let error):
                print(type(of: self), #function, "\(error.localizedDescription)")
                locationCoordinate = .failure(error)
            }
            group.leave()
        }
        
        group.wait()
        guard let coordinate = locationCoordinate else { return nil }
        switch coordinate {
        case .failure(let error):
            return Result.failure(error)
        case .success(let coordinate):
            let urlComponents: URLComponents = {
                var urlComponents = URLComponents()
                urlComponents.scheme = scheme
                urlComponents.host = host
                urlComponents.path = path
                urlComponents.queryItems = [
                    URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
                    URLQueryItem(name: "lon", value: "\(coordinate.longitude)")]
                return urlComponents
            }()
            
            guard let url = urlComponents.url else { return nil }
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = [headerForKey: apiKey]
            return Result.success(urlRequest)
        }
    }
    
    // Получаем коордианты города
    private func getCoordinatesOfCity(_ city: String, completion: @escaping (Result<CLLocationCoordinate2D, CLError>) -> Void) {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let coordinates = placemarks?.first?.location?.coordinate {
                completion(.success(coordinates))
            } else if let error = error as? CLError {
                completion(.failure(error))
            }
        }
    }
    
}
