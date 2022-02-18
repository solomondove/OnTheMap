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
    
    @IBOutlet private var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The "locations" array is an array of dictionary objects that are similar to the JSON
        // data that you can download from parse.
        let locations = appDelegate.studentLocations
        
        // We will create an MKPointAnnotation for each dictionary in "locations". The
        // point annotations will be stored in this array, and then provided to the map view.
        var annotations = [MKPointAnnotation]()
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        
        for student in locations {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = student.firstName
            let last = student.lastName
            let mediaURL = student.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
        
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

        
        // This delegate method is implemented to respond to taps. It opens the system browser
        // to the URL specified in the annotationViews subtitle property.
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
//        func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//    
//            if control == annotationView.rightCalloutAccessoryView {
//                let app = UIApplication.sharedApplication()
//                app.openURL(NSURL(string: annotationView.annotation.subtitle))
//            }
//        }

      
   
}
