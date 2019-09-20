

import UIKit
import NVActivityIndicatorView
class PopularMoreMoviesViewController: UIViewController {
    @IBOutlet weak var popularMoreMoviesCollectionView: UICollectionView!
    
    var popularMovies: MovieResponseModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        self.setBackTitle(text: "Geri")
        self.showIndicator()
        self.getPopularMovies()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func getPopularMovies()
    {
        ServiceManager.shared.getPopularMovies { (result) in
            switch result {
            case .success(let response):
                self.popularMovies = response
                self.setupCollectionView()
                self.stopIndicator()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func setupCollectionView() {
        self.popularMoreMoviesCollectionView.delegate = self
        self.popularMoreMoviesCollectionView.dataSource = self
        self.popularMoreMoviesCollectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil),
                                                         forCellWithReuseIdentifier: "PopularMoviesCollectionViewCell")
        self.popularMoreMoviesCollectionView.showsHorizontalScrollIndicator = false
        self.popularMoreMoviesCollectionView.showsVerticalScrollIndicator = false
        setupNowPlayingMoreMoviesCollectionView()
    }
    func setupNowPlayingMoreMoviesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: (UIScreen.main.bounds.size.width-250)/3, bottom: 0, right: (UIScreen.main.bounds.size.width-250)/3)
        self.popularMoreMoviesCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }

}

extension PopularMoreMoviesViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((250)/2), height: (200+16))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for:indexPath) as! PopularMoviesCollectionViewCell
        cell.PopularMoviesTitle.text = popularMovies?.results?[indexPath.row].title ?? ""
        
        
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (popularMovies?.results?[indexPath.row].posterPath ?? ""))
        cell.PopularMoviesImage.kf.setImage(with: imageUrl)
        
        let index2 = (String(popularMovies?.results?[indexPath.row].voteAverage ?? 0)).index(((String(popularMovies?.results?[indexPath.row].voteAverage ?? 0))).startIndex, offsetBy: 1)
        let mySubstring2 = ((String(popularMovies?.results?[indexPath.row].voteAverage ?? 0))).prefix(upTo: index2) // Hello
        cell.averageBeforePoint.text = String(mySubstring2)
        
        let text = String(popularMovies?.results?[indexPath.row].voteAverage ?? 0)
        let index3 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
        let afterPoint: Character = text[index3] //now we can index!
        cell.averageAfterPoint.text = "." + String(afterPoint)
        
        let index = (popularMovies?.results?[indexPath.row].releaseDate ?? "XXXXXX").index((popularMovies?.results?[indexPath.row].releaseDate ?? "XXXXXX").startIndex, offsetBy: 4)
        let mySubstring = (popularMovies?.results?[indexPath.row].releaseDate ?? "XXXXXX").prefix(upTo: index) // Hello
        cell.PopularMoviesYear.text = String(mySubstring)
        
        cell.layoutIfNeeded()
        cell.setGradientBackground(view: cell.graView)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let vc = MovieDetailViewController()
        vc.movieId = String(popularMovies?.results?[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
