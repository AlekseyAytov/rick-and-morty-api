//
//  LocationCell.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 22.08.2023.
//

import UIKit
import SnapKit

class LocationCell: UITableViewCell {
    
    static let reuseId = "LocationCell"
    
    var name: String? {
        didSet {
            locationName.text = name
        }
    }
    
    var type: String? {
        didSet {
            locationType.text = type
        }
    }
    
    private lazy var locationName: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy17SemiBold
        label.textColor = .white
        return label
    }()
    
    private lazy var locationType: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy13Medium
        label.textColor = Constants.Colors.accent1
        return label
    }()
    
    private lazy var locationIconView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = Constants.Colors.accent3
        view.image = UIImage(named: "Planet")
        view.contentMode = .center
        view.tintColor = .white
        view.layer.cornerRadius = 10
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()
    
    // внутренный view для выставления отступов
    private lazy var spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.secondBG
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var locationNameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationName, locationType])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationIconView, locationNameStack])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = Constants.Colors.maindBG
        contentView.addSubview(spaceView)
        spaceView.addSubview(mainStack)
    }
    
    private func setupConstraints() {
        locationIconView.snp.makeConstraints { make in
            make.size.equalTo(64)
        }
        
        spaceView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}

