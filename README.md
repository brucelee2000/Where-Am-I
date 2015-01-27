# Where-Am-I
Convert location to USA address format
--------------------------------------
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
        
        ...


