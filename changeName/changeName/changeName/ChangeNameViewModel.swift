import Foundation
import Combine
import UIKit

class ChangeNameViewModel {
    var subscriptions = Set<AnyCancellable>()
    private var currentUser: User?
    var user: User! {
        get { currentUserSubject.value }
        set { currentUserSubject.send(newValue) }
    }
    private let currentUserSubject = CurrentValueSubject<User?, Never>(nil)
    let hasPassedValidationSubject = CurrentValueSubject<Bool, Never>(false)

    func setUpDefaultUser() {
        if UserDefaults.standard.value(User.self, forKey: UserDefaultsKeys.user.rawValue) == nil {
            let user = User(firstName: "Andrew", lastName: "Alekseyuk")
            UserDefaults.standard.set(encodable: user.self, forKey: UserDefaultsKeys.user.rawValue)
            currentUser = user
            self.user = user
        } else {
            self.user = UserDefaults.standard.value(User.self, forKey: UserDefaultsKeys.user.rawValue)
            currentUser = self.user
        }
    }
    func validateNewValues() {
        if NameValidator.isValid(firstName: user.firstName, lastName: user.lastName),
        self.user != currentUser {
            hasPassedValidationSubject.send(true)
            print("validation OK")
        } else {
            hasPassedValidationSubject.send(false)
            print("validation not OK")
        }
    }
    func saveChanges() {
        UserDefaults.standard.set(encodable: user.self, forKey: UserDefaultsKeys.user.rawValue)
        currentUser = self.user
    }
}
