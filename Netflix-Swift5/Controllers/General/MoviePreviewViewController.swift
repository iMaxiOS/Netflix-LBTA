//
//  MoviePreviewViewController.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 11.03.2022.
//

import UIKit
import WebKit

class MoviePreviewViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Harry potter"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Harry potter sdf wf sdf. sdf sdf jsaf dawfasdkf asdf asd fasdf asdf asdf asdf adf asdf asdf asdf s"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
        setupConstraints()
    }
}

extension MoviePreviewViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 95),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 15),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configure(with model: MoviePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.movie.videoId)") else { return }
        
        webView.load(URLRequest(url: url))
    }
}
