//
//  NameValidator.swift
//  changeName
//
//  Created by Gleb Shevchenko on 18.05.21.
//

import Foundation

final class NameValidator {
    static func isValid(firstName: String, lastName: String) -> Bool {
        let trimmedFirstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmedFirstName.count > 1, trimmedLastName.count > 1 else { return false }
        guard trimmedFirstName == firstName, trimmedLastName == lastName else { return false }
        return trimmedFirstName.count <= 10 && trimmedLastName.count <= 18
    }
}
