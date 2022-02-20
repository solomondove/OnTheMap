//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Solomon Dove on 2/18/22.
//

import Foundation
import UIKit
import CoreLocation

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTextView: UITextField!
    @IBOutlet weak var urlTextView: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let addLocationMapVC = "AddLocationMapViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextView.text = ""
        urlTextView.text = ""
        tabBarController?.tabBar.isHidden = true
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelNewLocation))
        navigationItem.title = "Add Location"
        
    }
    
    @IBAction func FindLocationTapped(_ sender: UIButton) {
        UIViewController.setLoading(elements: [submitButton], loading: true, indicator: activityIndicator)
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(locationTextView.text ?? ""){(placemarks, error) in
            UIViewController.setLoading(elements: [self.submitButton], loading: false, indicator: self.activityIndicator
            )
            guard let placemarks = placemarks else {
                self.showAddressFailure()
                return
            }
            
            let newLocationMapController = self.storyboard!.instantiateViewController(withIdentifier: self.addLocationMapVC) as! AddLocationMapViewController
            newLocationMapController.mapString = self.locationTextView.text ?? ""
            newLocationMapController.longitude = placemarks.first?.location?.coordinate.longitude
            newLocationMapController.latitude = placemarks.first?.location?.coordinate.latitude
            newLocationMapController.url = self.urlTextView.text ?? ""
            self.navigationController!.pushViewController(newLocationMapController, animated: true)
        }
    }
    
    func showAddressFailure() {
        let alertVC = UIAlertController(title: "Address Failed", message: "Please try again!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
