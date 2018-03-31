//
//  TextShowViewController.swift
//  NYU-Voice
//
//  Created by Liam Wang on 2017/11/28.
//  Copyright © 2017年 HaiyangWang. All rights reserved.
//

import UIKit
import EFAutoScrollLabel
import MarqueeLabel

class TextShowViewController: UIViewController {
    
    var data = ""
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var demoLabel: MarqueeLabel!
    
    let scrollingLabel = EFAutoScrollLabel(frame: CGRect(x: -100, y: 500, width: 620, height: 200))
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = data
        label.numberOfLines = 0;
        label.font = label.font.withSize(120)
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        label.adjustsFontSizeToFitWidth = true
        //label.sizeToFit()
        //scrollingLabel.text = data
        //scrollingLabel.text = ""
        demoLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        demoLabel.text = " "
        demoLabel.tag = 301
        demoLabel.speed = .duration(8.0)
        demoLabel.fadeLength = 10.0
        demoLabel.leadingBuffer = 30.0
        demoLabel.trailingBuffer = 20.0
        demoLabel.textAlignment = .center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var changeStyleButton: UIButton!
    
    @IBAction func changeStyleButtonClicked(_ sender: Any) {
        if changeStyleButton.titleLabel?.text == "Active" {
            
            demoLabel.text = data
            demoLabel.font = UIFont.systemFont(ofSize :100)
            demoLabel.sizeToFit()
            //scrollingLabel.backgroundColor = UIColor(displayP3Red: 0.5, green: 0.2, blue: 0.1, alpha: 1)
            
//            scrollingLabel.pauseInterval = 1.0
//            scrollingLabel.labelSpacing = 100
//            scrollingLabel.textAlignment = NSTextAlignment.left
            demoLabel.type = .continuous
            demoLabel.speed = .duration(8.0)
            print(demoLabel.text!)
            print(demoLabel.frame)
            label.text = ""
            changeStyleButton.setTitle("Static", for: .normal)
        } else {
            label.text = data
            demoLabel.text = " "
            print(demoLabel.text!)
            print(demoLabel.frame)
            changeStyleButton.setTitle("Active", for: .normal)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
