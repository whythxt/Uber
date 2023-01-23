//
//  MapButton.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct MapButton: View {
    @EnvironmentObject var vm: SearchViewModel

    @Binding var state: MapState

    var body: some View {
        Button {
            withAnimation(.spring()) {
                getAction(state)
            }
        } label: {
            Image(systemName: getImage(state))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func getAction(_ st: MapState) {
        switch st {
            case .idle:
                break
            case .search:
                state = .idle
            default:
                state = .idle
                vm.selected = nil
        }
    }

    func getImage(_ st: MapState) -> String {
        switch st {
            case .idle:
                return "line.3.horizontal"
            default:
                return "arrow.left"
        }
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton(state: .constant(.idle))
            .environmentObject(SearchViewModel())
    }
}
