//
//  InfoCell.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 19.08.2023.
//

import UIKit
import SnapKit

class InfoCell: UITableViewCell {
    
    static let reuseId = "InfoCell"
    
    var species: String? {
        didSet {
            speciesInfo.text = species
        }
    }
    
    var type: String? {
        didSet {
            if type == "" {
                typeInfoLabel.text = "None"
            } else {
                typeInfoLabel.text = type
            }
        }
    }
    
    var gender: String? {
        didSet {
            genderInfo.text = gender
        }
    }
    
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy16Medium
        label.textColor = Constants.Colors.accent2
        label.text = "Species"
        return label
    }()
    
    private lazy var speciesInfo: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy16Medium
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var speciesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [speciesLabel, speciesInfo])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy16Medium
        label.textColor = Constants.Colors.accent2
        label.text = "Type"
        return label
    }()
    
    private lazy var typeInfoLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy16Medium
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var typeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [typeLabel, typeInfoLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy16Medium
        label.textColor = Constants.Colors.accent2
        label.text = "Gender"
        return label
    }()
    
    private lazy var genderInfo: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.gilroy16Medium
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var genderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [genderLabel, genderInfo])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [speciesStack, typeStack, genderStack])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    // внутренный view для выставления отступов
    private lazy var spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.secondBG
        view.layer.cornerRadius = 15
        return view
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
