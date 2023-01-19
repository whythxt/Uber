//
//  SearchCompleter.swift
//  Uber
//
//  Created by Yurii on 19.01.2023.
//

import MapKit
import Foundation

extension SearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
