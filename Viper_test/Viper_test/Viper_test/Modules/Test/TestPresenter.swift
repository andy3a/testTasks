import Foundation
import UIKit

protocol TestPresenterProtocol: AnyObject {
    func configureView()
    func getLabel () -> String
    func transferTransitionToRouter ()
}

class TestPresenter: TestPresenterProtocol {
    
    weak var view: TestViewProtocol!
    var interactor: TestInteractorProtocol!
    var router: TestRouterProtocol!
    
    required init(view: TestViewProtocol) {
        self.view = view
    }
    
    func configureView () {
        view.setBackground(with: interactor.backgroundColor)
    }
    
    func getLabel () -> String {
        return interactor.labelText
    }
    
    func transferTransitionToRouter () {
        router.goToSecondVC()
    }
}
