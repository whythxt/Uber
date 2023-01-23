//
//  Color-ColorTheme.swift
//  Uber
//
//  Created by Yurii on 23.01.2023.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let primary = Color("primary")
    let secondary = Color("secondary")
    let background = Color("background")
}
