//
//  ContentView.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var state = MapState.idle

    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresantable(state: $state)

            if state == .search {
                SearchView(state: $state)
            } else if state == .idle {
                SearchBar()
                    .padding(.top, 100)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            state = .search
                        }
                    }
            }

            MapButton(state: $state)
                .padding(.leading, 10)
                .padding(.top, 50)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SearchViewModel())
    }
}
