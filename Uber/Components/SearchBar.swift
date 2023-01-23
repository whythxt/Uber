//
//  SearchBar.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct SearchBar: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(.black)
                .frame(width: 10, height: 10)
                .padding(.horizontal)

            Text("Where to?")
                .foregroundColor(Color.theme.secondary)

            Spacer()
        }
        .frame(height: 55)
        .background {
            Rectangle()
                .fill(.white)
                .cornerRadius(5)
                .shadow(radius: 5)
        }
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
