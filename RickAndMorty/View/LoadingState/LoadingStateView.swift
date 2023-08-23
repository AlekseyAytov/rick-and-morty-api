//
//  LoadingStateView.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 18.08.2023.
//

import UIKit

// view для отображения состояния загрузки
class LoadingStateView: UIView {
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        return indicator
    }()
    
    override var center: CGPoint {
        didSet {
            indicator.center = CGPoint(x: center.x, y: 100)
        }
    }
    
    init() {
        super.init(frame: .zero)
        addSubview(indicator)
        indicator.startAnimating()
        backgroundColor = Constants.Colors.maindBG
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
