//
//  Router.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 06.10.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assembleyBuilder: AssemblyModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialController()
    func showDetail(category: Category?)
    func popViewController(countOfItems: Int?)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assembleyBuilder: AssemblyModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, assembleyBuilder: AssemblyModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.assembleyBuilder = assembleyBuilder
    }
    
    func initialController() {
        guard let navigationController = navigationController, let mainPageViewController = assembleyBuilder?.configuredMainModule(router: self) else { return }
        navigationController.viewControllers = [mainPageViewController]
    }
    
    func showDetail(category: Category?) {
        guard let navigationController = navigationController, let detailPageViewController = assembleyBuilder?.configuredDetailModule(category: category, router: self) else { return }
        navigationController.pushViewController(detailPageViewController, animated: true)
    }
    
    func popViewController(countOfItems: Int?) {
        guard let navigationController = navigationController else { return }
        let mainVc = navigationController.viewControllers.first as? MainPageViewController
//        navigationController.presentingViewController as! MainPageViewController
        mainVc?.countOfItems = String(countOfItems ?? 0)
        navigationController.popViewController(animated: true)
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
