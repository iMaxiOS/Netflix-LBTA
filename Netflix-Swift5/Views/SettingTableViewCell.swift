//
//  SettingTableViewCell.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 15.03.2022.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    private let baseHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let containerViewWithAlpha: UIView = {
        let view = UIView()
        view.backgroundColor = .label.withAlphaComponent(0.05)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let arrowRightImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.compact.right")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16))
        image.tintColor = .label
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
        addSubview(baseHorizontalStackView)
        baseHorizontalStackView.addArrangedSubview(containerViewWithAlpha)
        containerViewWithAlpha.addSubview(iconImageView)
        baseHorizontalStackView.addArrangedSubview(titleLabel)
        baseHorizontalStackView.addArrangedSubview(arrowRightImageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            baseHorizontalStackView.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            baseHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            baseHorizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            baseHorizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            containerViewWithAlpha.widthAnchor.constraint(equalToConstant: 40),
            containerViewWithAlpha.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.centerXAnchor.constraint(equalTo: containerViewWithAlpha.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerViewWithAlpha.centerYAnchor)
        ])
    }
}
