import UIKit


class VPNTableViewCell: UITableViewCell {

    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)  
    }
    
    func configure (object: VPN) {
        countryImage.image = UIImage(named: object.countryImage)
        countryLabel.text = object.counrtyName
        
    }

}
