import Foundation
import UIKit

extension UIButton {
    
    func cornerRadius () {
        self.layer.cornerRadius = frame.height / 2
    }
    
    func pulseAnimation (){
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.5
        pulseAnimation.fromValue = 0.5
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(pulseAnimation, forKey: nil)
    }
}
