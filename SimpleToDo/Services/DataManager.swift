//
//  DataManager.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 05.10.2023.
//

import UIKit
import CoreData

protocol DataManagerProtocol {
    func saveItem()
    func createCategory(with name: String) -> Category
    func loadCategory(completion: @escaping (Result<[Category]?, Error>) -> Void)
    func createItem(with name: String, category: Category?, isDone: Bool) -> Item
    func loadItems(category: Category?, completion: @escaping (Result<[Item]?, Error>) -> Void)
    func deleteItem(item: Item?)
    func updateItem(with name: String, item: Item?)
    func searchItems(with text: String?, completion: @escaping (Result<[Item]?, Error>) -> Void)
}

final class DataManager: DataManagerProtocol {
    
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveItem() {
        do {
            try context.save()
        } catch let error {
            print("Error saving context \(error.localizedDescription)")
        }
    }
    
    func createCategory(with name: String) -> Category {
        let category = Category(context: context)
        category.name = name
        self.saveItem()
        return category
    }
    
    func loadCategory(completion: @escaping (Result<[Category]?, Error>) -> Void) {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            let categories = try context.fetch(request)
            completion(.success(categories))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func createItem(with name: String, category: Category?, isDone: Bool) -> Item {
        let item = Item(context: context)
        item.name = name
        item.category = category
        item.isDone = isDone
        self.saveItem()
        return item
    }
    
    func loadItems(category: Category?, completion: @escaping (Result<[Item]?, Error>) -> Void) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "category.name MATCHES %@", category!.name!)
        request.predicate = categoryPredicate
        
        do {
            let items = try context.fetch(request)
            completion(.success(items))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func deleteItem(item: Item?) {
        guard let item = item else { return }
        context.delete(item)
        self.saveItem()
    }
    
    func updateItem(with name: String, item: Item?) {
        guard let item = item else { return }
        item.name = name
        self.saveItem()
    }
    
    func searchItems(with text: String?, completion: @escaping (Result<[Item]?, Error>) -> Void) {
        guard let text = text else { return }
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", text)
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let items = try context.fetch(request)
            completion(.success(items))
        } catch let error {
            completion(.failure(error))
        }
    }
    
}
