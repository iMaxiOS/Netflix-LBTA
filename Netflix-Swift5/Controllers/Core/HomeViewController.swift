//
//  HomeViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import UIKit

enum Sections: Int {
    case TrandingMovies = 0
    case TrandingTv = 1
    case Popular = 2
    case UpcomingMovies = 3
    case TopRating = 4
}

class HomeViewController: UIViewController {
    
    private let sectionTitles = ["Tranding Movies", "Tranding Tv", "Popular", "Upcoming Movies", "Top Rating"]
    
    private let tableFeedView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableFeedView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
        setupNavBar()
    }
}

private extension HomeViewController {
    func setup() {
        
        tableFeedView.dataSource = self
        tableFeedView.delegate = self
        tableFeedView.frame = view.bounds
        tableFeedView.backgroundColor = .clear
        tableFeedView.separatorColor = .clear
        tableFeedView.tableHeaderView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
    }
    
    func setupNavBar() {
        let image = UIImage(named: "logo-netflix")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        let personBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: nil)
        let playBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [personBarButtonItem, playBarButtonItem]
        navigationController?.navigationBar.tintColor = .label
    }
}

extension HomeViewController: FeedTableViewCellDelegate {
    func tapped(_ cell: FeedTableViewCell, model: MoviePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewViewController()
            vc.configure(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier,
                                                       for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrandingMovies.rawValue:
            sharedNetworkManager().getTrandingMovies { response in
                switch response {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription, APIError.failedTogetMovies)
                }
            }
        case Sections.TrandingTv.rawValue:
            sharedNetworkManager().getTrandingTvs { response in
                switch response {
                case .success(let tvs):
                    cell.configure(with: tvs)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            sharedNetworkManager().getPopular { response in
                switch response {
                case .success(let popular):
                    cell.configure(with: popular)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.UpcomingMovies.rawValue:
            sharedNetworkManager().getMoviesUpcoming { response in
                switch response {
                case .success(let moviesUpcoming):
                    cell.configure(with: moviesUpcoming)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRating.rawValue:
            sharedNetworkManager().getTopRated { response in
                switch response {
                case .success(let topRating):
                    cell.configure(with: topRating)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLatter()
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .label
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
