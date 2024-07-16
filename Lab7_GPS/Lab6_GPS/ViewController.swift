//
//  ViewController.swift
//  Lab6_GPS
//
//  Created by user228293 on 7/11/24.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var TripStatus: UIView!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var SpeedExceedIndicator: UIView!
  
    @IBOutlet weak var MaxAccelerateDisplay: UILabel!
    @IBOutlet weak var DistCoveredDisplay: UILabel!
    @IBOutlet weak var AvgSpeedDisplay: UILabel!
    @IBOutlet weak var MaxSpeedDisplay: UILabel!
    @IBOutlet weak var CurrentSpeedDisplay: UILabel!
    
    @IBOutlet weak var distanceBeforeExceedingDisplay: UILabel!
    
    let locationDetector = CLLocationManager()
    var maxSpd: CLLocationSpeed = 0
    var totalSpd: CLLocationSpeed = 0
    var spdCount: Int = 0
    var totalDist: CLLocationDistance = 0
    var lastLoc: CLLocation?
    var maxAcceleration: Double = 0
    var distanceBeforeExceeding: CLLocationDistance = 0
    var hasExceededSpeedLimit = false
    
    @IBAction func StartTripButton(_ sender: Any) {
        locationDetector.startUpdatingLocation()
        TripStatus.backgroundColor = .green
        resetTripData()
    }
    
    @IBAction func StopTripButton(_ sender: Any) {
        locationDetector.stopUpdatingLocation()
        TripStatus.backgroundColor = .gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationDetector.delegate = self
        locationDetector.requestWhenInUseAuthorization()
        MapView.showsUserLocation = true
    }
    
    func resetTripData() {
        maxSpd = 0
           totalSpd = 0
           spdCount = 0
           totalDist = 0
           lastLoc = nil
           maxAcceleration = 0
        distanceBeforeExceeding = 0
           
        CurrentSpeedDisplay.text = "0 km/h"
        MaxSpeedDisplay.text = "0 km/h"
        AvgSpeedDisplay.text = "0 km/h"
        DistCoveredDisplay.text = "0 km"
        MaxAccelerateDisplay.text = "0 m/s^2"
        distanceBeforeExceedingDisplay.text = "0 km"
        SpeedExceedIndicator.backgroundColor = .clear
       }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
               
            let speed = max(location.speed, 0) // to check if speed is non-negative
            CurrentSpeedDisplay.text = String(format: "%.2f km/h", speed * 3.6) // Convert m/s to km/h
               
               if speed > maxSpd {
                   maxSpd = speed
                   MaxSpeedDisplay.text = String(format: "%.2f km/h", maxSpd * 3.6)
               }
               
               totalSpd += speed
               spdCount += 1
               let averageSpeed = totalSpd / Double(spdCount)
               AvgSpeedDisplay.text = String(format: "%.2f km/h", averageSpeed * 3.6)
               
               if let lastLocation = lastLoc {
                   let distance = location.distance(from: lastLocation)
                   totalDist += distance
                   DistCoveredDisplay.text = String(format: "%.2f km", totalDist / 1000) // Convert m into km
                   
                   if !hasExceededSpeedLimit {
                       distanceBeforeExceeding += distance
                       distanceBeforeExceedingDisplay.text = String(format: "%.2f km", distanceBeforeExceeding / 1000)
                       
                       if ((speed * 3.6) > 115) {
                           hasExceededSpeedLimit = true
                       }
                   }
                   let acceleration = abs(speed - lastLocation.speed) / location.timestamp.timeIntervalSince(lastLocation.timestamp)
                   if acceleration > maxAcceleration {
                       maxAcceleration = acceleration
                       MaxAccelerateDisplay.text = String(format: "%.2f m/s^2", maxAcceleration)
                   }
               }
      
                   
               
               lastLoc = location
               
               // Change the speed indicator color if speed exceeds 115 km/h
               if speed * 3.6 > 115 {
                   SpeedExceedIndicator.backgroundColor = .red
               } else {
                   SpeedExceedIndicator.backgroundColor = .clear
               }
               
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
               MapView.setRegion(region, animated: true)
           }
}

