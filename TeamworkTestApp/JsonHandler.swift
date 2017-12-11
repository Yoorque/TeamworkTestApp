//
//  JsonHandler.swift
//  TeamworkTestApp
//
//  Created by Dusan Juranovic on 12/7/17.
//  Copyright © 2017 Dusan Juranovic. All rights reserved.
//

import UIKit

class JsonHandler: NSObject, NSURLConnectionDelegate {
    func getJson(fromUrl url: String, withUsername username: String, andPassword password: String, completion: @escaping(_ projects: [Project]?) -> ()) {
        
        var myProject: Project?
        var myProjects = [Project]()
        //let tokenString = "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T"
        guard let url = URL(string: url) else {
            print("Not valid URL")
            return
        }
        //let username = tokenString
        //let password = "Bogus"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let urlConnection = URLSession.shared.dataTask(with: request) {data, response, error in
            
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                
                return
            }
            guard let data = data else {
                print("No data: \(error!.localizedDescription)")
                
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                
                let projects = json!["projects"] as? [[String:Any]]
                
                for project in projects! {
                    var projectTags = [Tags]()
                    print(project)
                    //Project
                    let name = project["name"] as! String
                    let id = project["id"] as! String
                    let createdOn = project["created-on"] as! String
                    let lastChangedOn = project["last-changed-on"] as! String
                    let logo = project["logo"] as! String
                    let projectDescription = project["description"] as! String
                    let startDate = project["startDate"] as! String
                    let endDate = project["endDate"] as! String
                    let status = project["status"] as! String
                    let subStatus = project["subStatus"] as! String
                    let admin = project["isProjectAdmin"] as! Bool
                    var logoImage: UIImage? {
                        if let url = URL(string: logo) {
                            if let data = NSData(contentsOf: url) {
                                let image = UIImage(data: data as Data)
                                return image
                            }
                        } else {
                            return UIImage(named: "defaultImage")
                        }
                        return nil
                    }
                    
                    //Tags
                    let tags = project["tags"] as! [[String:Any]]
                    for tag in tags {
                        let tagColor = tag["color"] as! String
                        let tagId = tag["id"] as! String
                        let tagName = tag["name"] as! String
                        
                        let newTag = Tags(tagColor: tagColor, tagId: tagId, tagName: tagName)
                        projectTags.append(newTag)
                    }
                    //Category
                    let category = project["category"] as! [String:Any]
                    let catId = category["id"] as! String
                    let catName = category["name"] as! String
                    
                    //Company
                    let company = project["company"] as! [String:Any]
                    let isOwner = company["is-owner"] as! String
                    let compName = company["name"] as! String
                    
                    //Create Project
                    myProject = Project(name: name, id: id, createdOn: createdOn, lastChangedOn: lastChangedOn, logo: logo, projectDescription: projectDescription, startDate: startDate, endDate: endDate, status: status, subStatus: subStatus, isAdmin: admin, isOwner: isOwner, companyName: compName, logoImage: logoImage!, tags: projectTags, catId: catId, catName: catName)
                    
                    //Add Project to Projects array
                    myProjects.append(myProject!)
                }
                
            } catch {
                print("Not json")
            }
            completion(myProjects)
            
        }
        urlConnection.resume()
    }
}
