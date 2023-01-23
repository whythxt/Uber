//
//  RideView.swift
//  Uber
//
//  Created by Yurii on 22.01.2023.
//

import SwiftUI

struct RideView: View {
    @EnvironmentObject var vm: SearchViewModel

    @State private var ride = RideType.uberX

    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(.secondary)
                .frame(width: 50, height: 3)
                .padding(5)

            header

            Divider()
                .padding(.horizontal)

            rides
            confirmation
        }
        .padding(.bottom, 20)
        .background(.white)
        .cornerRadius(15)
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

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Current location")
                        .font(.callout)

                    Spacer()

                    Text(vm.pickup ?? "Now")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.secondary)
                .padding(.bottom)

                HStack {
                    if let loc = vm.selected {
                        Text(loc.title)
                            .font(.callout)
                    }

                    Spacer()

                    Text(vm.dropoff ?? "Soon")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(.horizontal, 5)
    }

    var rides: some View {
        VStack {
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading) {
                            Image(type.img)
                                .resizable()
                                .scaledToFit()

                            VStack(alignment: .leading, spacing: 3) {
                                Text(type.name)
                                Text(vm.getPrice(for: type).toCurrency())
                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(5)
                            .padding(.leading, 5)

                        }
                        .frame(width: 110, height: 140)
                        .background(Color(type == ride ? .black : .systemGroupedBackground))
                        .foregroundColor(type == ride ? .white : .black)
                        .scaleEffect(type == ride ? 1.1 : 1)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                ride = type
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }

    var confirmation: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: "banknote.fill")
                    .foregroundColor(.green)
                    .imageScale(.large)

                Text("Cash")
                    .bold()

                Spacer()

                Image(systemName: "chevron.right")
                    .imageScale(.large)
            }
            .padding()
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)

            Button {

            } label: {
                Text("Choose \(ride.name)")
                    .font(.title3)
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 5)
            }
        }
    }
}

struct RideView_Previews: PreviewProvider {
    static var previews: some View {
        RideView()
            .environmentObject(SearchViewModel())
    }
}
