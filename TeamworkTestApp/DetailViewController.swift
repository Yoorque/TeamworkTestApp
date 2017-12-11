//
//  DetailViewController.swift
//  TeamworkTestApp
//
//  Created by Dusan Juranovic on 12/9/17.
//  Copyright © 2017 Dusan Juranovic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIView! {
        didSet{
            if project.status == "active" {
                backgroundImageView.backgroundColor = .green
            } else {
                backgroundImageView.backgroundColor = .red
            }
        }
    }
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = project.logoImage
        }
    }
    @IBOutlet weak var projectName: UILabel! {
        didSet {
            projectName.text = project.name
        }
    }
    @IBOutlet weak var companyName: UILabel! {
        didSet {
            companyName.text = project.companyName
        }
    }
    
    @IBOutlet weak var isAdmin: UILabel! {
        didSet {
            if project.isAdmin == true {
                isAdmin.text = "Admin"
            } else {
                isAdmin.text = "User"
            }
        }
    }
    @IBOutlet weak var isOwner: UILabel! {
        didSet {
            isOwner.text = project.isOwner
        }
    }
    @IBOutlet weak var category: UILabel! {
        didSet {
            category.text = project.catName
        }
    }
    @IBOutlet weak var id: UILabel! {
        didSet {
            id.text = project.id
        }
    }
    @IBOutlet weak var dateCreated: UILabel! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: project.createdOn!)!
            dateFormatter.dateFormat = "dd-MMM yy HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            dateCreated.text = dateString
        }
    }
    
    @IBOutlet weak var dateChanged: UILabel! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: project.lastChangedOn!)!
            dateFormatter.dateFormat = "dd-MMM yy HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            dateChanged.text = dateString
        }
    }
    @IBOutlet weak var startDate: UILabel! {
        didSet {
            startDate.text = project.startDate
        }
    }
    @IBOutlet weak var endDate: UILabel! {
        didSet {
            endDate.text = project.endDate
        }
    }
    @IBOutlet weak var projectDescription: UITextView! {
        didSet {
            projectDescription.text = project.projectDescription
        }
    }
    
    @IBOutlet weak var timeLeft: UILabel!
    let status = ""
    
    var project: Project!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDate.text = formatDates(forDateString: startDate.text!)
        endDate.text = formatDates(forDateString: endDate.text!)
    }
    
    func formatDates(forDateString dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "dd-MMM yyyy"
        let dateString = dateFormatter.string(from: date)
        timeLeft.text = date.offsetFrom(date: Date())
        return dateString
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return project.tags?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath)
        cell.textLabel?.text = project.tags![indexPath.row].tagName
        let color = project.tags![indexPath.row].tagColor
        cell.textLabel?.textColor = .white
        cell.contentView.backgroundColor = UIColor(hexString: color)
        cell.backgroundColor = UIColor(hexString: color)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contributors"
    }
}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension Date {
    func offsetFrom(date: Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.year, .month, .day]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self);
        
        let days = "\(difference.day ?? 0)days till deadline"
        let months = "\(difference.month ?? 0)months" + " " + days
        let years = "\(difference.year ?? 0)years" + " " + months
        
        if let year = difference.year, year       > 0 { return years }
        if let month = difference.month, month    > 0 { return months }
        if let day = difference.day, day          > 0 { return days }
        
        return "Deadline is today"
    }
}
