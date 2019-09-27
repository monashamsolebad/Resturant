//
//  OrderConfirmationViewController.swift
//  Resturant
//
//  Created by Mona Shamsolebad on 2019-09-25.
//  Copyright © 2019 Mona Shamsolebad. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    var minutes : Int!
    
    @IBOutlet var timeRemainingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! your wait time is approximately \(minutes) minutes."
        
    }
    

}
