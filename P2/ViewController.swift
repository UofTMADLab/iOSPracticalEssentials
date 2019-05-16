//
//  ViewController.swift
//  PracticalPrototpye
//
//  Created by Mike Spears on 2019-05-13.
//  Copyright © 2019 Mike Spears. All rights reserved.
//

import UIKit
import MapKit



class ViewController: UIViewController, MKMapViewDelegate, MapAPIDelegate {
    
    var annotations = [MapLocation]()
    var selectedLocation: MapLocation!
    var mapAPI: MapAPI!
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapAPI = MapAPI()
        self.mapAPI.delegate = self
        self.mapAPI.connect()
        
        self.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MarkerView")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let vc = segue.destination as! DetailViewController
            vc.mapLocation = self.selectedLocation
            vc.mapAPI = self.mapAPI
        }
    }
    
    // delegate method implementations
    
    func dataRefreshed(newData: [MapLocation]) {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.annotations)
            self.mapView.addAnnotations(newData)
            self.annotations = newData
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "MarkerView")
        annotationView?.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        self.selectedLocation = view.annotation! as? MapLocation
        self.performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    @IBAction func gestureAction(_ sender: Any) {
        let gesture = sender as! UILongPressGestureRecognizer
        guard gesture.state == .began else {
            return
        }
        let coordinate = mapView.convert(gesture.location(in: mapView), toCoordinateFrom: mapView)
        let mapItem = MapLocation(coordinate: coordinate, title: "New item", subtitle: "(555) 555-5555)")
        
        self.mapAPI.postLocation(location: mapItem)
    }
    
}

