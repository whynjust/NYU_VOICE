//
//  ViewController.swift
//  NYU-Voice
//
//  Created by Liam Wang on 2017/11/10.
//  Copyright © 2017年 HaiyangWang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let days : Int = 0
    
    var initialDate = Date()
    let dateFormatter = DateFormatter()
    
    @IBAction func TypingWordButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "TypingWordSegue", sender: self)
    }
    @IBAction func RecordingButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "RecordingSegue", sender: self)
    }
    //@IBOutlet weak var daysAfterSurgery: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDays()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initializeDate() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: initialDate)
        initialDate = calendar.date(from: components)!
    }
    
    func setDays() {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let firstDate = dateFormatter.date(from: "2017/11/09")
        let secondDate = Date()
        let calendar = NSCalendar.current
        
        let date1 = calendar.startOfDay(for: firstDate!)
        let date2 = calendar.startOfDay(for: secondDate)
        print(date1)
        print(date2)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        print(components)
        let text = String(describing: components)
        let index = text.index(text.startIndex, offsetBy: 7)
        let result = text.substring(to: index)
        //daysAfterSurgery.text = result
        print(result)
        
    }

    

}

