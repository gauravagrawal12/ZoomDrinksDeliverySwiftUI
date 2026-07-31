//
//  GooflemapView.swift
//  ZoomDeliverySwiftUI
//
//  Created by Gaurav Agrawal on 16/07/26.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct GoogleMapView: UIViewRepresentable {
    var viewModel: MapSearchViewModel
 
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
 
    func makeUIView(context: Context) -> GMSMapView {
        var initialLat = 26.4499
        var initialLng = 74.6399
        
        let locManager = LocationManager.sharedInstance
        if locManager.latitude != 0.0 && locManager.longitude != 0.0 {
            initialLat = locManager.latitude
            initialLng = locManager.longitude
            context.coordinator.didCenterOnUserLocation = true
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: initialLat, longitude: initialLng, zoom: 15)
        let options = GMSMapViewOptions()
        options.camera = camera
        let mapView = GMSMapView(options: options)
        mapView.delegate = context.coordinator
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
 
        mapView.addObserver(context.coordinator, forKeyPath: "myLocation", options: .new, context: nil)
        context.coordinator.mapView = mapView
 
        // Initial reverse geocode for the default center
        viewModel.reverseGeocode(coordinate: camera.target)
 
        return mapView
    }
 
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        // If the ViewModel has a pending camera target (from search selection), animate to it.
        if let target = viewModel.pendingCameraTarget {
            let update = GMSCameraUpdate.setTarget(target, zoom: 16)
            mapView.animate(with: update)
            DispatchQueue.main.async {
                viewModel.pendingCameraTarget = nil
            }
        }
        
        if viewModel.shouldZoomIn {
            mapView.animate(with: GMSCameraUpdate.zoomIn())
            DispatchQueue.main.async {
                viewModel.shouldZoomIn = false
            }
        }
        
        if viewModel.shouldZoomOut {
            mapView.animate(with: GMSCameraUpdate.zoomOut())
            DispatchQueue.main.async {
                viewModel.shouldZoomOut = false
            }
        }
    }
 
    final class Coordinator: NSObject, GMSMapViewDelegate {
        let viewModel: MapSearchViewModel
        weak var mapView: GMSMapView?
        var didCenterOnUserLocation = false
 
        init(viewModel: MapSearchViewModel) {
            self.viewModel = viewModel
        }
        
        deinit {
            mapView?.removeObserver(self, forKeyPath: "myLocation")
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "myLocation", let mapView = object as? GMSMapView, let location = mapView.myLocation {
                if !didCenterOnUserLocation {
                    didCenterOnUserLocation = true
                    let cameraUpdate = GMSCameraUpdate.setTarget(location.coordinate, zoom: 15)
                    mapView.animate(with: cameraUpdate)
                    
                    // Trigger reverse geocoding for the new center
                    viewModel.reverseGeocode(coordinate: location.coordinate)
                }
            }
        }
 
        // Called continuously while dragging — cheap, so just track position if you need live updates.
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            // Intentionally left lightweight; real geocoding happens on idle (below)
            // to avoid firing a network request on every frame of the drag gesture.
        }
 
        // Called once the camera has stopped moving — this is where we reverse geocode.
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            viewModel.reverseGeocode(coordinate: position.target)
        }
    }
}
