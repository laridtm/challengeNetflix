//
//  AppDelegate.swift
//  challangeNetflix
//
//  Created by Larissa Diniz  on 20/02/20.
//  Copyright © 2020 Larissa Diniz . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Movies") as! MovieListViewController
        let presenter = MovieListPresenter(view: controller)
        let worker = MovieListWorker()
        let interactor = MovieListInteractor(presenter: presenter, worker: worker)
        controller.interactor = interactor
        
        let navigationController = storyboard.instantiateViewController(withIdentifier: "Navigation") as! UINavigationController
        navigationController.viewControllers = [controller]
        self.window?.rootViewController = navigationController

        self.window?.makeKeyAndVisible()
        
        return true
    }
}

