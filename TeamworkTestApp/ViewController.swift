//
//  ViewController.swift
//  TeamworkTestApp
//
//  Created by Dusan Juranovic on 12/7/17.
//  Copyright © 2017 Dusan Juranovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var jsonHandler = JsonHandler()
    var projects = [Project]()
    @IBOutlet weak var usernameOrToken: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let url = "https://yat.teamwork.com/projects.json"
        guard usernameOrToken.text != "" && password.text != "" else {
            print("Enter username/password")
            let alert = UIAlertController(title: "Error!", message: "Enter username AND password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        jsonHandler.getJson(fromUrl: url, withUsername: usernameOrToken.text!, andPassword: password.text!, completion: {projects in
            DispatchQueue.main.async {
                guard projects?.count != 0 else {
                    let alert = UIAlertController(title: "Error!", message: "No projects or user not existent", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            if let proj = projects {
                self.projects = proj
                self.performSegue(withIdentifier: "ProjectSegue", sender: self)
            }
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProjectSegue" {
            let navigationController = segue.destination as? UINavigationController
            let destinationVC = navigationController!.topViewController as? ProjectListViewController
            if let viewController = destinationVC {
                print(projects.count)
                viewController.myProjects = projects
            }
        }
    }
}
