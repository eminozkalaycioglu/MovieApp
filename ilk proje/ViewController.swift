//
//  ViewController.swift
//  MovieApp
//
//  Created by kuka apps on 2.09.2019.
//  Copyright © 2019 kuka apps. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    var movieResponse:MovieResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showIndicator()
        
        self.title = "Popüler Filmler"
        self.setupTableView()
        self.getPopularMovies()
        
    }
    
    func getPopularMovies() {
        
        ServiceManager.shared.getPopularMovies { (result) in
            switch result {
            case .success(let response):
                self.movieResponse = response
                
                self.tableView.reloadData()
                self.stopIndicator()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func setupTableView()
    {
        self.tableView.delegate=self
        self.tableView.dataSource=self
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.movieID = (String)(self.movieResponse?.results?[indexPath.row].id ?? 0)
        navigationController?.pushViewController(vc,animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return movieResponse?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)  as! TableViewCell
        
        cell.overviewLabel.text = movieResponse?.results?[indexPath.row].overview ?? "Mevcut Değil"
        cell.voteAverageLabel.text = "Oy: " + ((String)(movieResponse?.results?[indexPath.row].voteAverage ?? 0)) + "/10"
        
        cell.releaseDateLabel.text = "Çıkış Tarihi: " + (movieResponse?.results?[indexPath.row].releaseDate ?? "Mevcut Değil")
        cell.titleLabel.text = movieResponse?.results?[indexPath.row].title ?? "Mevcut Değil"
        let urlString = "https://image.tmdb.org/t/p/w500" + (movieResponse?.results?[indexPath.row].backdropPath ?? "")
            
        let url = URL(string: urlString)
        
        cell.movieImageView.kf.setImage(with: url)
            
        return cell
    
    }
    

}

