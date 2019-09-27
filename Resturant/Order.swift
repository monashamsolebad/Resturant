//
//  Order.swift
//  Resturant
//
//  Created by Mona Shamsolebad on 2019-09-22.
//  Copyright © 2019 Mona Shamsolebad. All rights reserved.
//

import Foundation
struct Order : Codable {
    var menuItems : [MenuItem]
    init (menuItems : [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
