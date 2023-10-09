//
//  DetailPagePresenter.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 06.10.2023.
//

import Foundation

class DetailPagePresenter: DetailPageOutput {
    
    var selectedCategory: Category? {
        didSet {
            self.loadItems()
        }
    }
    var items: [Item]?
    var router: RouterProtocol?
    var view: DetailPageInput?
    var dataManager: DataManagerProtocol
    
    required init(view: DetailPageInput, dataManager: DataManagerProtocol, router: RouterProtocol, selectedCategory: Category?) {
        self.view = view
        self.dataManager = dataManager
        self.router = router
        defer { self.selectedCategory = selectedCategory }
    }
    
    func loadItems() {
        dataManager.loadItems(category: selectedCategory) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.items = items
                self.dataManager.saveItem()
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func createItem(with name: String) {
        let item = dataManager.createItem(with: name, category: selectedCategory, isDone: false)
        items?.append(item)
        view?.success()
    }
    
    func deleteItem(indexPath: IndexPath) {
        guard let item = items?[indexPath.row] else { return }
        dataManager.deleteItem(item: item)
        items?.remove(at: indexPath.row)
        view?.success()
    }
    
    func editItem(with name: String, indexPath: IndexPath) {
        guard let item = items?[indexPath.row] else { return }
        dataManager.updateItem(with: name, item: item)
        view?.success()
    }
    
    func switchCheckBox(indexPath: IndexPath) {
        items?[indexPath.row].isDone = !(items?[indexPath.row].isDone ?? false)
        view?.success()
        dataManager.saveItem()
    }
    
    func searchItems(with text: String?) {
        dataManager.searchItems(with: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.items = items
                self.dataManager.saveItem()
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func backToPreviousViewController() {
        router?.popViewController(countOfItems: items?.count)
    }
    
}
