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
        fetchDiscoverData()    }
    
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
        searchController.searchResultsUpdater = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let discover = discovers[indexPath.row]
        guard let titleMovie = discover.title else { return }
        
        sharedNetworkManager().getMovie(query: titleMovie) { [weak self] result in
            switch result {
            case .success(let movie):
                
                DispatchQueue.main.async {
                    let vc = MoviePreviewViewController()
                    vc.configure(with: MoviePreviewViewModel(title: titleMovie, overview: discover.overview ?? "", movie: movie.id))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let searchController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        
        sharedNetworkManager().search(with: query) { response in
            switch response {
            case .success(let movies):
                searchController.configure(with: movies)
                searchController.delegate = self
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: SearchResultViewControllerDelegate {
    func searchResultViewControllerDidTapped(model: MoviePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = MoviePreviewViewController()
            vc.configure(with: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
