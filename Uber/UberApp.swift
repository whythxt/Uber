//
//  UberApp.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

@main
struct UberApp: App {
    @StateObject var vm = SearchViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
