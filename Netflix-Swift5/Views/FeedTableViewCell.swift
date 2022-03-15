//
//  FeedTableViewCell.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import UIKit

protocol FeedTableViewCellDelegate: AnyObject {
    func tapped(_ cell: FeedTableViewCell, model: MoviePreviewViewModel)
}

class FeedTableViewCell: UITableViewCell {
    
    static let identifier = "FeedTableViewCell"
    
    weak var delegate: FeedTableViewCellDelegate?
    
    private var movies: [Movie] = [Movie]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collection
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedTableViewCell {
    public func configure(with model: [Movie]) {
        self.movies = model
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

private extension FeedTableViewCell {
    
    func setup() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = contentView.bounds
    }
    
    func download(_ indexPath: IndexPath) -> UIAction {
        return UIAction(title: "Download", image: UIImage(systemName: "square.and.arrow.down")) { [weak self] action in
            guard let movie = self?.movies[indexPath.row] else { return }
            
            shareDataNSPersistentManager().downloadMovieWith(model: movie) { result in
                switch result {
                case .success():
                    print("Download movie success")
                    NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension FeedTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(item: movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
            
        let name = movies[indexPath.row]
        guard let movieName = name.title else { return }
        
        sharedNetworkManager().getMovie(query: movieName + " trailer") { response in
            switch response {
            case .success(let movie):
                let model = MoviePreviewViewModel(title: movieName,
                                                  overview: name.overview ?? "",
                                                  movie: movie.id)
                self.delegate?.tapped(self, model: model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let download = self.download(indexPath)
            return UIMenu(title: "", children: [download])
        }
    }
}

extension FeedTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 200)
    }
}
