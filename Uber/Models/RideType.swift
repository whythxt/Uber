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
}
