import UIKit

class ViewController: UIViewController, MenuViewControllerDelegate {
    
    @IBOutlet weak var currentVPNCountry: UIImageView!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var menuConstraint: NSLayoutConstraint!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var menuView: UIView!
    
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectButton.cornerRadius()
        connectButton.pulseAnimation()
        aboutButton.cornerRadius()
        self.viewModel = ViewModel()
        viewModel?.loadCountriesList()
        setCountryConnected()
        connectButton.setTitle("Connect", for: .normal)
        let tap = UITapGestureRecognizer (target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if self.menuConstraint.constant == 0 {
        self.menuConstraint.constant -= 200
        UIView.animate(withDuration: 0.3) {
        self.view.layoutIfNeeded()
        }
        self.view.sendSubviewToBack(blur)
      }
    }
    
    
    func setCountryConnected() {
        guard let countryArray = viewModel?.countriesArray.value else {return}
        viewModel?.selectedCountryIndex.bind({ (index) in
            guard let indexUnwrapped = index else {return}
            self.currentVPNCountry.image = UIImage(named: countryArray[indexUnwrapped].countryImage)
            self.spinner.stopAnimating()
            self.connectButton.setTitle("Disconnect", for: .normal)
            
        })
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        self.menuConstraint.constant += 200
        menuView.bringSubviewToFront(view)
        UIView.animate(withDuration: 0.3) {
            self.view.addSubview(self.blur)
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.delegate = self
        self.navigationController?.pushViewController(menuViewController, animated: true)
        self.menuConstraint.constant -= 200
        self.view.sendSubviewToBack(blur)
        
        
    }
    
    @IBAction func connectButtonPressed(_ sender: UIButton) {
        print("Button Pressed")
        if connectButton.titleLabel?.text == "Connect" {
            spinner.startAnimating()
            connectButton.setTitle("Connecting", for: .normal)
            
            currentVPNCountry.image = nil
            viewModel?.selectedCountryIndex.value = nil
            
            guard let countryArray = viewModel?.countriesArray.value else {return}
            
            viewModel?.randomCountrySelect()
            viewModel?.selectedCountryIndex.bind({ (index) in
                guard let indexUnwrapped = index else {return}
                self.currentVPNCountry.image = UIImage(named: countryArray[indexUnwrapped].countryImage)
                self.connectButton.setTitle("Disconnect", for: .normal)
                
                self.spinner.stopAnimating()
            })
        } else if connectButton.titleLabel?.text == "Disconnect" {
            currentVPNCountry.image = nil
            connectButton.setTitle("Connect", for: .normal)
        }
    } 

    func setLabel(name: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.connectButton.setTitle("Connecting", for: .normal)
            self.spinner.startAnimating()
        }
    }
    
    func setConnectingStatus(index: Int) {
        guard let countryArray = viewModel?.countriesArray.value else {return}
        currentVPNCountry.image = nil
        viewModel?.selectedCountryIndex.value = nil
        spinner.startAnimating()
        connectButton.setTitle("Connecting", for: .normal)
        connectButton.pulseAnimation()
        viewModel?.sendRequest(index: index)
        viewModel?.selectedCountryIndex.bind({ (index) in
            guard let indexUnwrapped = index else {return}
            self.currentVPNCountry.image = UIImage(named: countryArray[indexUnwrapped].countryImage)
            self.spinner.stopAnimating()
            self.connectButton.setTitle("Disconnect", for: .normal)
        })
    }
}

