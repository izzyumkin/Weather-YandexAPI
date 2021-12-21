//
//  Extension + UIAlertController.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import UIKit

extension UIAlertController {
    static func showUnknownLocation() {
        DispatchQueue.main.async {
            guard let navigationController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController as? UINavigationController else { return }

                let alert = UIAlertController(title: "Населенный пункт не найден!", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                navigationController.present(alert, animated: true)
        }
    }
}
