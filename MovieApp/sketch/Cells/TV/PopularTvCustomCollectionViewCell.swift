

import UIKit

class PopularTvCustomCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width-32, height: 190)
    }

}
