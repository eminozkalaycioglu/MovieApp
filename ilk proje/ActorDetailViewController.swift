//
//  ActorDetailViewController.swift
//  MovieApp
//
//  Created by kuka apps on 5.09.2019.
//  Copyright © 2019 kuka apps. All rights reserved.
//

import UIKit
import FSPagerView

class ActorDetailViewController: UIViewController {
    
    
    var actorID: String!
    var actorsBioModel:ActorsBioModel? = nil
    var selectedActorsImagesModel:SelectedActorsImagesModel? = nil
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var knownAs: UILabel!
    @IBOutlet weak var placeOfBirth: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var biography: UILabel!
    @IBOutlet weak var department: UILabel!



    @IBOutlet weak var pagerView: FSPagerView!
    {
        didSet
        {
            
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            
            self.pagerView.itemSize = CGSize(width: (UIScreen.main.bounds.width*(3/5)), height: (pagerView.bounds.height - 100))
            self.pagerView.delegate = self
            self.pagerView.dataSource = self
            self.pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        }
    }
    
    
    @IBOutlet weak var pageControl: FSPageControl!
    {
        didSet
        {
        
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            
            self.pageControl.setFillColor(.gray, for: .normal)
            self.pageControl.setFillColor(.black, for: .selected)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showIndicator()
        self.setTitle()
        mainView.alpha = 0
        print("ACTORID :: " + (self.actorID ?? ""))
        self.getSelectedActor(actorID: actorID)
        self.getSelectedActorsImage(actorID: actorID)

    }
    
    func updateSliderData()
    {
        if (selectedActorsImagesModel?.profiles?.count ?? 0) < 3
        {
            self.pagerView.isInfinite = false
        }
        else
        {
            self.pagerView.isInfinite = true

        }
        
        self.pagerView.reloadData()
        self.pageControl.numberOfPages = (self.selectedActorsImagesModel?.profiles?.count ?? 0)
    }
    
    
    func getSelectedActorsImage(actorID: String)
    {
        ServiceManager.shared.getSelectedActorsImages(actorID: actorID) { (result) in
            switch result {
            case .success(let response):
                self.selectedActorsImagesModel = response
                self.updateSliderData()
                
            case .failure(let error):
                print("similar error")
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    
    func setTitle() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setActorsDetail()
    {
        var knownAsStr:String = "Bilinen İsimleri: "
        
        if actorsBioModel?.alsoKnownAs != nil && actorsBioModel?.alsoKnownAs?.count ?? 0 > 0
        {
            for item in 0..<(actorsBioModel?.alsoKnownAs?.count ?? 0)
            {
                knownAsStr.append(String(actorsBioModel?.alsoKnownAs?[item] ?? ""))
                knownAsStr.append(" / ")
            }
            knownAs.text = knownAsStr
        }
        else
        {
            knownAs.isHidden = true
        }
        
        
        if actorsBioModel?.placeOfBirth != nil && actorsBioModel?.placeOfBirth != ""
        {
            placeOfBirth.text = "Doğum Yeri: " + (actorsBioModel?.placeOfBirth ?? "Bilinmiyor")
        }
        else
        {
            placeOfBirth.isHidden = true
        }
        
        
        if actorsBioModel?.birthday != nil && actorsBioModel?.birthday != ""
        {
            birthday.text = "Doğum Tarihi: " + (actorsBioModel?.birthday ?? "Bilinmiyor")
            
        }
        else
        {
            birthday.isHidden = true
        }
        
        if actorsBioModel?.biography != nil && actorsBioModel?.biography != ""
        {
            biography.text = "Biyografi: " + (actorsBioModel?.biography ?? "Bilinmiyor")
        }
        else
        {
            biography.isHidden = true
        }
        
        if actorsBioModel?.knownForDepartment != nil && actorsBioModel?.knownForDepartment != ""
        {
            department.text = "Çalıştığı Alan: " + (actorsBioModel?.knownForDepartment ?? "Bilinmiyor")
        }
        else
        {
            department.isHidden = true
        }
        
        
    }
    func getSelectedActor(actorID:String)
    {
        ServiceManager.shared.getSelectedActor(actorID: actorID, completion: { (result) in
            switch result {
            case .success(let response):
                self.actorsBioModel = response
                self.title = self.actorsBioModel?.name
                self.setActorsDetail()
                self.mainView.alpha = 1
                self.stopIndicator()
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
    }

}

extension ActorDetailViewController: FSPagerViewDelegate,FSPagerViewDataSource {
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return (self.selectedActorsImagesModel?.profiles?.count ?? 0)
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        
        let urlString = "https://image.tmdb.org/t/p/w500" + (self.selectedActorsImagesModel?.profiles?[index].file_path ?? "")
        let url = URL(string: urlString)
        
        cell.imageView?.kf.setImage(with: url)
        return cell
    }
    
    
}
