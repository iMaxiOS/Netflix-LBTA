//
//  SearchResultViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 10.03.2022.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    private var movies: [Movie] = [Movie]()
    
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
}
