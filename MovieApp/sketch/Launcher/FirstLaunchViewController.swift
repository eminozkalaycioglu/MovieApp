
import UIKit

class FirstLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
        else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            let vc = SecondLaunchViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
 
    

}
