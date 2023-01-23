//
//  RideType.swift
//  Uber
//
//  Created by Yurii on 22.01.2023.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case comfort
    case black

    var id: Int { rawValue }

    var name: String {
        switch self {
            case .uberX:
                return "UberX"
            case .comfort:
                return "Comfort"
            case .black:
                return "Black"
        }
    }

    var img: String {
        switch self {
            case .black:
                return "uberBlack"
            default:
                return "uberX"
        }
    }

    var base: Double {
        switch self {
            case .uberX:
                return 3
            case .comfort:
                return 5
            case .black:
                return 15
        }
    }

    func price(for distance: Double) -> Double {
        let miles = distance / 1600

        switch self {
            case .uberX:
                return miles * 1.5 + base
            case .comfort:
                return miles * 1.7 + base
            case .black:
                return miles * 2 + base
        }
    }
}
