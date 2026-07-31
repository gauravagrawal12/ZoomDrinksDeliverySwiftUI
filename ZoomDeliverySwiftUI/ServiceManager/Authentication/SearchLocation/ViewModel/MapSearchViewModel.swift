//
//  MapSearchViewModel.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 16/07/26.
//

import SwiftUI
import Observation
import GoogleMaps
import GooglePlaces

@Observable
final class MapSearchViewModel {
    static let shared = MapSearchViewModel()
    var currentAddress: String = ""     // address under center pin (updates on map move)
    var selectedAddress: String = ""    // address chosen via search
    var isGeocoding: Bool = false
    
    var currentCoordinate: CLLocationCoordinate2D?
    var currentCountry: String = ""
 
    // Bridge to tell the UIViewRepresentable to animate the camera
    var pendingCameraTarget: CLLocationCoordinate2D?
    var shouldZoomIn: Bool = false
    var shouldZoomOut: Bool = false
 
    private let geocoder = GMSGeocoder()
 
    func moveCamera(to coordinate: CLLocationCoordinate2D) {
        pendingCameraTarget = coordinate
    }
 
    /// Called by the map's delegate whenever the camera finishes moving (idle).
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        currentCoordinate = coordinate
        isGeocoding = true
        geocoder.reverseGeocodeCoordinate(coordinate) { [weak self] response, error in
            guard let self = self else { return }
            self.isGeocoding = false
            if let error = error {
                print("Reverse geocode error: \(error.localizedDescription)")
                return
            }
            if let result = response?.firstResult() {
                self.currentAddress = self.formattedAddress(from: result)
                self.selectedAddress = self.currentAddress
                self.currentCountry = result.country ?? ""
            }
        }
    }
 
    private func formattedAddress(from address: GMSAddress) -> String {
        if let lines = address.lines, !lines.isEmpty {
            return lines.joined(separator: ", ")
        }
        // Fallback: build manually from components
        let parts = [address.thoroughfare, address.locality, address.administrativeArea, address.postalCode, address.country]
            .compactMap { $0 }
        return parts.joined(separator: ", ")
    }
}
