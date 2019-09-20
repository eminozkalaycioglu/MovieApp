

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let item1 = MoviesHomePageViewController().embedInNC()
        let icon1 = UITabBarItem(title: "", image: UIImage(named: "tbUnselectedMovies")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "tbSelectedMovies")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        let item2: UIViewController = TVHomePageViewController().embedInNC()
        let icon2 = UITabBarItem(title: "", image: UIImage(named: "tbUnselectedTv")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "tbSelectedTv")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        icon1.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        icon2.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        
        
        self.viewControllers = [item1,item2]
    }

}
