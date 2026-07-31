import Foundation
import CoreLocation

struct ReverseGeocodeResult {
    let address: String
    let city: String
    let country: String
    let postalCode: String
    let coordinate: CLLocationCoordinate2D
}

final class ReverseGeocodeAPIService {
    static let shared = ReverseGeocodeAPIService()

    private init() {}

    func reverseGeocode(latitude: Double, longitude: Double, completion: @escaping (String, String, CLLocationCoordinate2D) -> Void) {
        reverseGeocodeDetails(latitude: latitude, longitude: longitude) { result in
            completion(result.address, result.country, result.coordinate)
        }
    }

    func reverseGeocodeDetails(latitude: Double, longitude: Double, completion: @escaping (ReverseGeocodeResult) -> Void) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let apiKey = AppManager.googleMapApiKey
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(apiKey)&language=en"

        guard let url = URL(string: urlString) else {
            completion(ReverseGeocodeResult(address: "", city: "", country: "", postalCode: "", coordinate: location))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else {
                DispatchQueue.main.async {
                    completion(ReverseGeocodeResult(address: "", city: "", country: "", postalCode: "", coordinate: location))
                }
                return
            }

            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let results = json["results"] as? [[String: Any]],
                      let first = results.first,
                      let addressComponents = first["address_components"] as? [[String: Any]] else {
                    DispatchQueue.main.async {
                        completion(ReverseGeocodeResult(address: "", city: "", country: "", postalCode: "", coordinate: location))
                    }
                    return
                }

                var address = (first["formatted_address"] as? String) ?? ""
                var city = ""
                var country = ""
                var postalCode = ""

                for component in addressComponents {
                    guard let types = component["types"] as? [String],
                          let longName = component["long_name"] as? String else { continue }

                    if types.contains("locality") {
                        city = longName
                    } else if types.contains("country") {
                        country = longName
                    } else if types.contains("postal_code") {
                        postalCode = longName
                    }
                }

                DispatchQueue.main.async {
                    completion(ReverseGeocodeResult(address: address, city: city, country: country, postalCode: postalCode, coordinate: location))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(ReverseGeocodeResult(address: "", city: "", country: "", postalCode: "", coordinate: location))
                }
            }
        }

        task.resume()
    }
}
