//
//  UpcomingViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var moviesUpcoming: [Movie] = [Movie]()
    
    private let upcomingTableView: UITableView = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchUpcomingData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
        setupConstrants()
    }
}

private extension UpcomingViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(upcomingTableView)
        view.addSubview(activityIndcator)
        upcomingTableView.frame = view.bounds
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        title = "Upcoming"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupConstrants() {
        NSLayoutConstraint.activate([
            activityIndcator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndcator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func fetchUpcomingData() {
        sharedNetworkManager().getMoviesUpcoming { [weak self] response in
            switch response {
            case .success(let moviesUpcoming):
                self?.moviesUpcoming = moviesUpcoming
                
                DispatchQueue.main.async {
                    self?.upcomingTableView.reloadData()
                    self?.activityIndcator.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesUpcoming.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: moviesUpcoming[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let upcomingMovie = moviesUpcoming[indexPath.row]
        guard let titleMovie = upcomingMovie.title else { return }
        
        sharedNetworkManager().getMovie(query: titleMovie) { [weak self] result in
            switch result {
            case .success(let movie):
                
                DispatchQueue.main.async {
                    let vc = MoviePreviewViewController()
                    vc.configure(with: MoviePreviewViewModel(title: titleMovie, overview: upcomingMovie.overview ?? "", movie: movie.id))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
