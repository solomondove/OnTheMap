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
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: MapViewController.self) {
//                _ = self.navigationController!.popToViewController(controller, animated: true)
//                break
//            } else if controller.isKind(of: TabbedViewController.self) {
//                _ = self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }

        self.navigationController!.popToRootViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

}
