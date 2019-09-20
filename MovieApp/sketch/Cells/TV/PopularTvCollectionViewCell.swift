

import UIKit

class PopularTvCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var averageAfterPoint: UILabel!
    @IBOutlet weak var averageBeforePoint: UILabel!
    @IBOutlet weak var topRatedTvName: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var topRatedTvImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.circleView.layer.cornerRadius = circleView.frame.size.width/2
        self.circleView.clipsToBounds = true
        self.topRatedTvImage.layer.cornerRadius = 7
        self.topRatedTvImage.clipsToBounds = true
        self.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width-32, height: 190)
    }

}
