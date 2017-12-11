//
//  ProjectListViewController.swift
//  TeamworkTestApp
//
//  Created by Dusan Juranovic on 12/8/17.
//  Copyright © 2017 Dusan Juranovic. All rights reserved.
//

import UIKit

class ProjectListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var myProjects = [Project]()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teamwork Projects"
    }
}

extension ProjectListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectTableViewCell
        cell.projectName.text = myProjects[indexPath.row].name
        cell.companyName.text = myProjects[indexPath.row].companyName
        cell.projectImageView.image = myProjects[indexPath.row].logoImage
        cell.status.text = myProjects[indexPath.row].status?.capitalized
        cell.subStatus.text = myProjects[indexPath.row].subStatus?.lowercased()
        if myProjects[indexPath.row].status == "active" {
            cell.status.textColor = .green
        } else {
            cell.status.textColor = .red
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        index = indexPath.row
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let destination = segue.destination as? DetailViewController
            
            if let viewController = destination {
                viewController.project = myProjects[index]
            }
        }
    }
}
