import Foundation
import UIKit

protocol TestServiceProtocol: AnyObject {
    var backgroundColor: UIColor {get}
    var labelText: String {get}
}

class TestService: TestServiceProtocol {
    
    var backgroundColor: UIColor {
        return UIColor.green
    }
    
    var labelText: String {
        return "Hello World!"
    }
}
