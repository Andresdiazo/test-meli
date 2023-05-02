//
//  GeneralHelper.swift
//  TechnicalMeli
//
//  Created by Andres Diaz  on 21/04/23.
//

import Foundation

class GeneralHelper {
    static func formatPrice(_ price: Double) -> String {
        let priceNumber = NSNumber(value: price)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        let formattedPrice = formatter.string(from: priceNumber)
        return formattedPrice ?? ""
    }
}
