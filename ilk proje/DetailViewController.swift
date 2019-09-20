//
//  DetailViewController.swift
//  MovieApp
//
//  Created by kuka apps on 4.09.2019.
//  Copyright © 2019 kuka apps. All rights reserved.
//

import UIKit
import Kingfisher
//import YoutubePlayer_in_WKWebView
import FSPagerView

class DetailViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    var movieID: String?
    var model:SelectedMovieModel? = nil
    var selectedMoviesSimilarMoviesModel:SelectedMoviesSimilarMoviesModel? = nil
    var selectedMoviesActorsModel:SelectedMoviesActorsModel? = nil
    var selectedMoviesVideo:SelectedMoviesVideoModel? = nil
    var selectedMoviesImages:SelectedMoviesImagesModel? = nil
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var collectionViewsView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var similarCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailReleaseDate: UILabel!
    @IBOutlet weak var detailOverview: UILabel!
    @IBOutlet weak var labelVoteCount: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var labelVoteAverage: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var homepageTv: UITextView!
    @IBOutlet weak var similarView: UIView!
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.setFillColor(.gray, for: .normal)
            self.pageControl.setFillColor(.black, for: .selected)
        }
    }
    @IBOutlet weak var pagerView: FSPagerView!
        {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = CGSize(width: (UIScreen.main.bounds.width - 60), height: (pagerView.bounds.height - 60))
            
            self.pagerView.delegate = self
            self.pagerView.dataSource = self
            self.pagerView.transformer = FSPagerViewTransformer(type: .overlap)
            self.pagerView.isInfinite = true
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showIndicator()
        mainView.alpha = 0
        self.setTitle()
        getSelectedMovie(movieId: movieID ?? "")
        getSelectedMoviesActors(movieId: movieID ?? "")
        getSelectedMoviesSimilarMovies(movieId: movieID ?? "")
        getSelectedMoviesVideo(movieId: movieID ?? "")
        getSelectedMoviesImages(movieId: movieID ?? "")
        
    }
    
    func updateSliderData()
    {
        if (selectedMoviesImages?.backdrops?.count ?? 0) < 3
        {
            self.pagerView.isInfinite = false
        }
        else
        {
            self.pagerView.isInfinite = true
            
        }
        self.pagerView.reloadData()
        self.pageControl.numberOfPages = (self.selectedMoviesImages?.backdrops?.count ?? 0)
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return (self.selectedMoviesImages?.backdrops?.count ?? 0)
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        
        let urlString = "https://image.tmdb.org/t/p/w500" + (self.selectedMoviesImages?.backdrops?[index].filePath ?? "")
        let url = URL(string: urlString)
        cell.imageView?.kf.setImage(with: url)
        return cell
    }
    
    func setTitle() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setDetail() {
        detailTitle.text = model?.title
        
        detailReleaseDate.text = (model?.releaseDate ?? "")
        
        detailOverview.text = (model?.overview ?? "")
        
        labelVoteCount.text = "Toplam Oy: " + (String(model?.voteCount ?? 0))
        
        labelVoteAverage.text = "Ortalama Puan: " + (String(model?.voteAverage ?? 0)) + "/10"
        
        
        if (model?.homepage?.count ?? 0) < 5
        {
            self.homepageTv.removeFromSuperview()
        }
        else
        {
            homepageTv.text = "Film Sayfası: " + (model?.homepage ?? "")
            homepageTv.isEditable = false
            homepageTv.dataDetectorTypes = UIDataDetectorTypes.link
        }
        
        originalLanguageLabel.text = "Orijinal Dil: " + (model?.originalLanguage ?? "")
        
        runtimeLabel.text = "Süre: " + ((String)(model?.runtime ?? 100)) + " dk."
        
        if model?.adult == true
        {
            adultLabel.text = "+18 : Evet"
        }
        else
        {
            adultLabel.text = "+18 : Hayır"
        }
        
        var genres:String = ""
        
        for item in 0..<(model?.genres.count ?? 0)
        {
            if item == 0
            {
                genres.append(model?.genres[item].name ?? "")
            }
            else
            {
                genres.append(" / " + (model?.genres[item].name ?? ""))
            }
            
        }
        genresLabel.text = "Tür: " + genres
        
    }
    
    func getSelectedMovie(movieId: String) {
        ServiceManager.shared.getSelectedMovie(movieId: movieId,completion: { (result) in
            switch result {
            case .success(let response):
                self.model = response
                self.title = self.model?.originalTitle ?? self.model?.title
                self.setDetail()
                self.mainView.alpha = 1
                self.stopIndicator()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func getSelectedMoviesSimilarMovies(movieId: String) {
        ServiceManager.shared.getSelectedMoviesSimilarMovies(movieID: movieId,completion: { (result) in
            switch result {
            case .success(let response):
                self.selectedMoviesSimilarMoviesModel = response
                if self.selectedMoviesSimilarMoviesModel?.total_results == 0 {
                    self.similarView.removeFromSuperview()
                }
                    
                else {
                    self.setupSimilarCollectionView()
                }
                
            case .failure(let error):
                print("similar error")
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func getSelectedMoviesActors(movieId:String)
    {
        ServiceManager.shared.getSelectedMoviesActors(movieID: movieId, completion: { (result) in
            switch result {
            case .success(let response):
                self.selectedMoviesActorsModel = response
                self.setupCollectionView()
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
        
    }
    
    func getSelectedMoviesImages(movieId:String)
    {
        ServiceManager.shared.getSelectedMoviesImages(movieID: movieId, completion: { (result) in
            switch result {
            case .success(let response):
                
                self.selectedMoviesImages = response
                self.updateSliderData()
                
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
                
//                self.detailVideo.load(withVideoId: (self.selectedMoviesVideo?.results?[0].key ?? ""))
//                if self.selectedMoviesVideo?.results?[0].key == nil
//                {
//                    self.detailVideo.isHidden = true
//                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
        
    }
    
    func setupSimilarCollectionView() {
        self.similarCollectionView.delegate = self
        self.similarCollectionView.dataSource = self
        self.similarCollectionView.register(UINib(nibName: "SimilarCollectionViewCell", bundle: nil),
                                            forCellWithReuseIdentifier: "SimilarCollectionViewCell")
        self.setupSimilarCollectionViewLayout()
    }
    
    func setupSimilarCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        similarCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "CollectionViewCell")
        self.setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension DetailViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView
        {
            return selectedMoviesActorsModel?.cast?.count ?? 0
        }
        else
        {
            return selectedMoviesSimilarMoviesModel?.results?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView
        {
            if selectedMoviesActorsModel?.cast?[indexPath.row].profilePath == nil
            {
                
                return CGSize(width: 150, height: 100 )
            }
            else
            {
                return CGSize(width: 150,  height: 220 )
            }
            
        }
            
        else
        {
            return CGSize(width: 150, height: 220 )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for:indexPath) as! CollectionViewCell
            
            cell.actorsName.text = selectedMoviesActorsModel?.cast?[indexPath.row].name
            cell.actorsCharacter.text = selectedMoviesActorsModel?.cast?[indexPath.row].character
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (selectedMoviesActorsModel?.cast?[indexPath.row].profilePath ?? "/"))
            
            if selectedMoviesActorsModel?.cast?[indexPath.row].profilePath != nil
            {
                cell.actorsImage.image = nil
                cell.actorsImage.kf.setImage(with: imageUrl)
            }
            
            
            if selectedMoviesActorsModel?.cast?[indexPath.row].profilePath == nil
            {
                cell.actorsImage.image = nil
                cell.actorsImage.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarCollectionViewCell", for:indexPath) as! SimilarCollectionViewCell
            cell.movieName.text = selectedMoviesSimilarMoviesModel?.results?[indexPath.row].title
            
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (selectedMoviesSimilarMoviesModel?.results?[indexPath.row].poster_path ?? ""))
            cell.movieImage.kf.setImage(with: imageUrl)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == self.collectionView
        {
            let vc = ActorDetailViewController()
            vc.actorID = String(selectedMoviesActorsModel?.cast?[indexPath.row].id ?? 0)
            self.navigationController?.pushViewController(vc,animated: true)
        }
        else
        {
            let vc = DetailViewController()
            vc.movieID = String(selectedMoviesSimilarMoviesModel?.results?[indexPath.row].id ?? 0)
            self.navigationController?.pushViewController(vc,animated: true)
        }
        
    }
    
}

