import Foundation
import UIKit

protocol TestConfiguratorProtocol {
    func configure(with viewController: TestViewController)
}

class TestConfigurator: TestConfiguratorProtocol {
    
    func configure(with viewController: TestViewController) {
        let presenter = TestPresenter(view: viewController)
        let interactor = TestInteractor(presenter: presenter)
        let router = TestRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

