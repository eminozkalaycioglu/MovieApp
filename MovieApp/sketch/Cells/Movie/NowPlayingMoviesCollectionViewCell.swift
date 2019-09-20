
import UIKit

class NowPlayingMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var baseView: BaseView!
    
    @IBOutlet weak var NowPlayingLabel: UILabel!
    @IBOutlet weak var NowPlayingImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.baseView.cornerrRadius = 7
        self.baseView.shadowColor = UIColor.black
        self.baseView.shadowOpacity = 0.8
        self.baseView.shadowOffset = .zero
        self.baseView.shadowRadius = 10
        

    }

}
