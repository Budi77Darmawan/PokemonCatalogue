//
//  TabBarController.swift
//  Pokedex
//
//  Created by Budi Darmawan on 11/10/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func makeTabBar() -> TabBarController {
        self.viewControllers = [
            makeNavigation(viewController: createHomeTab())
        ]
        return self
    }
    
    private func makeNavigation(viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.delegate = self
        navigation.navigationBar.prefersLargeTitles = false
        return navigation
    }
    
    
    private func createHomeTab() -> UIViewController {
        let homeController = HomeViewController()
        homeController.tabBarItem.title = "Home"
        homeController.tabBarItem.image = UIImage(systemName: "house")
        homeController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        let viewModel = HomeViewModel(useCase: Injection().provideHomeUseCase())
        homeController.viewModel = viewModel
        return homeController
    }
    
}

extension UIViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if #available(iOS 14.0, *) {
            viewController.navigationItem.backButtonDisplayMode = .minimal
        } else {
            // Fallback on earlier versions
            viewController.navigationItem.backButtonTitle = ""
        }
    }
}
