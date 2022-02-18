//
//  ViewController.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import UIKit

class LoginViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    

    @IBAction func loginTapped(_ sender: UIButton) {
        self.setLoggingIn(true)
        UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: self.handleLoginResponse)
    }
    
    func handleLoginResponse(success: Bool, error: Error?){
        self.setLoggingIn(false)
        if success {
            print("YEESS")
            
            UdacityClient.getStudentLocations(completion: self.handleStudentLocationResponse)
        } else {
            print(error!)
            self.showLoginFailure()
        }
    }
    
    func handleStudentLocationResponse(locations: [StudentLocation], error: Error?) {
        if let error = error {
            print(error)
            return
        }
        print("location success!")
        appDelegate.studentLocations = locations
        self.performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    func showLoginFailure() {
        let alertVC = UIAlertController(title: "Login Failed", message: "Please try again!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func setLoggingIn(_ loggingIn: Bool){
        if loggingIn {
            activityIndicator.startAnimating()
            enableUIElements(loggingIn)
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.enableUIElements(loggingIn)
            }
        }
    }
    
    func enableUIElements(_ loggingIn: Bool) {
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
}

