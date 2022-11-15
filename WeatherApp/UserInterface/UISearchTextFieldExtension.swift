import UIKit
import Combine

extension UISearchTextField {
    var textDidChangePublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
