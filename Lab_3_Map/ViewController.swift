//
//  ViewController.swift
//  Lab_3_Map
//
//  Created by Andrii Damm on 2018-04-20.
//  Copyright © 2018 Andrii Damm. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var setBtn: UIButton!
    @IBOutlet weak var addButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var latTextfield: UITextField!
    
    @IBOutlet weak var longTextfield: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet var setView: UIView!
    
    var latitude = Double()
    var longitude = Double()
    
    var blurEffect: UIVisualEffect!
    var manager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func standard(_ sender: Any) {
        
        mapView.mapType = MKMapType.standard
        
        
    }
    
    @IBAction func satellite(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
    }
    
    @IBAction func hybrid(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
    }
    
    @IBAction func myLocation(_ sender: Any) {
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation : CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        let span = MKCoordinateSpanMake(0.01, 0.01)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func set(_ sender: Any) {
        
        guard let lat = latTextfield.text else {return}
        guard let long = longTextfield.text else {return}
        
        
        if latTextfield.text != "" && longTextfield.text != "" {
            
            getLocatin(forLatitude: Double(lat)!, forLongitude: Double(long)!)
            
        }
        dismiss(animated: true, completion: nil)
    }
    func getLocatin(forLatitude: Double, forLongitude: Double) {
        let span = MKCoordinateSpanMake(0.1, 0.01)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: forLatitude, longitude: forLongitude), span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(forLatitude, forLongitude)
        let pinObject = MKPointAnnotation()
        
        pinObject.coordinate = pinLocation
        pinObject.title = "Custom coorditates"
        pinObject.subtitle = "This Location"
        
        self.mapView.addAnnotation(pinObject)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func enterLocation(_ sender: Any) {
        
    }
    
}



