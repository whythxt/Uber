//
//  ContentView.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MapViewRepresantable()
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
