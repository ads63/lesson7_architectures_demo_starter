//
//  SearchAppsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchAppsViewController: UIViewController {
    // MARK: - Private Properties
    
    private let presenter: AppSearchViewOutputProtocol
    
    init(presenter: AppSearchViewOutputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private let searchService = ITunesSearchService()
    
    // private var searchResults = [ITunesApp]()
    var searchResults = [ITunesApp]() {
        didSet {
            self.searchView.tableView.isHidden = false
            self.searchView.tableView.reloadData()
            self.searchView.searchBar.resignFirstResponder()
        }
    }
    
    private enum Constants {
        static let reuseIdentifier = "reuseId"
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
}

// MARK: - UITableViewDataSource

extension SearchAppsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return self.searchResults.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let dequeuedCell = tableView
            .dequeueReusableCell(withIdentifier: Constants.reuseIdentifier,
                                 for: indexPath)
        
        guard let cell = dequeuedCell as? AppCell else {
            return dequeuedCell
        }
        
        let app = self.searchResults[indexPath.row]
        
        let cellModel = AppCellModelFactory.cellModel(from: app)
        
        // Передаем данные через модель
        cell.configure(with: cellModel)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchAppsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let app = self.searchResults[indexPath.row]

        self.presenter.viewDidSelect(app)
    }
}

// MARK: - UISearchBarDelegate

extension SearchAppsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        self.presenter.viewDidSearch(with: query)
    }
}

// MARK: - Input

extension SearchAppsViewController: AppSearchViewInputProtocol {
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: "\(error.localizedDescription)",
                                      preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
        self.searchResults = []
        self.searchView.tableView.reloadData()
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
    
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
}
