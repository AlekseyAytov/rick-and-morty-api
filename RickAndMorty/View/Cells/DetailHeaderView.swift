//
//  DetailHeaderView.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 19.08.2023.
//

import UIKit
import SnapKit

class DetailHeaderView: UIView{
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var status: String? {
        didSet {
            statusLabel.text = status
        }
    }
    
    lazy private var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Fonts.gilroy22Bold
        return label
    }()
    
    lazy private var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.accent1
        label.font = Constants.Fonts.gilroy16Medium
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 250))
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = Constants.Colors.maindBG
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(statusLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(148)
            make.width.equalTo(148)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(25)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
    }
}

