

import UIKit

class SecondLaunchViewController: UIViewController {
    @IBOutlet weak var secondNextView: BaseView!
    
    @IBOutlet weak var secondNextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    

    @IBAction func secondNextButtonAct(_ sender: Any) {
        
        let vc = ThirdLaunchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
