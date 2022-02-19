//
//  AddLocationMapViewController.swift
//  On The Map
//
//  Created by Solomon Dove on 2/18/22.
//

import Foundation
import MapKit

class AddLocationMapViewController: UIViewController, MKMapViewDelegate {
    
    var longitude: Double!
    var latitude: Double! 
    var url: String!
    var mapString: String!
    var firstName = "Jane"
    var lastName = "Doe"
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
       placeLocation()
    }
    
    func placeLocation() {
        var annotations = [MKPointAnnotation]()
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "\(firstName) \(lastName)"
        annotation.subtitle = url
        annotations.append(annotation)
        self.mapView.addAnnotations(annotations)
    }
    
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
    
    @IBAction func saveLocation(){
        UdacityClient.postStudentLocation(lastName: lastName, firstName: firstName, mapString: mapString, mediaURL: url, latitude: latitude, longitude: longitude, completion: self.handleLocationResponse)
    }
    
    func handleLocationResponse (success: Bool, error: Error?) {
        if success {
            print("successfully posted a location")
            self.navigationController!.popToRootViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
        } else {
            print(error!)
        }
    }
}
