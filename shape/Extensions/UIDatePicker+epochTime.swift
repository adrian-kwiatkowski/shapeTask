import UIKit

extension UIDatePicker {
    
    var epochTime: Int {
        return Int(date.timeIntervalSince1970)
    }
}
