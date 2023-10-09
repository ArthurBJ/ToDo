//
//  AssembleyModuleBuilder.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 06.10.2023.
//

import UIKit

protocol AssemblyModuleBuilderProtocol {
    func configuredMainModule(router: RouterProtocol) -> UIViewController
    func configuredDetailModule(category: Category?, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyModuleBuilderProtocol {
    
    func configuredMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainPageViewController()
        let dataManager = DataManager()
        let presenter = MainPagePresenter(view: view, dataManager: dataManager, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
    func configuredDetailModule(category: Category?, router: RouterProtocol) -> UIViewController {
        let view = DetailPageViewController()
        let dataManager = DataManager()
        let presenter = DetailPagePresenter(view: view, dataManager: dataManager, router: router, selectedCategory: category)
        
        view.presenter = presenter
        view.title = category?.name
        
        return view
    }
}
