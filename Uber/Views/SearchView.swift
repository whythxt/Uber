//
//  SearchView.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var vm: SearchViewModel

    @State private var location = ""
    @FocusState private var isFocused: Bool

    @Binding var state: MapState

    var body: some View {
        VStack {
            header
            suggestions
                .padding(.top)
        }
        .padding(.top, 75)
        .background(.white)
        .onAppear {
            isFocused.toggle()
        }
    }

    var header: some View {
        HStack {
            VStack {
                Circle()
                    .fill(.secondary)
                    .frame(width: 5, height: 5)

                Rectangle()
                    .fill(.secondary)
                    .frame(width: 1, height: 25)

                Rectangle()
                    .fill(.black)
                    .frame(width: 5, height: 5)
            }
            .padding(.horizontal, 10)

            VStack(spacing: 10) {
                TextField("Current location", text: $location)
                    .padding(5)
                    .frame(height: 35)
                    .background(Color(.secondarySystemGroupedBackground).shadow(radius: 1))
                    .padding(.trailing)
                    .autocorrectionDisabled()

                TextField("Where to?", text: $vm.query)
                    .padding(5)
                    .frame(height: 35)
                    .background(Color(.systemGroupedBackground).shadow(radius: 1))
                    .padding(.trailing)
                    .autocorrectionDisabled()
                    .focused($isFocused)
            }
        }
        .padding(.top, 60)
    }

    var suggestions: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(vm.results, id: \.self) { result in
                    LocationRow(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                vm.select(result)
                                vm.query = ""
                                state = .selected
                            }
                        }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(state: .constant(.search))
            .environmentObject(SearchViewModel())
    }
}
