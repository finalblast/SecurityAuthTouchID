//
//  ViewController.swift
//  SecurityAuthTouchID
//
//  Created by Nam (Nick) N. HUYNH on 3/23/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var buttonCheckTouchId: UIButton!
    
    @IBOutlet weak var buttonUseTouchId: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkTouchIdAvaibility(sender: AnyObject) {
        
        let context = LAContext()
        var error: NSError?
        let isTouchIdAvailable = context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
        buttonUseTouchId.enabled = isTouchIdAvailable
        if isTouchIdAvailable == false {
            
            let alertController = UIAlertController(title: "Touch ID", message: "Touch ID is not available", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            
        }
        
    }

    @IBAction func useTouchId(sender: AnyObject) {
        
        let context = LAContext()
        var error: NSError?
        let reason = "Please authenticate with Touch ID to access your private information"
        
        context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (succeeded, error) -> Void in
            
            if succeeded {
                
                
                
            } else {
                
                
                
            }
            
        }
        
    }
    
}

