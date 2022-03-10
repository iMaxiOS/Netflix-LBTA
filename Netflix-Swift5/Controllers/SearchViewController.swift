//
//  SearchViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension SearchViewController {
    func setupUI() {
//        view.addSubview(upcomingTableView)
//        upcomingTableView.frame = view.bounds
//        upcomingTableView.delegate = self
//        upcomingTableView.dataSource = self
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fetchUpcomingData() {
//        sharedNetworkManager().getMoviesUpcoming { [weak self] response in
//            switch response {
//            case .success(let moviesUpcoming):
//                self?.moviesUpcoming = moviesUpcoming
//
//                DispatchQueue.main.async {
//                    self?.upcomingTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}

//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return moviesUpcoming.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
//            return UITableViewCell()
//        }
//
//        cell.configure(with: moviesUpcoming[indexPath.row])
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//    }
//}
