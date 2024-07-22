//
//  ViewController.swift
//  Lab8_WeatherApp
//
//  Created by user228293 on 7/21/24.
//
import CoreLocation
import UIKit
import Foundation

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


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var humidityLabel: UILabel!
   
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherdescription: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!

    @IBOutlet weak var locationLabel: UILabel!
    let locationManager = CLLocationManager()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           let gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [UIColor.systemYellow.cgColor, UIColor.systemMint.cgColor]
           gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            view.layer.insertSublayer(gradientLayer, at: 0)
           
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location = locations.last {
               let lat = location.coordinate.latitude
               let lon = location.coordinate.longitude
               fetchWeatherData(latitude: lat, longitude: lon)
           }
       }
       
       func fetchWeatherData(latitude: Double, longitude: Double) {
           let apiKey = "ef3d604aa3e4a2b0256c098bb7253b58"
           let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
           
           if let url = URL(string: urlString) {
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with: url) { (data, response, error) in
                   if error != nil {
                       print(error!)
                       return
                   }
                   if let safeData = data {
                       self.parseJSON(weatherData: safeData)
                   }
               }
               task.resume()
           }
       }
       
       func parseJSON(weatherData: Data) {
           let decoder = JSONDecoder()
           do {
               let decodedData = try decoder.decode(TrackWeather.self, from: weatherData)
               let cityName = decodedData.name
               let description = decodedData.weather[0].description
               let icon = decodedData.weather[0].icon
               let temp = decodedData.main.temp
               let humidity = decodedData.main.humidity
               let windSpeed = decodedData.wind.speed
               
               DispatchQueue.main.async {
                            self.updateUI(cityName: cityName, description: description, icon: icon, temp: temp, humidity: humidity, windSpeed: windSpeed)
                          }
           }
    catch {
               print(error)
           }
       }
       
    func updateUI(cityName: String, description: String, icon: String, temp: Double, humidity: Int, windSpeed: Double) {
        locationLabel.text = cityName
        weatherdescription.text = description
        tempLabel.text = String(format: "%.0f°C", temp)
        humidityLabel.text = "Humidity: \(humidity)%"
        let windSpeedKmH = windSpeed * 3.6
         windLabel.text = String(format: "Wind Speed: %.2f km/h", windSpeedKmH)
        
        let iconUrlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        if let iconUrl = URL(string: iconUrlString) {
            let task = URLSession.shared.dataTask(with: iconUrl) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self.weatherImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }

   }
