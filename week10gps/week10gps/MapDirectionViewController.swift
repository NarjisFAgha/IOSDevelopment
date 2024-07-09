//
//  MapDirectionViewController.swift
//  week10gps
//
//  Created by user228293 on 7/8/24.
//
import UIKit
import MapKit
import CoreLocation

class MapDirectionViewController: UIViewController , CLLocationManagerDelegate,MKMapViewDelegate{
    
    
    @IBOutlet weak var DirectionText: UITextField!
    @IBOutlet weak var MapView: MKMapView!
 
    @IBAction func DeirectionButton(_ sender: Any) {
    }
    
    
}
