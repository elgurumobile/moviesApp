//
//  MoviesTabBarViewController.swift
//  TestRappi
//
//  Created by Felipe Aragon on 9/10/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import UIKit

class MoviesTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let popularViewController:MoviesListViewController = storyBoard.instantiateViewController(withIdentifier: "MoviesListViewController") as! MoviesListViewController
        popularViewController.view.tag = TypeRequest.popular.rawValue
        popularViewController.tabBarItem = UITabBarItem(title: "Popular", image: #imageLiteral(resourceName: "favourite-message-icon"), tag: 0)
        popularViewController.setupRx()
        
        let topRatedViewController:MoviesListViewController = storyBoard.instantiateViewController(withIdentifier: "MoviesListViewController") as! MoviesListViewController
        topRatedViewController.view.tag = TypeRequest.toprated.rawValue
        topRatedViewController.tabBarItem = UITabBarItem(title: "Top Rated", image:#imageLiteral(resourceName: "automatic-flash-icon"), tag: 1)
        topRatedViewController.setupRx()
        
        let upcommingViewController:MoviesListViewController = storyBoard.instantiateViewController(withIdentifier: "MoviesListViewController") as! MoviesListViewController
        upcommingViewController.view.tag = TypeRequest.upcoming.rawValue
        upcommingViewController.tabBarItem = UITabBarItem(title: "Upcoming", image:#imageLiteral(resourceName: "calendar-icon"), tag: 2)
        upcommingViewController.setupRx()
        
        let tabBarList = [popularViewController, topRatedViewController,upcommingViewController]
        
        viewControllers = tabBarList
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
