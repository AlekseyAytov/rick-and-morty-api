//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 17.08.2023.
//

import UIKit
import SnapKit

class CharacterCell: UICollectionViewCell {
    
    static let reuseId = "CharacterCell"
        
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = Constants.Fonts.gilroy17SemiBold
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = Constants.Colors.secondBG
        layer.cornerRadius = 20
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(58)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(imageView.snp.bottom).offset(30)
            make.width.equalToSuperview().inset(8)
        }
    }
}
