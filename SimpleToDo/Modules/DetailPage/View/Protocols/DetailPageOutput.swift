//
//  DetailPageOutput.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 06.10.2023.
//

import Foundation

protocol DetailPageOutput: AnyObject {
    var items: [Item]? { get set }
    var view: DetailPageInput? { get set }
    init(view: DetailPageInput, dataManager: DataManagerProtocol, router: RouterProtocol, selectedCategory: Category?)
    func loadItems()
    func createItem(with name: String)
    func switchCheckBox(indexPath: IndexPath)
    func deleteItem(indexPath: IndexPath)
    func editItem(with name: String, indexPath: IndexPath)
    func searchItems(with text: String?)
    func backToPreviousViewController()
}
