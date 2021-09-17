//
//  Extension + UIFont.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 17.09.2021.
//

import UIKit

extension UIFont {

 static func roundedFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
    let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
    let font: UIFont

    if #available(iOS 13.0, *) {
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: fontSize)
        } else {
            font = systemFont
        }
    } else {
        font = systemFont
    }

    return font
 }
}
