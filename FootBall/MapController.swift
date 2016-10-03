//
//  MapController.swift
//  FootBall
//
//  Created by Thuy Phan on 9/15/16.
//  Copyright © 2016 Nguyen Hai Dang. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController,MKMapViewDelegate {
    
//    MKCoordinateRegion region;
//    region.center = placemark.location.coordinate;
//    
//    MKCoordinateSpan span = {0.005,0.005};
//    
//    region.span = span;
//    [_gMapView setRegion:region animated:YES];
//    
//    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//    annotation.coordinate = region.center;
//    annotation.title = _gSearchBar.text;
//    [_gMapView addAnnotation:annotation];

    @IBOutlet weak var gMapView: MKMapView!
    
    override func viewDidLoad() {
        let geocoder:CLGeocoder = CLGeocoder.init()
        geocoder.geocodeAddressString("Old Trafford", completionHandler: {(placemarkArray, error) in
            
            if placemarkArray?.count > 0 {
                let placemarkObject = placemarkArray?[0]
                var region : MKCoordinateRegion = MKCoordinateRegion()
                region.center = (placemarkObject?.location?.coordinate)!
                
                let span : MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.005, longitudeDelta: 0.005)
                region.span = span
                self.gMapView.setRegion(region, animated: true)
                let annotation : MKPointAnnotation = MKPointAnnotation()
                annotation.coordinate = region.center
                annotation.title = "gattino"
                self.gMapView.addAnnotation(annotation)
                
            }
            
        })
        
        
    }
    
}
