
import UIKit


class PopularMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var baseView: BaseView!
    @IBOutlet weak var PopularMoviesImage: UIImageView!
    @IBOutlet weak var averageBeforePoint: UILabel!
    
    @IBOutlet weak var graView: UIView!
    @IBOutlet weak var averageAfterPoint: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var PopularMoviesYear: UILabel!
    @IBOutlet weak var PopularMoviesTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.baseView.cornerrRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        
        self.circleView.layer.cornerRadius = circleView.frame.size.width/2
        self.circleView.clipsToBounds = true
  
    }
    

}

