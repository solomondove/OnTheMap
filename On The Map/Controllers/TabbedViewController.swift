//
//  TableViewController.swift
//  On The Map
//
//  Created by Solomon Dove on 2/16/22.
//

import Foundation
import UIKit

class TabbedViewController: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItems =  [UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addLocationButtonPushed)), UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(reload))]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell")!
        let location = appDelegate.studentLocations[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = location.firstName + " " + location.lastName
        cell.detailTextLabel?.text = location.mediaURL
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = appDelegate.studentLocations[(indexPath as NSIndexPath).row]
        let app = UIApplication.shared
        app.open(URL(string: location.mediaURL)!)
        print("opened!")
    }
    
    @objc func reload(){
        UdacityClient.getStudentLocations(completion: self.handleReload)
    }
    
    func handleReload(locations: [StudentLocation], error: Error?) {
        if let error = error {
            print(error)
            return
        }
        print("location success!")
       
        appDelegate.studentLocations = locations
        self.tableView.reloadData()
    }
}
