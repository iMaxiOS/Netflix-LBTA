//
//  HomeViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import UIKit

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
        
        fetchData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
        setupNavBar()
    }
}

private extension HomeViewController {
    
    func fetchData() {
        sharedNetworkManager().getTrandingMovies { response in
            switch response {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        sharedNetworkManager().getTrandingTvs { response in
            switch response {
            case .success(let tvs):
                print(tvs)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        sharedNetworkManager().getMoviesUpcoming { response in
            switch response {
            case .success(let moviesUpcoming):
                print(moviesUpcoming)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        sharedNetworkManager().getPopular { response in
            switch response {
            case .success(let popular):
                print(popular)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        sharedNetworkManager().getTopRated { response in
            switch response {
            case .success(let popular):
                print(popular)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    func setup() {
        tableFeedView.dataSource = self
        tableFeedView.delegate = self
        tableFeedView.frame = view.bounds
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
