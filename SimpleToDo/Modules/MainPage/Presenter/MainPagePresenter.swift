//
//  MainPagePresenter.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 05.10.2023.
//

import Foundation

class MainPagePresenter: MainPageOutput {
    
    var categories: [Category]?
    var router: RouterProtocol?
    weak var view: MainPageInput?
    var dataManager: DataManagerProtocol
    
    required init(view: MainPageInput, dataManager: DataManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.dataManager = dataManager
        self.router = router
        loadCategories()
    }
    
    func loadCategories() {
        dataManager.loadCategory { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories
                self.dataManager.saveItem()
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func createCategory(with name: String) {
        let category = dataManager.createCategory(with: name)
        categories?.append(category)
        view?.success()
    }
    
    func tapOnCategory(category: Category?) {
        router?.showDetail(category: category)
    }
    
    func countOfItems(indexPath: IndexPath) -> String {
        guard let countOfItems = categories?[indexPath.row].item?.count else { return "0" }
        return String(countOfItems)
    }
    
}
