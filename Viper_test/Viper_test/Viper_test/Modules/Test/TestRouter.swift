import Foundation
import UIKit


protocol TestRouterProtocol: AnyObject {
    func goToSecondVC ()
}

class TestRouter: TestRouterProtocol {
    
    weak var viewController: TestViewController!
    
    init(viewController: TestViewController) {
        self.viewController = viewController
    }
    
    func goToSecondVC () {
        let secondVC = viewController.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        viewController.present(secondVC, animated: true, completion: nil)
    }
}
