//
//  Int+Extension.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/12/24.
//

import Foundation

extension Int {
    func convertToDecimalType() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: self as NSNumber) ?? "0"
    }
}
