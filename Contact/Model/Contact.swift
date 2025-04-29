import Foundation
import SwiftData

@Model
final class Contact {
    var timestamp: Date
    var firstName: String
    var lastName: String
    var email: String
    var number: String

    init(timestamp: Date, firstName: String, lastName: String, email: String, number: String) {
        self.timestamp = timestamp
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.number = number
    }
}
