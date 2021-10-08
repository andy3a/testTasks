import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
}

// MARK: - Equatable
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
}
