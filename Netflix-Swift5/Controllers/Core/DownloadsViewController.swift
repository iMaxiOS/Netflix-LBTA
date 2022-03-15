//
//  DownloadsViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var downloadedMovies: [MovieItem] = [MovieItem]()
    
    private let downloadTableView: UITableView = {
        let table = UITableView()
        table.register(UpcomingTableViewCell.self,
                       forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchDataFromDatabase()
        listenNotificationCenter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
    }
}

private extension DownloadsViewController {
    func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(downloadTableView)
        downloadTableView.frame = view.bounds
        downloadTableView.delegate = self
        downloadTableView.dataSource = self
        title = "Download"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fetchDataFromDatabase() {
        shareDataNSPersistentManager().fetchingMovieFromDatabase { [weak self] response in
            switch response {
            case .success(let movies):
                self?.downloadedMovies = movies
                
                DispatchQueue.main.async {
                    self?.downloadTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeMovieFromDatabase(indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Remove") { [weak self] (action, view, complition) in
            
            guard let removeMovie =  self?.downloadedMovies[indexPath.row] else {
                return
            }
            
            shareDataNSPersistentManager().removeMovieFromDatabase(model: removeMovie) { [weak self] result in
                switch result {
                case .success():
                    DispatchQueue.main.async {
                        self?.downloadTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            self?.downloadedMovies.remove(at: indexPath.row)
            self?.downloadTableView.deleteRows(at: [indexPath], with: .fade)
            
            complition(true)
        }

        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .systemRed

        return action
    }
    
    func listenNotificationCenter() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { [weak self] _ in
            self?.fetchDataFromDatabase()
        }
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier,
                                                       for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = downloadedMovies[indexPath.row]
        
        cell.configure(with: Movie(id: Int(movie.id),
                                   title: movie.title,
                                   overview: movie.overview,
                                   posterImage: movie.posterImage,
                                   releaseDate: movie.releaseDate,
                                   rate: movie.rate))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = removeMovieFromDatabase(indexPath: indexPath)
        
        return UISwipeActionsConfiguration(actions: [remove])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let downloadedMovie = downloadedMovies[indexPath.row]
        guard let titleMovie = downloadedMovie.title else { return }
        
        sharedNetworkManager().getMovie(query: titleMovie) { [weak self] result in
            switch result {
            case .success(let movie):
                
                DispatchQueue.main.async {
                    let vc = MoviePreviewViewController()
                    vc.configure(with: MoviePreviewViewModel(title: titleMovie, overview: downloadedMovie.overview ?? "", movie: movie.id))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
