//
//  MainViewNavigationTitle.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 21.08.2023.
//

import UIKit

class MainViewNavigationTitle: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        font = Constants.Fonts.gilroy28Bold
        self.text = text
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
