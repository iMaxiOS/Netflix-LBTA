//
//  HeroHeaderUIView.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 09.03.2022.
//

import UIKit

final class HeroHeaderUIView: UIView {
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.tintColor = .label
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Download", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.tintColor = .label
        return button
    }()
    
    private let heroImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "house"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            playButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            
            downloadButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        addConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
