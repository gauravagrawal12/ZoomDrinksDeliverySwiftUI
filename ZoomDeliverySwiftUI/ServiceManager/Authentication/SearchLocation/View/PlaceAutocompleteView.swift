//
//  PlaceAutocompleteView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 16/07/26.
//

import SwiftUI
import GooglePlaces
import CoreLocation

struct PlaceAutocompleteView: View {
    var onPlaceSelected: (CLLocationCoordinate2D, String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var predictions: [GMSAutocompletePrediction] = []
    @State private var isLoading = false
    
    private let placesClient = GMSPlacesClient.shared()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search for a location...", text: $searchText)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled(true)
                        .submitLabel(.search)
                        .onChange(of: searchText) { oldValue, newValue in
                            fetchPredictions(query: newValue)
                        }
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                            predictions = []
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(10)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                if isLoading && predictions.isEmpty {
                    Spacer()
                    ProgressView("Searching...")
                    Spacer()
                } else if predictions.isEmpty {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "map")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text(searchText.isEmpty ? "Start typing to search" : "No locations found")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    Spacer()
                } else {
                    List(predictions, id: \.placeID) { prediction in
                        Button {
                            selectPrediction(prediction)
                        } label: {
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.appColor)
                                    .padding(.top, 2)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(prediction.attributedPrimaryText.string)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                        .lineLimit(1)
                                    
                                    if let secondaryText = prediction.attributedSecondaryText?.string {
                                        Text(secondaryText)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .lineLimit(2)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Search Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func fetchPredictions(query: String) {
        guard !query.isEmpty else {
            predictions = []
            return
        }
        
        isLoading = true
        placesClient.findAutocompletePredictions(fromQuery: query, filter: nil, sessionToken: nil) { results, error in
            isLoading = false
            if let error = error {
                print("Prediction error: \(error.localizedDescription)")
                return
            }
            if let results = results {
                self.predictions = results
            }
        }
    }
    
    private func selectPrediction(_ prediction: GMSAutocompletePrediction) {
        isLoading = true
        
        let fields: GMSPlaceField = [.coordinate, .formattedAddress, .name]
        
        placesClient.fetchPlace(fromPlaceID: prediction.placeID, placeFields: fields, sessionToken: nil) { place, error in
            isLoading = false
            if let error = error {
                print("Fetch place error: \(error.localizedDescription)")
                return
            }
            if let place = place {
                let address = place.formattedAddress ?? place.name ?? prediction.attributedFullText.string
                onPlaceSelected(place.coordinate, address)
                dismiss()
            }
        }
    }
}
