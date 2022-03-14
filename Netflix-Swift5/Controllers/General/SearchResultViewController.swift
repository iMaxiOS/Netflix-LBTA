//
//  SearchResultViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 10.03.2022.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewControllerDidTapped(model: MoviePreviewViewModel)
}

class SearchResultViewController: UIViewController {
    
    private var movies: [Movie] = [Movie]()
     
    weak var delegate: SearchResultViewControllerDelegate?
    
    private let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 8, height: 200)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
}

extension SearchResultViewController {
    func configure(with movies: [Movie]) {
        self.movies = movies
        
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
        }
    }
}

private extension SearchResultViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchCollectionView)
        searchCollectionView.frame = view.bounds
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(item: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchCollectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        guard let titleMovie = movie.title else { return }
        
        sharedNetworkManager().getMovie(query: titleMovie) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieResponse):
                self.delegate?.searchResultViewControllerDidTapped(model: MoviePreviewViewModel(title: titleMovie, overview: movie.overview ?? "", movie: movieResponse.id))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
