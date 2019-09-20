

import Foundation
import UIKit
import NVActivityIndicatorView
extension UIViewController: NVActivityIndicatorViewable {
    
    func setBackTitle(text: String)
    {
        let backButton = UIBarButtonItem()
        backButton.title = text //in your case it will be empty or you can put the title of your choice
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    func showIndicator()
    {
        self.startAnimating(CGSize(width: 75, height: 75), message: "Yükleniyor", messageFont: nil, type: NVActivityIndicatorType.circleStrokeSpin)
    }
    
    func stopIndicator()
    {
        self.stopAnimating()
    }
    
    func embedInNC() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


