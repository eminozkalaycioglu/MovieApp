

import UIKit

class ThirdLaunchViewController: UIViewController {

    @IBOutlet weak var getStartedBıtton: UIButton!
    @IBOutlet weak var thirdNextView: BaseView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    @IBAction func getStartedAct(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = viewController
        
    }
    
}
