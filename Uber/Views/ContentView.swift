//
//  ContentView.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSearch = false

    var body: some View {
        ZStack(alignment: .top) {
            MapViewRepresantable()

            if showingSearch {
                SearchView(showingSearch: $showingSearch)
            } else {
                SearchBar()
                    .padding(.top, 100)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showingSearch.toggle()
                        }
                    }
            }

            MapButton(showingSearch: $showingSearch)
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
