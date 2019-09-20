

import UIKit
import Kingfisher
import WebKit
import Hero
class MoviesHomePageViewController: UIViewController {
    @IBOutlet weak var Top5MoviesCollectionView: UICollectionView!
    @IBOutlet weak var NowPlayingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var PopularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var graView: UIView!
    @IBOutlet weak var foundMoviesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foundMoviesTableViewsView: UIView!
    
    @IBOutlet weak var searchButton: UIButton!
    var foundMovies: FoundMoviesModel? = nil
    var popularMovies: MovieResponseModel? = nil
    var nowPlayingMovies: NowPlayingMovieModel? = nil
    var top5MovieIdArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.hideTableView(bool: true)
        

        self.hideKeyboardWhenTappedAround()
        self.getPopularMovies()
//        self.setupCollectionView()
        self.setupTableView()
        self.setupSearchBar()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false

        self.hideTableView(bool: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.hideTableView(bool: true)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if self.foundMoviesTableView.isHidden
        {
            return .default
        }
        else
        {
            return .lightContent
        }
    }
    
    func getSearchedMovies(word: String)
    {
        
        ServiceManager.shared.getSearchedMovies(word: word) { (result) in
            switch result {
            case .success(let response):
                self.foundMovies = response
                self.foundMoviesTableView.reloadData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
        
    }
    
    func getPopularMovies()
    {
        self.showIndicator()
        ServiceManager.shared.getPopularMovies { (result) in
            switch result {
            case .success(let response):
                self.popularMovies = response
                self.getNowPlayingMovies()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getNowPlayingMovies()
    {
        ServiceManager.shared.getNowPlayingMovies { (result) in
            switch result {
            case .success(let response):
                self.nowPlayingMovies = response
                self.setupCollectionView()
                self.PopularMoviesCollectionView.reloadData()
                self.NowPlayingMoviesCollectionView.reloadData()
                self.Top5MoviesCollectionView.reloadData()
                self.stopAnimating()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func hideTableView(bool:Bool)
    {
        self.foundMoviesTableView.isHidden = bool
        self.foundMoviesTableViewsView.isHidden = bool
        self.searchBar.isHidden = bool
        self.searchButton.isHidden = !bool
    }
    
    func setupSearchBar()
    {
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = false
        self.searchBar.setValue("İptal", forKey:"_cancelButtonText")
        self.searchBar.tintColor = .white

    }
    func setupTableView() {
        self.foundMoviesTableView.delegate=self
        self.foundMoviesTableView.dataSource=self
        self.foundMoviesTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        self.foundMoviesTableView.separatorStyle = .none
        
        self.foundMoviesTableView.reloadData()
        }
    
    func setupCollectionView() {
        self.Top5MoviesCollectionView.delegate = self
        self.Top5MoviesCollectionView.dataSource = self
        self.Top5MoviesCollectionView.register(UINib(nibName: "Top5MoviesCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "Top5MoviesCollectionViewCell")
        self.Top5MoviesCollectionView.showsHorizontalScrollIndicator = false
        self.Top5MoviesCollectionView.showsVerticalScrollIndicator = false
        
        self.NowPlayingMoviesCollectionView.delegate = self
        self.NowPlayingMoviesCollectionView.dataSource = self
        self.NowPlayingMoviesCollectionView.register(UINib(nibName: "NowPlayingMoviesCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "NowPlayingMoviesCollectionViewCell")
        self.NowPlayingMoviesCollectionView.register(UINib(nibName: "NowPlayingMoviesCustomCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "NowPlayingMoviesCustomCollectionViewCell")
        self.NowPlayingMoviesCollectionView.showsHorizontalScrollIndicator = false
        self.NowPlayingMoviesCollectionView.showsVerticalScrollIndicator = false
        
        self.PopularMoviesCollectionView.delegate = self
        self.PopularMoviesCollectionView.dataSource = self
        self.PopularMoviesCollectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "PopularMoviesCollectionViewCell")
        self.PopularMoviesCollectionView.register(UINib(nibName: "PopularMoviesCustomCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "PopularMoviesCustomCollectionViewCell")
        self.PopularMoviesCollectionView.showsHorizontalScrollIndicator = false
        self.PopularMoviesCollectionView.showsVerticalScrollIndicator = false
        
        self.setupTop5MoviesCollectionViewLayout()
        self.setupPopularMoviesCollectionView()
        self.setupNowPlayingMoviesCollectionView()

        
    }
    
    func setupTop5MoviesCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.Top5MoviesCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    func setupNowPlayingMoviesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.NowPlayingMoviesCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }

    func setupPopularMoviesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.PopularMoviesCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.hideTableView(bool: false)
        self.searchBar.becomeFirstResponder()
        self.searchBar.showsCancelButton = true
        self.searchBar.text = " "
        self.getSearchedMovies(word: " ")
        
        if self.foundMoviesTableView.isHidden
        {
            UIApplication.shared.statusBarView?.backgroundColor = .clear
            
        }
        else
        {
            UIApplication.shared.statusBarView?.backgroundColor = .black
            
        }
        self.setNeedsStatusBarAppearanceUpdate()

//        navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent;
//        UIApplication.shared.statusBarView?.backgroundColor = .black
        
      
    }
}

extension MoviesHomePageViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.Top5MoviesCollectionView
        {
            return 5
        }
        else if collectionView == self.NowPlayingMoviesCollectionView
        {
            return 6
        }
        else // PopularMoviesCollectionView
        {

            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.Top5MoviesCollectionView
        {
            return CGSize(width: 282, height: 148 )
        }
        else if collectionView == self.NowPlayingMoviesCollectionView
        {
           
            return CGSize(width: 125 , height: (250 + 32) )
        }
        else // PopularMoviesCollectionView
        {
            return CGSize(width: 125, height: ((400)/2) )
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.Top5MoviesCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Top5MoviesCollectionViewCell", for:indexPath) as! Top5MoviesCollectionViewCell
            self.top5MovieIdArray.append((popularMovies?.results?[(nowPlayingMovies?.results?.count ?? 0)-indexPath.row-1].id ?? 0))
            print("id = " + String(popularMovies?.results?[(nowPlayingMovies?.results?.count ?? 0)-indexPath.row-1].id ?? 0))
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (popularMovies?.results?[(nowPlayingMovies?.results?.count ?? 0)-indexPath.row-1].backdropPath ?? ""))
            cell.Top5MoviesImage.kf.setImage(with: imageUrl)
            return cell
        }
        else if collectionView == self.PopularMoviesCollectionView
        {
            if indexPath.row == 9
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCustomCollectionViewCell", for:indexPath) as! PopularMoviesCustomCollectionViewCell
              
                return cell
            }
            else
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for:indexPath) as! PopularMoviesCollectionViewCell
                

                let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (popularMovies?.results?[indexPath.row].posterPath ?? ""))
                cell.PopularMoviesImage.kf.setImage(with: imageUrl)
                
                let index = (popularMovies?.results?[indexPath.row].releaseDate ?? "XXXXXX").index((popularMovies?.results?[indexPath.row].releaseDate ?? "XXXXXX").startIndex, offsetBy: 4)
                let mySubstring = (popularMovies?.results?[indexPath.row].releaseDate ?? "XXXXXX").prefix(upTo: index) // Hello
                cell.PopularMoviesYear.text = (String(mySubstring))
                
                cell.PopularMoviesTitle.text = popularMovies?.results?[indexPath.row].title ?? ""
                
                let index2 = (String(popularMovies?.results?[indexPath.row].voteAverage ?? 0)).index(((String(popularMovies?.results?[indexPath.row].voteAverage ?? 0))).startIndex, offsetBy: 1)
                let mySubstring2 = ((String(popularMovies?.results?[indexPath.row].voteAverage ?? 0))).prefix(upTo: index2) // Hello
                cell.averageBeforePoint.text = String(mySubstring2)
                
                
                
                let text = String(popularMovies?.results?[indexPath.row].voteAverage ?? 0)
                let index3 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
                let afterPoint: Character = text[index3] //now we can index!
                
                cell.averageAfterPoint.text = "." + String(afterPoint)

                cell.layoutIfNeeded()
                cell.setGradientBackground(view: cell.graView)
                return cell
            }
            
            
        }
        else // NowPlaying
        {
            if indexPath.row == 5
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMoviesCustomCollectionViewCell", for:indexPath) as! NowPlayingMoviesCustomCollectionViewCell
                
                return cell
            }
            else
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMoviesCollectionViewCell", for:indexPath) as! NowPlayingMoviesCollectionViewCell
                cell.NowPlayingLabel.text = nowPlayingMovies?.results?[indexPath.row].title ?? ""
                
                
                let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (nowPlayingMovies?.results?[indexPath.row].poster_path ?? ""))
                cell.NowPlayingImage.kf.setImage(with: imageUrl)
                return cell
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.NowPlayingMoviesCollectionView
        {
            if indexPath.row == 5
            {
                navigationController?.pushViewController(NowPlayingMoreMoviesViewController(), animated: true)
            }
            else
            {
                let vc = MovieDetailViewController()
                vc.movieId = String(nowPlayingMovies?.results?[indexPath.row].id ?? 0)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    
        
        if collectionView == self.PopularMoviesCollectionView
        {
            if indexPath.row == 9
            {
                navigationController?.pushViewController(PopularMoreMoviesViewController(), animated: true)
            }
            else
            {
                let vc = MovieDetailViewController()
                vc.movieId = String(popularMovies?.results?[indexPath.row].id ?? 0)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        if collectionView == self.Top5MoviesCollectionView
        {
            let vc = MovieDetailViewController()
            vc.movieId = String(self.top5MovieIdArray[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
}


extension MoviesHomePageViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foundMovies?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath)  as! SearchResultTableViewCell
        cell.foundMovieName.text = foundMovies?.results?[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.movieId = String(self.foundMovies?.results?[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension MoviesHomePageViewController: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.showsCancelButton = true
        self.hideTableView(bool: false)
        print(" CVB DidBeginEditing")
        

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("CVB textDidChange")
        self.getSearchedMovies(word: (self.searchBar.text ?? ""))
        

    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         print("CVB DidEndEditing")
        if self.searchBar.text == "" || self.searchBar.text == " "
        {
            self.searchBar.showsCancelButton = false
            self.hideTableView(bool: true)
        }
        else
        {
            self.searchBar.showsCancelButton = true
            self.hideTableView(bool: false)
        }
        
        if self.foundMoviesTableView.isHidden
        {
            UIApplication.shared.statusBarView?.backgroundColor = .clear
            
        }
        else
        {
            UIApplication.shared.statusBarView?.backgroundColor = .black
            
        }
        self.setNeedsStatusBarAppearanceUpdate()
        
//        searchBar.text = ""
//        self.getSearchedMovies(word: " ")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("CVB CancelButtonClicked")
        self.searchBar.showsCancelButton = false
        self.hideTableView(bool: true)
        

//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//        self.foundMoviesTableView.resignFirstResponder()
//        self.searchBar.showsCancelButton = false
//        self.getSearchedMovies(word: " ")
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}
