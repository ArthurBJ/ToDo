//
//  MainPageViewController.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 05.10.2023.
//

import UIKit

class MainPageViewController: UIViewController {
    
    // MARK: - Variables
    
    var countOfItems: String?
    
    let mainPageView: MainPageView = MainPageView()
    var presenter: MainPageOutput!
    
    override func loadView() {
        view = mainPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTable()
    }
    
    // MARK: - Setup View
    
    
    private func setupView() {
        view.backgroundColor = Resources.Colors.backgroundColor
        title = Resources.Strings.toDoTitle
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Resources.Images.addCategory, style: .plain, target: self, action: #selector(addCategory))
    }
    
    private func setupTable() {
        mainPageView.tableView.delegate = self
        mainPageView.tableView.dataSource = self
    }
    
    @objc func addCategory() {
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        alert.addTextField()
        let addAction = UIAlertAction(title: "add", style: .default) { _ in
            let categoryName = alert.textFields?.first?.text
            self.presenter.createCategory(with: categoryName!)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource


extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Resources.mainTableReuseId, for: indexPath) as? MainPageTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = presenter.categories?[indexPath.row].name
        cell.descriptionLabel.text = "You have \(presenter.countOfItems(indexPath: indexPath)) task"
//        cell.descriptionLabel.text = "You have \(countOfItems) task"?
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = presenter.categories?[indexPath.row]
        presenter.tapOnCategory(category: category)
    }
    
}

// MARK: - MainPageInput


extension MainPageViewController: MainPageInput {
    
    func success() {
        mainPageView.tableView.reloadData()
    }
    
    func failure(error: Error) {
        print("Failed to get data \(error.localizedDescription)")
    }
    
}
