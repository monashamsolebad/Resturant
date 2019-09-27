//
//  MenuController.swift
//  Resturant
//
//  Created by Mona Shamsolebad on 2019-09-22.
//  Copyright © 2019 Mona Shamsolebad. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    var order = Order() {
        didSet
        {
            NotificationCenter.default.post(name : MenuController.orderUpdateNotification, object: nil)
        }
    }
    let baseURL = URL(string: "http://localhost:8090/")!
    static let shared = MenuController()
    static let orderUpdateNotification = Notification.Name("MenuController.orderUpdated")
    
    func fetchCategories(completion: @escaping([String]?)-> Void){
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) {
            (data,response,error) in
            if let data = data ,
                let jsonDictionary = try?
                    JSONSerialization.jsonObject(with: data) as? [String : Any],
                let categories = jsonDictionary ["categories"] as? [String] {
                completion(categories)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
        
    }
    func fetchMenuItems(forCategory categoryName : String , completion : @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) {
            (data,response,error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            }
            else {completion(nil)}
        }
        task.resume()
        
        
    }
    func submitOrder(forMenuIDs menuIDs : [Int] , completion : @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url : orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data : [String:[Int]] = ["menuIds" : menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try?
                    jsonDecoder.decode(PreparationTime.self, from: data){
                completion(preparationTime.prepTime)
            }
            else {completion(nil)}
        }
        task.resume()
        
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data){
                completion(image)
            }
            else{
                completion(nil)
            }
        }
        task.resume()
    }
 
    
    func loadOrder() {
        let documentsDirectoryURL =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first!
        let orderFileURL =
            documentsDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: orderFileURL) else
        { return }
        order = (try? JSONDecoder().decode(Order.self, from:
            data)) ?? Order(menuItems: [])
    }

    
    func saveOrder() {
        let documentsDirectoryURL =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first!
        let orderFileURL =
            documentsDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        
        if let data = try? JSONEncoder().encode(order) {
            try? data.write(to: orderFileURL)
        }
    }

    
    func application(_ application: UIApplication,
                        willFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MenuController.shared.loadOrder()
        return true
    }

    
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        MenuController.shared.saveOrder()
    }

    
    func application(_ application: UIApplication,
                        shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication,
                     shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
  



}
