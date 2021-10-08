import Foundation
import UIKit


protocol TestInteractorProtocol: AnyObject {
    var backgroundColor: UIColor {get}
    var labelText: String {get}
}

class TestInteractor: TestInteractorProtocol {
    
    weak var presenter: TestPresenterProtocol!
    let service: TestServiceProtocol = TestService()
    
    required init(presenter: TestPresenterProtocol) {
        self.presenter = presenter
    }
    
    var backgroundColor: UIColor {
        get {
            return service.backgroundColor
        }
    }
    
    var labelText: String {
        get {
            return service.labelText
        }
    }
}
