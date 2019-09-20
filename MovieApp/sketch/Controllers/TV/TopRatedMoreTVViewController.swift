

import UIKit

class TopRatedMoreTVViewController: UIViewController {

    var topRatedTV: TopRatedTVModel? = nil
    @IBOutlet weak var TopRatedTvCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showIndicator()
        self.getTopRatedTV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func getTopRatedTV()
    {
        ServiceManager.shared.getTopRatedTV { (result) in
            switch result {
            case .success(let response):
                self.topRatedTV = response
                self.setupCollectionView()
                self.stopIndicator()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func setupCollectionView() {
        self.TopRatedTvCollectionView.delegate = self
        self.TopRatedTvCollectionView.dataSource = self
        self.TopRatedTvCollectionView.register(UINib(nibName: "NowPlayingMoviesCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "NowPlayingMoviesCollectionViewCell")
        
        self.setupTopRatedTvCollectionViewLayout()
    }
    
    func setupTopRatedTvCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: (UIScreen.main.bounds.size.width-250)/3, bottom: 0, right: (UIScreen.main.bounds.size.width-250)/3)
        self.TopRatedTvCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }

}


extension TopRatedMoreTVViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRatedTV?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((250)/2), height: (250+16))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.TVId = String(topRatedTV?.results?[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMoviesCollectionViewCell", for:indexPath) as! NowPlayingMoviesCollectionViewCell
        cell.NowPlayingLabel.text = topRatedTV?.results?[indexPath.row].name ?? ""
        
        cell.NowPlayingImage.setImageURL(URLString: (topRatedTV?.results?[indexPath.row].poster_path ?? ""))
        return cell
    }
    
    
    
}
