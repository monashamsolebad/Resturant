//
//  IntermediaryModels.swift
//  Resturant
//
//  Created by Mona Shamsolebad on 2019-09-22.
//  Copyright © 2019 Mona Shamsolebad. All rights reserved.
//

import Foundation
struct Categories : Codable {
    let categories : [String]
}
struct PreparationTime : Codable {
    let prepTime : Int
    enum CodingKeys : String , CodingKey {
        case prepTime = "preparation_time"
    }
}

