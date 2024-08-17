//
//  TripDetailViewController.swift
//  TravelBuddy_Final_8996799
//
//  Created by user228293 on 8/17/24.
//

import UIKit
import CoreData
import MapKit
import CoreLocation


// MARK: - TrackWeather
struct TrackWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed : Double
      let  deg: Int
}

class TripDetailViewController: UIViewController {

    var trip: Trip?
    @IBOutlet weak var tripExpenseButton: UIBarButtonItem!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherForcastLabel: UILabel!
    @IBOutlet weak var destinationMapView: MKMapView!
    @IBOutlet weak var totalExpense: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var tripNameLabel: UILabel!
    let geocoder = CLGeocoder()

    @IBAction func tripExpenseButton(_ sender: Any) {
        performSegue(withIdentifier: "showExpense", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showExpense", let destinationVC = segue.destination as? TripExpenseViewController {
               destinationVC.trip = trip // Pass the current trip object to the TripExpenseViewController
           }
       }
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // Display the trip details
            if let trip = trip {
                tripNameLabel.text = trip.tripName
                destinationLabel.text = trip.destination
                startLocationLabel.text = trip.startLocation
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                
                if let startDate = trip.startDate {
                    startDateLabel.text = dateFormatter.string(from: startDate)
                }
                
                if let endDate = trip.endDate {
                    endDateLabel.text = dateFormatter.string(from: endDate)
                }

                // Display the destination on the map
                if let destination = trip.destination {
                    geocodeAddress(address: destination)
                }
            }
        }

        func geocodeAddress(address: String) {
            geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
                if let error = error {
                    print("Geocode error: \(error)")
                    return
                }

                guard let placemark = placemarks?.first,
                      let location = placemark.location else {
                    print("No location found")
                    return
                }

                let coordinate = location.coordinate
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = self?.trip?.destination
                
                self?.destinationMapView.addAnnotation(annotation)
                self?.destinationMapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
            }
        }
    
    func fetchWeather(for address: String) {
        let apiKey = "ef3d604aa3e4a2b0256c098bb7253b58" // API Key should be a constant
        guard let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Failed to encode address")
            return
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedAddress)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Weather fetch error: \(error)")
                return
            }
            
            guard let data = data,
                  let weatherData = try? JSONDecoder().decode(TrackWeather.self, from: data) else {
                print("Invalid data or decoding error")
                return
            }
            
            DispatchQueue.main.async {
                self?.windSpeedLabel.text = "Wind Speed: \(weatherData.wind.speed) m/s"
                self?.humidityLabel.text = "Humidity: \(weatherData.main.humidity)%"
                self?.temperatureLabel.text = "Temperature: \(weatherData.main.temp)°C"
                self?.weatherForcastLabel.text = weatherData.weather.first?.description.capitalized
                
                if let iconCode = weatherData.weather.first?.icon {
                    let iconURLString = "https://openweathermap.org/img/wn/\(iconCode).png"
                    if let iconURL = URL(string: iconURLString) {
                        self?.weatherImage.load(url: iconURL)
                    }
                }
            }
        }
        
        task.resume()
    }
}