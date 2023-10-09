//
//  MainPageOutput.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 05.10.2023.
//

import Foundation

protocol MainPageOutput: AnyObject {
    init(view: MainPageInput, dataManager: DataManagerProtocol, router: RouterProtocol)
    func loadCategories()
    var categories: [Category]? { get set }
    func tapOnCategory(category: Category?)
    func createCategory(with name: String)
    func countOfItems(indexPath: IndexPath) -> String
}
