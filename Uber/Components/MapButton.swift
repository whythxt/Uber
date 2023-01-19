//
//  MapButton.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct MapButton: View {
    @Binding var showingSearch: Bool

    var body: some View {
        Button {
            withAnimation(.spring()) {
                showingSearch.toggle()
            }
        } label: {
            Image(systemName: showingSearch ? "arrow.left" : "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton(showingSearch: .constant(false))
    }
}
