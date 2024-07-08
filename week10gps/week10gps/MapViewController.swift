//
//  MapViewController.swift
//  week10gps
//
//  Created by user228293 on 7/8/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController , CLLocationManagerDelegate,MKMapViewDelegate{

    let locationManger = CLLocationManager()
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
