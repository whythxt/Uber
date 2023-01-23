//
//  ContentView.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = SearchViewModel()

    @State private var state = MapState.idle

    var body: some View {
        ZStack(alignment: .bottom) {
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

            if state == .selected || state == .generated {
                RideView()
                    .transition(.move(edge: .bottom ))
            }
        }
        .environmentObject(vm)
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationProvider.shared.$location) { location in
            if let location {
                vm.location = location
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SearchViewModel())
    }
}
