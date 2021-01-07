//
//  MapViewController .swift
//  Telegramme
//
//  Created by Yeo Wen Cong on 5/1/21.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController{
    
    let locationDelegate = LocationDelegate()
    var latestLocation: CLLocation? = nil
    
    let regionRadius: CLLocationDistance = 300
    
    @IBOutlet weak var map: MKMapView!
    
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(
            "535 Clementi Road Singapore 599489",
            completionHandler: {p,e in
                let lat = String(
                    format: "Lat: %3.12f", p![0].location!.coordinate.latitude)
                let long = String(
                    format: "Long: %3.12f", p![0].location!.coordinate.longitude)

                print("\(lat), \(long)")
                
                let nPannotation = MKPointAnnotation()

                nPannotation.coordinate = p![0].location!.coordinate
                nPannotation.title = "Ngee Ann Polytechnic"
                nPannotation.subtitle = "School of ICT"
                self.map.addAnnotation(nPannotation)

            }
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let locationManager: CLLocationManager = {
            $0.requestWhenInUseAuthorization()
            $0.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            $0.startUpdatingLocation()
            $0.startUpdatingHeading()
            return $0
          }(CLLocationManager())
        
        locationManager.delegate = locationDelegate
        
        locationDelegate.locationCallback = { location in
            self.latestLocation = location
            let lat = String(format: "Lat: %3.8f", location.coordinate.latitude)
            let long = String(format: "Long: %3.8f", location.coordinate.longitude)
            print("My Location: \(lat), \(long)")
            
            self.centerMapOnLocation(location: location)
            
            self.annotation.coordinate = location.coordinate
            self.annotation.title = "Me"
            self.map.addAnnotation(self.annotation)
        }
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion (
             center: location.coordinate,
             latitudinalMeters: regionRadius,
             longitudinalMeters: regionRadius)
         
        map.setRegion(coordinateRegion, animated: true)
    }

}
