//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 22.08.2023.
//

import UIKit
import SnapKit

class EpisodeCell: UITableViewCell {
    
    static let reuseId = "EpisodeCell"
    
    var name: String? {
        didSet {
            episodeName.text = name
        }
    }
    
    var number: String? {
        didSet {
            episodeNumber.text = number
            
        }
    }
    
    var air: String? {
        didSet {
            airDate.text = air
        }
    }
    
    private lazy var episodeName: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy17SemiBold
        label.textColor = .white
        return label
    }()
    
    private lazy var episodeNumber: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy13Medium
        label.textColor = Constants.Colors.accent1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var airDate: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy13Medium
        label.textColor = Constants.Colors.accent2
        label.textAlignment = .right
        return label
    }()
    
    private lazy var spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.secondBG
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var episodeNumberStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [episodeNumber, airDate])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [episodeName, episodeNumberStack])
        stack.axis = .vertical
        stack.spacing = 16
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
        
        spaceView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}

