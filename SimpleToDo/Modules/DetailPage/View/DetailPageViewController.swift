//
//  DetailPageViewController.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 06.10.2023.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    // MARK: - Variables
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    let detailPageView: DetailPageView = DetailPageView()
    var presenter: DetailPageOutput!
    
    override func loadView() {
        view = detailPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTable()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        view.backgroundColor = Resources.Colors.backgroundColor
        
        // add navbarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Resources.Images.backButton, style: .plain, target: self, action: #selector(goToBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Resources.Images.addCategory, style: .plain, target: self, action: #selector(addItem))
        
        searchBar.delegate = self
        detailPageView.tableView.tableHeaderView = searchBar
    }
    
    private func setupTable() {
        detailPageView.tableView.delegate = self
        detailPageView.tableView.dataSource = self
    }
    
    @objc func goToBack() {
        presenter.backToPreviousViewController()
    }
    
    @objc func addItem() {
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        alert.addTextField()
        
        let addAction = UIAlertAction(title: "add", style: .default) { _ in
            guard let itemName = alert.textFields?.first?.text else { return }
            self.presenter.createItem(with: itemName)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource


extension DetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Resources.detailTableReuseId, for: indexPath) as? DetailPageTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = presenter?.items?[indexPath.row].name
        cell.isDone = presenter?.items?[indexPath.row].isDone
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.switchCheckBox(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            self.presenter.deleteItem(indexPath: indexPath)
        }
        
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        return actions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "edit") { _, _, success in
            let alert = UIAlertController(title: "Enter new task name", message: "", preferredStyle: .alert)
            alert.addTextField()
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                guard let newName = alert.textFields?.first?.text else { return }
                self.presenter.editItem(with: newName, indexPath: indexPath)
                success(true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        let actions = UISwipeActionsConfiguration(actions: [editAction])
        return actions
    }
}

// MARK: - DetailPageInput


extension DetailPageViewController: DetailPageInput {
    
    func success() {
        detailPageView.tableView.reloadData()
    }
    
    func failure(error: Error) {
        print("\(error.localizedDescription)")
    }
    
}

// MARK: - UISearchBarDelegate


extension DetailPageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchItems(with: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            presenter.loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
