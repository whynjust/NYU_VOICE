//
//  TypingViewController.swift
//  NYU-Voice
//
//  Created by Liam Wang on 2017/11/21.
//  Copyright © 2017年 HaiyangWang. All rights reserved.
//

import UIKit

class TypingViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func showButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.cornerRadius = 10.0
        textField.clipsToBounds = true
        textField.placeholder = "Please input your words."
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SendTextSegue" {
            print(textField.text!)
            let textShowVC = segue.destination as! TextShowViewController
            textShowVC.data = textField.text!
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
