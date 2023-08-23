//
//  Constants.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 16.08.2023.
//

import UIKit

enum Constants {
    
    enum Fonts {
        static var gilroy13Medium: UIFont? {
            UIFont(name: "Gilroy-Medium", size: 13 )
        }
        
        static var gilroy16Medium: UIFont? {
            UIFont(name: "Gilroy-Medium", size: 16 )
        }
        
        static var gilroy17SemiBold: UIFont? {
            UIFont(name: "Gilroy-SemiBold", size: 17 )
        }
        
        static var gilroy28Bold: UIFont? {
            UIFont(name: "Gilroy-Bold", size: 28 )
        }
        
        static var gilroy22Bold: UIFont? {
            UIFont(name: "Gilroy-Bold", size: 22 )
        }
    }
    
    enum Colors {
        static var maindBG: UIColor? {
            UIColor(named: "MainBG")
        }
        
        static var secondBG: UIColor? {
            UIColor(named: "SecondBG")
        }
        
        static var accent1: UIColor? {
            UIColor(named: "Accent1")
        }

        static var accent2: UIColor? {
            UIColor(named: "Accent2")
        }

        static var accent3: UIColor? {
            UIColor(named: "Accent3")
        }
    }
    
    enum Image {
        static var rick: UIImage? {
            UIImage(named: "Rick")
        }
    }
}
