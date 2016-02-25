//
//  TabBarViewController.swift
//  TeamSwift-App
//
//  Created by Sam Wylock on 2/18/16.
//
//

import UIKit

class TabBarViewController: UITabBarController {

    // Authors View Controller
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Initialize Tab Bar Item
        tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "FoodFeed"), tag: 0)
        
        tabBarItem.badgeValue = "8"
    }
    
}
