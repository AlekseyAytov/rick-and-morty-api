//
//  HeaderforSection.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 21.08.2023.
//

import UIKit

class HeaderForSection: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        font = Constants.Fonts.gilroy17SemiBold
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
