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

        emailTextField.text = ""
        passwordTextField.text = ""
        logoImageView.image = UIImage(named: "Pin Picture")
    }
    

    @IBAction func loginTapped(_ sender: UIButton) {
        let objects = [self.emailTextField, self.loginButton, self.passwordTextField]
        UIViewController.setLoading(elements: objects, loading: true, indicator: self.activityIndicator)
        
        UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: self.handleLoginResponse)
    }
    
    func handleLoginResponse(success: Bool, error: Error?){
        let objects = [self.emailTextField, self.loginButton, self.passwordTextField]
        UIViewController.setLoading(elements: objects, loading: false, indicator: self.activityIndicator)
        
        if success {
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
            emailTextField.text = ""
            passwordTextField.text = ""
        } else {
            print(error!)
            self.showLoginFailure()
        }
    }
    
    
    func showLoginFailure() {
        let alertVC = UIAlertController(title: "Login Failed", message: "Please try again!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: self)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let app = UIApplication.shared
        app.open(URL(string: "https://www.google.com/url?q=https://www.udacity.com/account/auth%23!/signup&sa=D&source=editors&ust=1645076831046014&usg=AOvVaw3wxYvvktSfiRUAxjNNlOoQ")!)
    }
}

