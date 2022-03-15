//
//  SettingTableViewCell.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 15.03.2022.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    private let containerViewWithAlpha: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .label.withAlphaComponent(0.05)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowRightImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .label
        image.image = UIImage(systemName: "chevron.compact.right")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 16))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

extension SettingTableViewCell {
    func configure(item: Constants.SectionSettings) {
        iconImageView.image = item.image
        titleLabel.text = item.title
    }
}

private extension SettingTableViewCell {
    func setupUI() {
        selectionStyle = .none
        addSubview(containerViewWithAlpha)
        containerViewWithAlpha.addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(arrowRightImageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerViewWithAlpha.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerViewWithAlpha.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerViewWithAlpha.widthAnchor.constraint(equalToConstant: 40),
            containerViewWithAlpha.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerViewWithAlpha.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            arrowRightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            arrowRightImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            arrowRightImageView.widthAnchor.constraint(equalToConstant: 10),
            arrowRightImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            iconImageView.centerXAnchor.constraint(equalTo: containerViewWithAlpha.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerViewWithAlpha.centerYAnchor)
        ])
    }
}
