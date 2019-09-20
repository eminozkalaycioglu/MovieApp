

import UIKit

class PopularMoreTVViewController: UIViewController {

    @IBOutlet weak var PopularMoreTvCollectionView: UICollectionView!
    var popularTvModel: PopularTVModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showIndicator()
        self.getPopularTv()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func getPopularTv()
    {
        ServiceManager.shared.getPopularTV { (result) in
            switch result {
            case .success(let response):
                self.popularTvModel = response
                self.setupCollectionView()
                self.stopIndicator()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func setupCollectionView() {
        self.PopularMoreTvCollectionView.delegate = self
        self.PopularMoreTvCollectionView.dataSource = self
        self.PopularMoreTvCollectionView.register(UINib(nibName: "PopularTvCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "PopularTvCollectionViewCell")
        
        self.setupPopularTvCollectionViewLayout()
    }
    
    func setupPopularTvCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        self.PopularMoreTvCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }

}

extension PopularMoreTVViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.popularTvModel?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-32 , height: (190 + 32) )
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.TVId = String(popularTvModel?.results?[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
