import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func setConnectingStatus(index: Int)
    func setLabel(name: String)
}


class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel: ViewModel?
    
    weak var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel()
        viewModel?.loadCountriesList()  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.countriesArray.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VPNTableViewCell", for: indexPath) as? VPNTableViewCell,
              let unwrappedArray = viewModel?.countriesArray.value else {
            
            return UITableViewCell()
        }
        cell.configure(object: unwrappedArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.setConnectingStatus(index: indexPath.row)
        self.navigationController?.popViewController(animated: true)
 
    }
}
