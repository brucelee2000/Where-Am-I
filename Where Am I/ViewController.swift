//
//  ViewController.swift
//  Where Am I
//
//  Created by Yosemite on 1/15/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var myMap: MKMapView!    
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var manager = CLLocationManager()
    
    var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var usrLocation:CLLocation = locations[0] as CLLocation
        
        latitude.text = "\(usrLocation.coordinate.latitude)"
        longitude.text = "\(usrLocation.coordinate.longitude)"
        heading.text = "\(usrLocation.course)"
        speed.text = "\(usrLocation.speed)"
        altitude.text = "\(usrLocation.altitude)"
        
        // Convert to address
        CLGeocoder().reverseGeocodeLocation(usrLocation, completionHandler:{(placemarks, error) in
            if error != nil {
                println(error)
            } else {
                // Create a constant from variable
                let p = CLPlacemark(placemark: placemarks[0] as CLPlacemark)
                // Get the address
                var subThoroughfare = p.subThoroughfare ?? ""
                var thoroughfare = p.thoroughfare ?? ""
                var subLocality = p.subLocality ?? ""
                var locality = p.locality ?? ""
                var subAdministrativeArea = p.subAdministrativeArea ?? ""
                var administrativeArea = p.administrativeArea ?? ""
                var postalCode = p.postalCode ?? ""
                var country = p.country ?? ""
                
                self.address.text = "\(subThoroughfare) \(thoroughfare)\n\(subAdministrativeArea), \(administrativeArea) \(postalCode)\n\(country)"
            }

        })
        
        // Show the locaiton on the map
        var latDelta:CLLocationDegrees = 0.02
        var lonDelta:CLLocationDegrees = 0.02
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var locationCoordinate = usrLocation.coordinate
        var region:MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        
        myMap.setRegion(region, animated: true)
        
        annotation.coordinate = locationCoordinate
        annotation.title = "YOU ARE HERE"
        annotation.subtitle = "In realtime"
        
        myMap.addAnnotation(annotation)
        myMap.selectAnnotation(annotation, animated: true)

    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
}

