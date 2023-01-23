//
//  Double-Currency.swift
//  Uber
//
//  Created by Yurii on 23.01.2023.
//

import Foundation

extension Double {
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter
    }

    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}
