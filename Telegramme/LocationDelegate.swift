//
//  LocationDelegate.swift
//  Telegramme
//
//  Created by Yeo Wen Cong on 5/1/21.
//

import CoreLocation

class LocationDelegate : NSObject, CLLocationManagerDelegate
{
    var locationCallback: ((CLLocation) -> ())? = nil
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation])
    {
        guard let currentLocation = locations.last else { return }
        locationCallback?(currentLocation)
    }
}
