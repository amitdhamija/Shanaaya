//
//  EventDetailsViewController.swift
//  Shanaaya
//
//  Created by Amit Dhamija on 3/10/18.
//  Copyright © 2018 Amit Dhamija. All rights reserved.
//

import UIKit
import EventKit

class EventDetailsViewController: UIViewController {
    
    //var defaults = UserDefaults.standard
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addCalendarEventButton: UIButton!
    
    @IBAction func addCalendarEventButtonTapped(_ sender: Any) {
        
        //addCalendarEvent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.borderColor = UIColor.colorWithHexValue("EC86AA")?.cgColor
        profileImageView.clipsToBounds = true
    }
    
    private func saveEvent(to eventStore: EKEventStore, event: EKEvent) {
        do {
            try eventStore.save(event, span: .thisEvent)
            
            //defaults.set(event.eventIdentifier, forKey: "BirthdayEventId")
            
            let alert = UIAlertController(title: "Event Added To Calendar", message: "This event has been added to your Calendar.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } catch let error as NSError {
            let alert = UIAlertController(title: "Unable To Add Event", message: (error as NSError).localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func addCalendarEvent() {
        
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let startDate: Date? = dateFormatter.date(from: "2018-05-26 18:00:00")
                let endDate: Date? = dateFormatter.date(from: "2018-05-27 00:00:00")
                let event = EKEvent(eventStore: eventStore)
                
                var eventExists = false
                
                event.title = "Shanaaya's 1st Birthday"
                event.startDate = startDate
                event.endDate = endDate
                event.notes = ""
                event.location = "14421 Arctic Fox Ave, Eastvale, CA 92880"
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                /*
                if let eventId = self.defaults.string(forKey: "BirthdayEventId"),
                    let _ = eventStore.event(withIdentifier: eventId) {
                    
                    let alert = UIAlertController(title: "Event Already Exists", message: "This event already exists in your Calendar.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.saveEvent(to: eventStore, event: event)
                }
                */
                
                let predicate = eventStore.predicateForEvents(withStart: startDate!, end: endDate!, calendars: nil)
                let existingEvents = eventStore.events(matching: predicate)
                
                for singleEvent in existingEvents {
                    if singleEvent.title == "Shanaaya's 1st Birthday" && singleEvent.startDate == startDate && singleEvent.endDate == endDate {
                        eventExists = true
                        
                        let alert = UIAlertController(title: "Event Already Exists", message: "This event already exists in your Calendar.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        break
                    }
                }
                if !eventExists {
                    self.saveEvent(to: eventStore, event: event)
                }
            }
            else {
                // permission not granted; show settings
                
            }
        }
    }
}

extension UIColor {
    
    static func colorWithRgbComponents(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    static func colorWithHexValue(_ hexValue: String, alpha: CGFloat) -> UIColor? {
        var hexValue = hexValue
        
        if hexValue.hasPrefix("#") {
            //hexValue = hexValue.substring(from: hexValue.characters.index(hexValue.startIndex, offsetBy: 1))
            hexValue = String(hexValue[hexValue.index(hexValue.startIndex, offsetBy: 1)...])
        }
        
        guard hexValue.range(of: "(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .regularExpression) != nil else {
            return nil
        }
        
        if hexValue.count == 3 {
            
            //let redHex   = hexValue.substring(to: hexValue.characters.index(hexValue.startIndex, offsetBy: 1))
            let redHex   = String(hexValue[..<hexValue.index(hexValue.startIndex, offsetBy: 1)])
            //let greenHex = hexValue.substring(with: (hexValue.characters.index(hexValue.startIndex, offsetBy: 1) ..< hexValue.characters.index(hexValue.startIndex, offsetBy: 2)))
            let greenHex = String(hexValue[hexValue.index(hexValue.startIndex, offsetBy: 1) ..< hexValue.index(hexValue.startIndex, offsetBy: 2)])
            //let blueHex  = hexValue.substring(from: hexValue.characters.index(hexValue.startIndex, offsetBy: 2))
            let blueHex  = String(hexValue[hexValue.index(hexValue.startIndex, offsetBy: 2)...])
            hexValue = redHex + redHex + greenHex + greenHex + blueHex + blueHex
        }
        
        //let redHex = hexValue.substring(to: hexValue.characters.index(hexValue.startIndex, offsetBy: 2))
        let redHex = String(hexValue[..<hexValue.index(hexValue.startIndex, offsetBy: 2)])
        //let greenHex = hexValue.substring(with: (hexValue.characters.index(hexValue.startIndex, offsetBy: 2) ..< hexValue.characters.index(hexValue.startIndex, offsetBy: 4)))
        let greenHex = String(hexValue[hexValue.index(hexValue.startIndex, offsetBy: 2) ..< hexValue.index(hexValue.startIndex, offsetBy: 4)])
        //let blueHex = hexValue.substring(with: (hexValue.characters.index(hexValue.startIndex, offsetBy: 4) ..< hexValue.characters.index(hexValue.startIndex, offsetBy: 6)))
        let blueHex = String(hexValue[hexValue.index(hexValue.startIndex, offsetBy: 4) ..< hexValue.index(hexValue.startIndex, offsetBy: 6)])
        
        var redInt:   CUnsignedInt = 0
        var greenInt: CUnsignedInt = 0
        var blueInt:  CUnsignedInt = 0
        
        Scanner(string: redHex).scanHexInt32(&redInt)
        Scanner(string: greenHex).scanHexInt32(&greenInt)
        Scanner(string: blueHex).scanHexInt32(&blueInt)
        
        return UIColor(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: alpha)
    }
    
    static func colorWithHexValue(_ hexValue: String) -> UIColor? {
        
        return colorWithHexValue(hexValue, alpha: 1.0)
    }
}
