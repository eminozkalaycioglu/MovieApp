

import Foundation
import UIKit
extension UIView {
    func setGradientBackground(view: UIView) {
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at:0)
        view.alpha = 1
    }
    
    
    
    
    
    
}
