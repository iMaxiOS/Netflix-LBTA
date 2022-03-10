//
//  SearchViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var discovers: [Movie] = [Movie]()
    
    private let discoverTableView: UITableView = {
        let table = UITableView()
        table.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return table
    }()
    
    private let activityIndcator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.tintColor = .label
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private let searchController: UISearchController = {
        let searchBar = UISearchController(searchResultsController: SearchResultViewController())
        searchBar.searchBar.placeholder = "Search a Movie or a Tv show"
        searchBar.searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDiscoverData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
        setupConstrants()
    }
}

private extension SearchViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(discoverTableView)
        view.addSubview(activityIndcator)
        discoverTableView.frame = view.bounds
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        navigationItem.searchController = searchController
        title = "Search"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
    }
    
    func setupConstrants() {
        NSLayoutConstraint.activate([
            activityIndcator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndcator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func fetchDiscoverData() {
        sharedNetworkManager().getDiscover { [weak self] response in
            switch response {
            case .success(let discovers):
                self?.discovers = discovers
                
                DispatchQueue.main.async {
                    self?.discoverTableView.reloadData()
                    self?.activityIndcator.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discovers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: discovers[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
