
import UIKit
import Kingfisher
import NVActivityIndicatorView
class NowPlayingMoreMoviesViewController: UIViewController {

    @IBOutlet weak var nowPlayingMoreMoviesCollectionView: UICollectionView!
    
    var nowPlayingMovies: NowPlayingMovieModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        self.setBackTitle(text: "Geri")

        self.showIndicator()
        getNowPlayingMovies()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
    
    func getNowPlayingMovies()
    {
        ServiceManager.shared.getNowPlayingMovies { (result) in
            switch result {
            case .success(let response):
                self.nowPlayingMovies = response
                self.setupCollectionView()
                self.stopIndicator()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func setupCollectionView() {
        self.nowPlayingMoreMoviesCollectionView.delegate = self
        self.nowPlayingMoreMoviesCollectionView.dataSource = self
        self.nowPlayingMoreMoviesCollectionView.register(UINib(nibName: "NowPlayingMoviesCollectionViewCell", bundle: nil),
                                             forCellWithReuseIdentifier: "NowPlayingMoviesCollectionViewCell")
        self.nowPlayingMoreMoviesCollectionView.showsHorizontalScrollIndicator = false
        self.nowPlayingMoreMoviesCollectionView.showsVerticalScrollIndicator = false
        setupNowPlayingMoreMoviesCollectionView()
    }
    func setupNowPlayingMoreMoviesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: (UIScreen.main.bounds.size.width-250)/3, bottom: 0, right: (UIScreen.main.bounds.size.width-250)/3)
        self.nowPlayingMoreMoviesCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
}

    extension NowPlayingMoreMoviesViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
    {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return nowPlayingMovies?.results?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: ((250)/2), height: (250+16))
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMoviesCollectionViewCell", for:indexPath) as! NowPlayingMoviesCollectionViewCell
            cell.NowPlayingLabel.text = nowPlayingMovies?.results?[indexPath.row].title ?? ""
            
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (nowPlayingMovies?.results?[indexPath.row].poster_path ?? ""))
            cell.NowPlayingImage.kf.setImage(with: imageUrl)
            return cell
           
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            let vc = MovieDetailViewController()
            vc.movieId = String(nowPlayingMovies?.results?[indexPath.row].id ?? 0)
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }



