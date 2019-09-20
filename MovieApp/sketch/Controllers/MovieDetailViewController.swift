

import UIKit
import Cosmos
import WebKit
import YoutubePlayerView
class MovieDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var movieVideoo: YoutubePlayerView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieAverageBeforePoint: UILabel!
    @IBOutlet weak var movieAverageAfterPoint: UILabel!
    @IBOutlet weak var movieStarRating: CosmosView!
    @IBOutlet weak var movieOverview: UILabel!
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var myView: UIView!
    @IBOutlet weak var testScroll: UIScrollView!
    
//    Movie
    var selectedMoviesActors: SelectedMoviesActorsModel? = nil
    var selectedMoviesVideo: SelectedMoviesVideoModel? = nil
    var movieDetails: SelectedMovieModel? = nil
    var movieId: String?
    
//    TV
    var selectedTVActors: SelectedTVActorsModel? = nil
    var selectedTVVideo: SelectedTVVideoModel? = nil
    var TVDetails: SelectedTVDetailModel? = nil
    var TVId: String?
    
    var lastContentOffset: CGFloat = CGFloat(Int.max)
    var isPlaying: Bool = true
    let playerVars: [String: Any] = [
        "controls": 0,
        "playsinline": 0,
        "rel": 0,
        "disablekb": 1,
        "autoplay": 0
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setBackTitle(text: "Geri")
        self.showIndicator()
        self.mainView.alpha = 0
        self.testScroll.delegate = self
        

        self.playButton.isHidden = true
        self.movieVideoo.delegate = self
        if movieId != nil
        {
            self.getSelectedMovie(movieId: movieId ?? "")
            
        }
        if TVId != nil
        {
            self.getSelectedTV(TVId: TVId ?? "")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        self.setNavBar()
    }
    
  
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
   
    

    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if (self.lastContentOffset > scrollView.contentOffset.y)
        {
            if scrollView.contentOffset.y <= 65
            {
                navigationController?.setNavigationBarHidden(false, animated: false)
            }
        }
        else if (self.lastContentOffset < scrollView.contentOffset.y)
        {
            if scrollView.contentOffset.y > 65
            {
                navigationController?.setNavigationBarHidden(true, animated: false)
            }
        }
        
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        if self.isPlaying
        {
            self.movieVideoo.pause()
        }
        else
        {
            self.movieVideoo.play()
        }
        
    }
   
    func setupCastCollectionView() {
        self.castCollectionView.delegate = self
        self.castCollectionView.dataSource = self
        self.castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil),
                                            forCellWithReuseIdentifier: "CastCollectionViewCell")
        self.castCollectionView.showsHorizontalScrollIndicator = false
        self.castCollectionView.showsVerticalScrollIndicator = false
        self.setupCastCollectionViewLayout()
    }
    
    func setupCastCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        castCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func setNavBar()
    {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        UIApplication.shared.statusBarView?.backgroundColor = .white
        self.scrollView.contentInset = UIEdgeInsets(top: -((navigationController?.navigationBar.frame.size.height ?? 0) + (UIApplication.shared.statusBarFrame.height)), left: 0, bottom: 0, right: 0)
    }
    
    func getSelectedMoviesActors(movieId: String)
    {
        ServiceManager.shared.getSelectedMoviesActors(movieID: movieId,completion: { (result) in
            switch result {
            case .success(let response):
                self.selectedMoviesActors = response
                self.setMovieDetail()
                self.setupCastCollectionView()
                self.mainView.alpha = 1
                self.stopIndicator()
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func getSelectedMovie(movieId: String) {
        ServiceManager.shared.getSelectedMovie(movieId: movieId,completion: { (result) in
            switch result {
            case .success(let response):
                self.movieDetails = response
               
                self.getSelectedMoviesVideo(movieId: movieId)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func getSelectedMoviesVideo(movieId:String)
    {
        ServiceManager.shared.getSelectedMoviesVideo(movieID: movieId, completion: { (result) in
            switch result {
            case .success(let response):
                self.selectedMoviesVideo = response
                self.getSelectedMoviesActors(movieId: movieId)

            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
        
    }
    
    func getSelectedTV(TVId: String) {
        ServiceManager.shared.getSelectedTVDetail(TVId: TVId,completion: { (result) in
            switch result {
            case .success(let response):
                self.TVDetails = response
                self.getSelectedTVActors(TVId: TVId)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func getSelectedTVActors(TVId: String)
    {
        ServiceManager.shared.getSelectedTVActors(TVId: TVId,completion: { (result) in
            switch result {
            case .success(let response):
                self.selectedTVActors = response
                self.getSelectedTVVideo(TVId: TVId)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func getSelectedTVVideo(TVId:String)
    {
        ServiceManager.shared.getSelectedTVVideo(TVId: TVId, completion: { (result) in
            switch result {
            case .success(let response):
                self.selectedTVVideo = response
                self.setTVDetail()
                self.setupCastCollectionView()
                self.mainView.alpha = 1
                self.stopAnimating()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func setMovieDetail()
    {
        
        if self.selectedMoviesVideo?.results?.count != 0
        {
            self.movieVideoo.loadWithVideoId(selectedMoviesVideo?.results?[0].key ?? "", with: self.playerVars)
        }
        
        else 
        {
            self.movieVideoo.isHidden = true
            navigationController?.navigationBar.tintColor = .black

        }
        
        self.moviePoster.layer.cornerRadius = 7
        
        self.moviePoster.setImageURL(URLString: self.movieDetails?.posterPath ?? "")
        var genres: String = ""
        
        for item in 0..<(self.movieDetails?.genres?.count ?? 0)
        {
            if item == 0 {
                genres = (genres) + (self.movieDetails?.genres[item].name ?? "")
            }
            else {
                genres = (genres) + ", " + (self.movieDetails?.genres[item].name ?? "")
            }
            
        }
        
        self.movieGenres.text = genres
        
        let index = (String(movieDetails?.voteAverage ?? 0)).index(((String(movieDetails?.voteAverage ?? 0))).startIndex, offsetBy: 1)
        let mySubstring = ((String(movieDetails?.voteAverage ?? 0))).prefix(upTo: index) // Hello
        self.movieAverageBeforePoint.text = String(mySubstring)
        
        let text = String(movieDetails?.voteAverage ?? 0)
        let index2 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
        let afterPoint: Character = text[index2] //now we can index!
        self.movieAverageAfterPoint.text = "." + String(afterPoint)
        
        self.movieStarRating.rating = (Double(self.movieDetails?.voteAverage ?? 0.0))/2
        
        self.movieOverview.text = movieDetails?.overview ?? ""
    
    }
    
    func setTVDetail()
    {
        if self.selectedTVVideo?.results?.count != 0 {
            
            self.movieVideoo.loadWithVideoId(selectedTVVideo?.results?[0].key ?? "", with: self.playerVars)
        }
            
        else
        {
            self.movieVideoo.isHidden = true
        }
        
        self.moviePoster.layer.cornerRadius = 7
        
        self.moviePoster.setImageURL(URLString: self.TVDetails?.poster_path ?? "")
        var genres: String = ""
        
        for item in 0..<(self.TVDetails?.genres?.count ?? 0)
        {
            if item == 0 {
                genres = (genres) + (self.TVDetails?.genres?[item].name ?? "")
            }
            else {
                genres = (genres) + ", " + (self.TVDetails?.genres?[item].name ?? "")
            }
            
        }
        
        self.movieGenres.text = genres
        
        let index = (String(TVDetails?.vote_average ?? 0)).index(((String(movieDetails?.voteAverage ?? 0))).startIndex, offsetBy: 1)
        let mySubstring = ((String(TVDetails?.vote_average ?? 0))).prefix(upTo: index) // Hello
        self.movieAverageBeforePoint.text = String(mySubstring)
        
        let text = String(TVDetails?.vote_average ?? 0)
        let index2 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
        let afterPoint: Character = text[index2] //now we can index!
        self.movieAverageAfterPoint.text = "." + String(afterPoint)
        
        self.movieStarRating.rating = (Double(self.TVDetails?.vote_average ?? 0.0))/2
        
        self.movieOverview.text = TVDetails?.overview ?? ""
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        if self.likeButton.backgroundImage(for: UIControl.State.normal) == UIImage(named: "unselectedLike")
        {
            self.likeButton.setBackgroundImage(UIImage(named: "selectedLike"), for: UIControl.State.normal)
        }
        else
        {
            self.likeButton.setBackgroundImage(UIImage(named: "unselectedLike"), for: UIControl.State.normal)
        }
            
    }
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        if self.commentButton.backgroundImage(for: UIControl.State.normal) == UIImage(named: "unselectedComment")
        {
            self.commentButton.setBackgroundImage(UIImage(named: "selectedComment"), for: UIControl.State.normal)
        }
        else
        {
            self.commentButton.setBackgroundImage(UIImage(named: "unselectedComment"), for: UIControl.State.normal)
        }
        
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
        if self.favButton.backgroundImage(for: UIControl.State.normal) ==  UIImage(named: "selectedFavorites")
        {
            self.favButton.setBackgroundImage(UIImage(named: "unselectedFavorites"), for: UIControl.State.normal)
        }
        else
        {
            self.favButton.setBackgroundImage(UIImage(named: "selectedFavorites"), for: UIControl.State.normal)
        }
        
    }
    
}
extension MovieDetailViewController: YoutubePlayerViewDelegate {
    
    
    func playerView(_ playerView: YoutubePlayerView, didChangedToState state: YoutubePlayerState) {
        if state.rawValue == "3" || state.rawValue == "-1"
        {
            self.playButton.isHidden = true
        }
        else
        {
            self.playButton.isHidden = false
        }
        
        if state.rawValue == "2"
        {
            self.isPlaying = false
        }
        if state.rawValue == "1"
        {
            self.isPlaying = true
        }
        
        
    }
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.movieId != nil
        {
            return (selectedMoviesActors?.cast?.count ?? 0) + (selectedMoviesActors?.crew?.count ?? 0)
        }
        else
        {
            return (selectedTVActors?.cast?.count ?? 0) + (selectedTVActors?.crew?.count ?? 0)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 116, height: 232 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for:indexPath) as! CastCollectionViewCell
        if self.movieId != nil
        {
            if (selectedMoviesActors?.cast?.count ?? 0) > indexPath.row
            {
                cell.actorName.text = selectedMoviesActors?.cast?[indexPath.row].name
                
                if selectedMoviesActors?.cast?[indexPath.row].profilePath != nil
                {
                    cell.actorImage.contentMode = UIView.ContentMode.scaleAspectFill
                    
                    cell.actorImage.image = nil
                    cell.actorImage.setImageURL(URLString: (selectedMoviesActors?.cast?[indexPath.row].profilePath ?? "/"))
                }
                else
                {
                    cell.actorImage.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.actorImage.image = UIImage(named: "noImage")
                    
                }
            }
            else
            {
                cell.actorName.text = selectedMoviesActors?.crew?[indexPath.row-(selectedMoviesActors?.cast?.count ?? 0)].name
                
                if selectedMoviesActors?.crew?[indexPath.row-(selectedMoviesActors?.cast?.count ?? 0)].profilePath != nil
                {
                    cell.actorImage.contentMode = UIView.ContentMode.scaleAspectFill
                    cell.actorImage.image = nil
                    cell.actorImage.setImageURL(URLString: (selectedMoviesActors?.crew?[indexPath.row-(selectedMoviesActors?.cast?.count ?? 0)].profilePath ?? "/"))
                }
                else
                {
                    cell.actorImage.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.actorImage.image = UIImage(named: "noImage")
                }
            }
            
            return cell
        }
        
        else
        {
            if (selectedTVActors?.cast?.count ?? 0) > indexPath.row
            {
                cell.actorName.text = selectedTVActors?.cast?[indexPath.row].name
                
                if selectedTVActors?.cast?[indexPath.row].profile_path != nil
                {
                    cell.actorImage.contentMode = UIView.ContentMode.scaleAspectFill
                    
                    cell.actorImage.image = nil
                    cell.actorImage.setImageURL(URLString: (selectedTVActors?.cast?[indexPath.row].profile_path ?? "/"))
                }
                else
                {
                    cell.actorImage.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.actorImage.image = UIImage(named: "noImage")
                    
                }
            }
            else
            {
                cell.actorName.text = selectedTVActors?.crew?[indexPath.row-(selectedTVActors?.cast?.count ?? 0)].name
                
                if selectedTVActors?.crew?[indexPath.row-(selectedTVActors?.cast?.count ?? 0)].profile_path != nil
                {
                    cell.actorImage.contentMode = UIView.ContentMode.scaleAspectFill
                    cell.actorImage.image = nil
                    cell.actorImage.setImageURL(URLString: (selectedTVActors?.crew?[indexPath.row-(selectedTVActors?.cast?.count ?? 0)].profile_path ?? "/"))
                }
                else
                {
                    cell.actorImage.contentMode = UIView.ContentMode.scaleAspectFit
                    cell.actorImage.image = UIImage(named: "noImage")
                }
            }
            
            return cell
        }
        
    }
    

}
