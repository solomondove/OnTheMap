//
//  UIViewControllerExtension.swift
//  On The Map
//
//  Created by Solomon Dove on 2/17/22.
//

import UIKit

extension UIViewController {
  
    
    @objc func logout(){
        UdacityClient.logout()
        self.dismiss(animated: true, completion: nil)
    }
    
    class func setLoading(elements: [UIControl?], loading: Bool, indicator: UIActivityIndicatorView?){
        if loading {
            indicator?.startAnimating()
            enableUIElements(elements: elements, loading: loading)
        } else {
            DispatchQueue.main.async {
                indicator?.stopAnimating()
                self.enableUIElements(elements: elements, loading: loading)
            }
        }
    }
    
    class func enableUIElements(elements: [UIControl?], loading: Bool) {
        for control in elements {
            if let control = control {
                control.isEnabled = !loading
            }
        }
        
        
    }
    @objc func cancelNewLocation() {
        self.navigationController!.popToRootViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    @objc func addLocationButtonPushed() {
        let newLocationController = self.storyboard!.instantiateViewController(withIdentifier: "AddLocationViewController")
        self.navigationController!.pushViewController(newLocationController, animated: true)
    }
}
