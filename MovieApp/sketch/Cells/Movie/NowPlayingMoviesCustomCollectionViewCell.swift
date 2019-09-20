
import UIKit

class NowPlayingMoviesCustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var baseView: BaseView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.baseView.cornerrRadius
        self.layer.shadowColor = UIColor.yellow.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 20
    }
    

}
