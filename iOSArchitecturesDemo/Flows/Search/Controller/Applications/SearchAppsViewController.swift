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

    private let viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
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

    var searchResults = [SearchAppCellModel]() {
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
        self.bindViewModel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }

    private func bindViewModel() {
        // Во время загрузки данных показываем индикатор загрузки
        self.viewModel.isLoading.addObserver(self) {
            [weak self] isLoading, _ in
            self?.throbber(show: isLoading)
        }
        // Если пришла ошибка, то отобразим ее в виде алерта
        self.viewModel.error.addObserver(self) {
            [weak self] error, _ in if let error = error {
                self?.showError(error: error)
            }
        }
        // Если вью-модель указывает, что нужно показать экран пустых результатов, то делаем это
        self.viewModel.showEmptyResults.addObserver(self) {
            [weak self] showEmptyResults, _ in

            self?.searchView.emptyResultView.isHidden = !showEmptyResults
            self?.searchView.tableView.isHidden = showEmptyResults
        }
        // При обновлении данных, которые нужно отображать в ячейках, сохраняем их и перезагружаем tableView
        self.viewModel.cellModels.addObserver(self) {
            [weak self] searchResults, _ in
            self?.searchResults = searchResults
        }
    }

    private func configure(cell: AppCell, with app: SearchAppCellModel) {
        cell.onDownloadButtonTap = { [weak self] in
            self?.viewModel.didTapDownloadApp(app)
        }
        cell.configure(with: AppCellModelFactory.cellModel(from: app))
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

        self.configure(cell: cell, with: self.searchResults[indexPath.row])
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

        self.viewModel.didSelectApp(app)
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
        self.viewModel.search(for: query)
    }
}

// MARK: - Input

// extension SearchAppsViewController: AppSearchViewInputProtocol {
extension SearchAppsViewController {
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
