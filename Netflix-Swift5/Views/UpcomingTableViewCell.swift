//
//  UpcomingTableViewCell.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 10.03.2022.
//

import UIKit
import SDWebImage

class UpcomingTableViewCell: UITableViewCell {

    static let identifier = "UpcomingTableViewCell"
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30)),
                        for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        addSubview(hStackView)
        hStackView.addArrangedSubview(movieImageView)
        hStackView.addArrangedSubview(titleLabel)
        hStackView.addArrangedSubview(playButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UpcomingTableViewCell {
    
    private func setupUI() {
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 130),
            
            playButton.widthAnchor.constraint(equalToConstant: 44),
            playButton.heightAnchor.constraint(equalToConstant: 44),
        
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hStackView.topAnchor.constraint(equalTo: topAnchor, constant: -10),
        ])
    }
    
    func configure(with model: Movie) {
        movieImageView.sd_setImage(with: model.urlImage)
        titleLabel.text = model.title ?? "Unknow"
    }
}
