
import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    static let sharedInstance = LocationManager()
    
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var isFromSetLocation = false
    
    let locationManager = CLLocationManager()
    
    var isLocationPermissionOn:Bool {
        return ((CLLocationManager.authorizationStatus() == .authorizedAlways) || (CLLocationManager.authorizationStatus() == .authorizedWhenInUse))
    }
    
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.allowsBackgroundLocationUpdates = false
        if let location = locations.last {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            //debugPrint("latitude:\(latitude),longitude:\(longitude)")
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Fail to update location error:\(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //debugPrint("didChangeAuthorizationStatus")
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            //debugPrint(".Authorized")
            break
        case .notDetermined, .restricted, .denied:
            //debugPrint(".Denied")
            break
        default:
            //debugPrint("Unhandled authorization status")
            break
        }
    }
    
    // MARK: - Get Address From Lat Long
    public class func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double, completion completionBlock: @escaping (_ userAddress: userCurrentAddress?) -> Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let local = Locale(identifier: AppManager.shared.GlobalPlaceLanguage)
        let lat: Double = pdblLatitude
        //21.228124
        let lon: Double = pdblLongitude
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)

        //let addressString : String = ""
        ceo.reverseGeocodeLocation(loc, preferredLocale: local, completionHandler:
            {(placemarks, error) in
                if let error {
                    debugPrint("reverse geodcode fail: \(error.localizedDescription)")
                }

                guard let placemarks, let pm = placemarks.first else {
                    completionBlock(nil)
                    return
                }

                let address = userCurrentAddress()
                        var addressString : String = ""
                        if let subLocality = pm.subLocality, !subLocality.isEmpty {
                            addressString = addressString + subLocality + ", "
                        }
                        if let thoroughfare = pm.thoroughfare, !thoroughfare.isEmpty {
                            addressString = addressString + thoroughfare + ", "
                        }
                        if let locality = pm.locality, !locality.isEmpty {
                            addressString = addressString + locality + ", "
                        }
                        if let country = pm.country, !country.isEmpty {
                            addressString = addressString + country + ", "
                            address.country = country
                        }
                        if let postalCode = pm.postalCode, !postalCode.isEmpty {
                            addressString = addressString + postalCode + " "
                        }
                        address.userAddress = addressString
                        address.userLocality = pm.locality ?? ""
                        address.latitude = lat
                        address.longitude = lon
                        completionBlock(address)
        })
    }
}

// MARK: - Current Address
class userCurrentAddress {
    var userAddress: String?
    var userLocality: String?
    var latitude: Double?
    var longitude: Double?
    var country: String?
}
