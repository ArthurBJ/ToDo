//
//  NavBarController.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 05.10.2023.
//

import UIKit

class NavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarColor()
    }
    
    func setupNavBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        appearance.backgroundColor = Resources.Colors.backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: Resources.Colors.titleFontColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Resources.Colors.titleFontColor]
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.prefersLargeTitles = true
        
        self.navigationBar.tintColor = Resources.Colors.titleFontColor
        UIBarButtonItem.appearance().tintColor = Resources.Colors.titleFontColor
        
    }
}
