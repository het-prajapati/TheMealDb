//
//  Extensions.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/15/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Instantiating
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    
    // Identifier for the Storyboard
    static var identifier: String {
        return String(describing: self)
    }
    
    // Adding Feedback i.e Haptics
    func mediumImpact() {
        let impactMedium = UIImpactFeedbackGenerator(style: .medium)
            impactMedium.impactOccurred()
    }

}
