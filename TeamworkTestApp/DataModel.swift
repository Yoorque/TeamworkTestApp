//
//  DataModel.swift
//  TeamworkTestApp
//
//  Created by Dusan Juranovic on 12/8/17.
//  Copyright © 2017 Dusan Juranovic. All rights reserved.
//

import UIKit

class Project: NSObject {
    
    let name: String?
    let id: String?
    let createdOn: String?
    let lastChangedOn: String?
    let logo: String?
    let projectDescription: String?
    let startDate: String?
    let endDate: String?
    let status: String?
    let subStatus: String?
    let isAdmin: Bool?
    let isOwner: String?
    let companyName: String?
    let logoImage: UIImage?
    let tags: [Tags]?
    let catId: String?
    let catName: String?
    
    init(name: String, id: String, createdOn: String, lastChangedOn: String, logo: String, projectDescription: String, startDate: String, endDate: String, status: String, subStatus: String, isAdmin: Bool, isOwner: String, companyName: String, logoImage: UIImage, tags: [Tags], catId: String, catName: String) {
        self.name = name
        self.id = id
        self.createdOn = createdOn
        self.lastChangedOn = lastChangedOn
        self.logo = logo
        self.projectDescription = projectDescription
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.subStatus = subStatus
        self.isAdmin = isAdmin
        self.isOwner = isOwner
        self.companyName = companyName
        self.logoImage = logoImage
        self.tags = tags
        self.catId = catId
        self.catName = catName
    }
}
class Tags {
    let tagColor: String
    let tagId: String?
    let tagName: String?
    
    init(tagColor: String, tagId: String, tagName: String) {
        self.tagColor = tagColor
        self.tagId = tagId
        self.tagName = tagName
    }
}


