//
//  LocationRow.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import SwiftUI

struct LocationRow: View {
    var title: String
    var subtitle: String

    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()
                    .padding(.top, 5)
            }
        }
        .padding()
    }
}

struct LocationRow_Previews: PreviewProvider {
    static var previews: some View {
        LocationRow(title: "Ocean Plaza", subtitle: "Main St, Kyiv UA")
    }
}
