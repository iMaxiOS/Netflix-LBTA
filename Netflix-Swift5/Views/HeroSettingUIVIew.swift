//
//  HeroSettingUIVIew.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 15.03.2022.
//

import UIKit

class HeroSettingUIVIew: UIView {
    
    private let baseContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label.withAlphaComponent(0.05)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let verticalStackVeiw: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let photoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "photo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Brad Pitt"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .label
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "0x4e327480x4e3347594tx97"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.7490196078, alpha: 1)
        return label
    }()
    
    private let containerViewWithColor: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Edit"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeroSettingUIVIew {
    func setupUI() {
        addSubview(baseContainerView)
        containerViewWithColor.addSubview(iconImageView)
        baseContainerView.addSubview(photoImageView)
        baseContainerView.addSubview(verticalStackVeiw)
        verticalStackVeiw.addArrangedSubview(nameLabel)
        verticalStackVeiw.addArrangedSubview(addressLabel)
        baseContainerView.addSubview(containerViewWithColor)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            baseContainerView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            baseContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            baseContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            baseContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            photoImageView.leadingAnchor.constraint(equalTo: baseContainerView.leadingAnchor, constant: 20),
            photoImageView.centerYAnchor.constraint(equalTo: baseContainerView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 64),
            photoImageView.heightAnchor.constraint(equalToConstant: 64),

            verticalStackVeiw.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            verticalStackVeiw.centerYAnchor.constraint(equalTo: baseContainerView.centerYAnchor),

            containerViewWithColor.trailingAnchor.constraint(equalTo: baseContainerView.trailingAnchor, constant: -20),
            containerViewWithColor.leadingAnchor.constraint(equalTo: verticalStackVeiw.trailingAnchor, constant: 16),
            containerViewWithColor.centerYAnchor.constraint(equalTo: baseContainerView.centerYAnchor),
            containerViewWithColor.widthAnchor.constraint(equalToConstant: 44),
            containerViewWithColor.heightAnchor.constraint(equalToConstant: 44),
  
            iconImageView.centerYAnchor.constraint(equalTo: containerViewWithColor.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: containerViewWithColor.centerXAnchor),
        ])
    }
}
