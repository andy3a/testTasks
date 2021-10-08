import UIKit


protocol TestViewProtocol: AnyObject {
    func setBackground (with color: UIColor)
    func getLabel (with text: String)
}

class TestViewController: UIViewController, TestViewProtocol {

    @IBOutlet weak var myLabel: UILabel!
    
    var presenter: TestPresenterProtocol!
    let configurator: TestConfiguratorProtocol = TestConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func setBackground (with color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func getLabel(with text: String) {
        myLabel.text = text
    }
    
    @IBAction func helloWorldButton(_ sender: UIButton) {
        getLabel(with: presenter.getLabel())
    }
    
    @IBAction func goToSecondVC(_ sender: UIButton) {
        presenter.transferTransitionToRouter()
    }
}
