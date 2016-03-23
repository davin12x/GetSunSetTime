//
//  ViewController.swift
//  GetTemperature
//
//  Created by Lalit on 2016-03-22.
//  Copyright © 2016 Bagga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var TempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func onUpdateButtonPressed(sender: AnyObject) {
        
        let services = HttpServices()
        services.getTemp { (temp, success) in
            if success{
                dispatch_async(dispatch_get_main_queue(), { 
                     self.TempLabel.text = temp
                })
            }
            else{
                dispatch_async(dispatch_get_main_queue(), {
                    self.TempLabel.text = temp
                })
            }
        }
    }
    
    
}

