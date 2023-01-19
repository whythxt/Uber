//
//  SearchViewModel.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import MapKit
import Foundation

class SearchViewModel: NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()

    private let completer = MKLocalSearchCompleter()

    var query = "" {
        didSet {
            completer.queryFragment = query
        }
    }

    override init() {
        super.init()
        completer.delegate = self
        completer.queryFragment = query
    }
}
