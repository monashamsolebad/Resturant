//
//  MenuItemDetailViewController.swift
//  Resturant
//
//  Created by Mona Shamsolebad on 2019-09-22.
//  Copyright © 2019 Mona Shamsolebad. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    var menuItem : MenuItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        addToOrderButton.layer.cornerRadius = 0.5
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var detailTextLabel: UILabel!
    
    @IBOutlet var addToOrderButton: UIButton!
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        detailTextLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        MenuController.shared.order.menuItems.append(menuItem)
    }
}

