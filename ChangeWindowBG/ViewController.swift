//
//  ViewController.swift
//  ChangeWindowBG
//
//  Created by Karthikeyan A. on 22/10/19.
//  Copyright © 2019 Karthikeyan. All rights reserved.
//

import UIKit

extension Date {
    var hour: Int { return Calendar.current.component(.hour, from: self) } // get hour only from Date
}

extension Notification.Name {
    static let becomeActive = UIApplication.didBecomeActiveNotification
}

extension UIApplication{
    
    var mainWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                return windowScene.windows.first
            }
        }
        return UIApplication.shared.keyWindow
    }
}

enum Color: String {
 case brown
 case blue
 case green

  var create: UIColor {
     switch self {
        case .brown:
          return .brown
      case .blue:
          return .blue
      case .green:
          return .green
     }
  }
}
    
    
    class ViewController: UIViewController {
        
        var timer = Timer()
        @IBOutlet weak var changeVCBGSegment: UISegmentedControl!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Declare an observer for UIApplicationDidBecomeActive
            NotificationCenter.default.addObserver(self, selector: #selector(scheduleTimer), name:  .becomeActive, object: nil)
            
            // change the background each time the view is opened
            changeBackground()
        }
        
        @objc func scheduleTimer() {
            // schedule the timer
            timer = Timer(fireAt: Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 6..<21 ~= Date().hour ? 21 : 6), matchingPolicy: .nextTime)!, interval: 0, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: false)
            print(timer.fireDate)
            RunLoop.main.add(timer, forMode: .common)
            //print("new background chenge scheduled at:", timer.fireDate.description(with: .current))
        }
        
        @objc func changeBackground(){
            // check if day or night shift
            if let getWindow = UIApplication.shared.mainWindow {
                getWindow.backgroundColor =  6..<21 ~= Date().hour ? .yellow : .red
            }
            
            // schedule the timer
            scheduleTimer()
        }
        
        @IBAction func ChangeViewBG(_ sender: UISegmentedControl) {
            if let getWindow = UIApplication.shared.mainWindow, let getColor =  sender.titleForSegment(at: sender.selectedSegmentIndex), let color = Color(rawValue: getColor) {
                getWindow.backgroundColor = color.create
            }
        }
}

