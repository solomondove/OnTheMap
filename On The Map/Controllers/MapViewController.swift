//
//  MapViewController.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let initialLocation = CLLocation(latitude: 37.7749, longitude: 122.4194)
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        self.load(locations: appDelegate.studentLocations)
        
        UIViewController.setLoading(elements: [], loading: true, indicator: self.activityIndicator )
        UdacityClient.getStudentLocations(completion: self.handleStudentLocationResponse)
      
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItems =  [UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addLocationButtonPushed)), UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(reload))]
        
        
    }
    
        // MARK: - MKMapViewDelegate

        // Here we create a view with a "right callout accessory view". You might choose to look into other
        // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
        // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("in this function")
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            print(view.annotation!)
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!)
                
                print(toOpen)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reload()
    }
    
    func handleStudentLocationResponse(locations: [StudentLocation], error: Error?) {
        if let error = error {
            print(error)
            return
        }
        UIViewController.setLoading(elements: [], loading: false, indicator: self.activityIndicator )
        appDelegate.studentLocations = locations
        self.load(locations: appDelegate.studentLocations)
    }
    
    @objc func reload(){
        UIViewController.setLoading(elements: [], loading: true, indicator: self.activityIndicator )
        UdacityClient.getStudentLocations(completion: self.handleStudentLocationResponse)
    }
    
    func load(locations: [StudentLocation]){
        var annotations = [MKPointAnnotation]()
        for (index, student) in locations.enumerated() {
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            if index == 0 {
                mapView.centerCoordinate = coordinate
            }
            let first = student.firstName
            let last = student.lastName
            let mediaURL = student.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
    }
    
    @objc func addLocationButtonPushed() {
        let newLocationController = self.storyboard!.instantiateViewController(withIdentifier: "AddLocationViewController")
        self.navigationController!.pushViewController(newLocationController, animated: true)
    }
}
