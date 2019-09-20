
import UIKit
class TVHomePageViewController: UIViewController {

    @IBOutlet weak var PopularTvView: UIView!
    @IBOutlet weak var PopularTvCollectionView: UICollectionView!
    @IBOutlet weak var TopRatedTvCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foundTVTableView: UITableView!
    @IBOutlet weak var foundTVTableViewsView: UIView!
    
    var topRatedTvModel: TopRatedTVModel? = nil
    var popularTvModel: PopularTVModel? = nil
    var foundTVModel:FoundTVModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.hideTableView(bool: true)
        self.hideKeyboardWhenTappedAround()
        self.setupTableView()
        self.setupSearchBar()
        
        
        self.showIndicator()
        self.getPopularTv()

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
        if self.foundTVTableView.isHidden
        {
            return .default
        }
        else
        {
            return .lightContent
        }
    }
    
    func getSearchedTV(word: String)
    {
        ServiceManager.shared.getSearchedTV(word: word) { (result) in
            switch result {
            case .success(let response):
                self.foundTVModel = response
                self.foundTVTableView.reloadData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    func getTopRatedTv()
    {
        ServiceManager.shared.getTopRatedTV { (result) in
            switch result {
            case .success(let response):
                self.topRatedTvModel = response
                self.setupCollectionView()
                self.stopIndicator()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    func getPopularTv()
    {
        ServiceManager.shared.getPopularTV { (result) in
            switch result {
            case .success(let response):
                self.popularTvModel = response
                self.getTopRatedTv()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    func hideTableView(bool:Bool)
    {
        self.foundTVTableView.isHidden = bool
        self.foundTVTableViewsView.isHidden = bool
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
        self.foundTVTableView.delegate=self
        self.foundTVTableView.dataSource=self
        self.foundTVTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
        self.foundTVTableView.separatorStyle = .none
        
        self.foundTVTableView.reloadData()
    }
    
    
    func setupCollectionView() {
        self.TopRatedTvCollectionView.delegate = self
        self.TopRatedTvCollectionView.dataSource = self
        self.TopRatedTvCollectionView.register(UINib(nibName: "NowPlayingMoviesCustomCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "NowPlayingMoviesCustomCollectionViewCell")
        self.TopRatedTvCollectionView.register(UINib(nibName: "NowPlayingMoviesCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "NowPlayingMoviesCollectionViewCell")
        
        
        self.PopularTvCollectionView.delegate = self
        self.PopularTvCollectionView.dataSource = self
        self.PopularTvCollectionView.register(UINib(nibName: "PopularTvCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "PopularTvCollectionViewCell")
        self.PopularTvCollectionView.register(UINib(nibName: "PopularTvCustomCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "PopularTvCustomCollectionViewCell")

        self.setupTopRatedTvCollectionViewLayout()
        self.setupPopularTvCollectionViewLayout()
    }
    
    func setupTopRatedTvCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.TopRatedTvCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    func setupPopularTvCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.PopularTvCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        self.hideTableView(bool: false)
        self.searchBar.becomeFirstResponder()
        self.searchBar.showsCancelButton = true
        self.searchBar.text = " "
        self.getSearchedTV(word: " ")
        
        if self.foundTVTableView.isHidden
        {
            UIApplication.shared.statusBarView?.backgroundColor = .clear
        }
        else
        {
            UIApplication.shared.statusBarView?.backgroundColor = .black
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
}

extension TVHomePageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.TopRatedTvCollectionView
        {
            return 6
        }
        else
        {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.TopRatedTvCollectionView
        {
            if indexPath.row == 5
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMoviesCustomCollectionViewCell", for:indexPath) as! NowPlayingMoviesCustomCollectionViewCell
                
                return cell
            }
            else
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMoviesCollectionViewCell", for:indexPath) as! NowPlayingMoviesCollectionViewCell
                cell.NowPlayingLabel.text = topRatedTvModel?.results?[indexPath.row].name ?? ""
                
                
                let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (topRatedTvModel?.results?[indexPath.row].poster_path ?? ""))
                cell.NowPlayingImage.kf.setImage(with: imageUrl)
                return cell
            }
        }
        else
        {
            if indexPath.row == 9
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularTvCustomCollectionViewCell", for:indexPath) as! PopularTvCustomCollectionViewCell
                
                return cell
            }
            else
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularTvCollectionViewCell", for:indexPath) as! PopularTvCollectionViewCell
                
                cell.topRatedTvImage.setImageURL(URLString: (popularTvModel?.results?[indexPath.row].backdrop_path ?? "/"))
                
                cell.topRatedTvName.text =  (popularTvModel?.results?[indexPath.row].name ?? "Bilinmiyor")
                
                let index2 = (String(popularTvModel?.results?[indexPath.row].vote_average ?? 0)).index(((String(popularTvModel?.results?[indexPath.row].vote_average ?? 0))).startIndex, offsetBy: 1)
                let mySubstring2 = ((String(popularTvModel?.results?[indexPath.row].vote_average ?? 0))).prefix(upTo: index2) // Hello
                cell.averageBeforePoint.text = String(mySubstring2)
                
                
                
                let text = String(popularTvModel?.results?[indexPath.row].vote_average ?? 0)
                let index3 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
                let afterPoint: Character = text[index3] //now we can index!
                
                cell.averageAfterPoint.text = "." + String(afterPoint)
                
                return cell
            }
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.TopRatedTvCollectionView
        {
            return CGSize(width: 125 , height: (250 + 32) )
        }
        else
        {
            return CGSize(width: UIScreen.main.bounds.width-32 , height: (190 + 32) )
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.PopularTvCollectionView
        {
            if indexPath.row == 9
            {
               navigationController?.pushViewController(PopularMoreTVViewController(), animated: true)
            }
            else
            {
                let vc = MovieDetailViewController()
                vc.TVId = String(popularTvModel?.results?[indexPath.row].id ?? 0)
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        if collectionView == self.TopRatedTvCollectionView
        {
            if indexPath.row == 5
            {
                navigationController?.pushViewController(TopRatedMoreTVViewController(), animated: true)
            }
            else
            {
                let vc = MovieDetailViewController()
                vc.TVId = String(topRatedTvModel?.results?[indexPath.row].id ?? 0)
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }

    
}

extension TVHomePageViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foundTVModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath)  as! SearchResultTableViewCell
        cell.foundMovieName.text = foundTVModel?.results?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.TVId = String(self.foundTVModel?.results?[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension TVHomePageViewController: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.showsCancelButton = true
        self.hideTableView(bool: false)
        print(" CVB DidBeginEditing")
        
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("CVB textDidChange")
        self.getSearchedTV(word: (self.searchBar.text ?? ""))
        
        
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
        
        if self.foundTVTableView.isHidden
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
