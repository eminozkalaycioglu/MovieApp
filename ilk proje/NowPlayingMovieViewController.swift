//
//  ViewController.swift
//  MovieApp
//
//  Created by kuka apps on 2.09.2019.
//  Copyright © 2019 kuka apps. All rights reserved.
//

import UIKit
import Moya
import Kingfisher
class NowPlayingMovieViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var nowPlayingTableView: UITableView!

    var nowPlayingMovieModel:NowPlayingMovieModel?
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showIndicator()
        self.title = "Vizyondaki Filmler"
        self.setupTableView()
        self.getNowPlayingMovies()
        
        
        
        
        
    }
    
    
    
    
    func getNowPlayingMovies() {
        
        ServiceManager.shared.getNowPlayingMovies { (result) in
            switch result {
            case .success(let response):
                self.nowPlayingMovieModel = response
                
                self.nowPlayingTableView.reloadData()
                self.stopIndicator()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func setupTableView()
    {
        self.nowPlayingTableView.delegate=self
        self.nowPlayingTableView.dataSource=self
        
        self.nowPlayingTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.movieID = (String)(self.nowPlayingMovieModel?.results?[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vc,animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return nowPlayingMovieModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)  as! TableViewCell
        
        
        cell.overviewLabel.text = nowPlayingMovieModel?.results?[indexPath.row].overview ?? "Mevcut Değil"
        cell.voteAverageLabel.text = "Oy: " + ((String)(nowPlayingMovieModel?.results?[indexPath.row].vote_average ?? 0)) + "/10"
        
        cell.releaseDateLabel.text = "Çıkış Tarihi: " + (nowPlayingMovieModel?.results?[indexPath.row].release_date ?? "Mevcut Değil")
        cell.titleLabel.text = nowPlayingMovieModel?.results?[indexPath.row].title ?? "Mevcut Değil"
        let urlString = "https://image.tmdb.org/t/p/w500" + (nowPlayingMovieModel?.results?[indexPath.row].backdrop_path ?? "")
            
        let url = URL(string: urlString)
        
        cell.movieImageView.kf.setImage(with: url)
            
        return cell
    
    
    }
    

}

