//
//  TabBarViewController.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 03.05.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupTabs()
		
		self.tabBar.backgroundColor = .systemBackground
		self.tabBar.tintColor = .systemMint
		self.tabBar.unselectedItemTintColor = .systemFill
    }
	
	// MARK: - Setup Tab Bar
	private func setupTabs() {
		
		let allImages = self.createNav(with: "Photo Collection", and: UIImage(systemName: "photo.stack"), vc: ImagesCollectionController())
		let favoriteImages = self.createNav(with: "Faforites", and: UIImage(systemName: "heart"), vc: FavoriteViewController())
		
		self.setViewControllers([allImages, favoriteImages], animated: true)
	}
	
	// MARK: - Create Navigation Controller
	private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
		let nav = UINavigationController(rootViewController: vc)
		
		nav.tabBarItem.title = title
		nav.tabBarItem.image = image
	
		nav.viewControllers.first?.navigationItem.title = title
		
		return nav
	}
}
