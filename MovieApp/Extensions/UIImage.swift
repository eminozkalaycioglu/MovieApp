
import UIKit
import Foundation
import Kingfisher

extension UIImageView {
    func setImageURL(URLString: String)
    {
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (URLString))
        self.kf.setImage(with: imageUrl)
    }
    
    
    
    
}
