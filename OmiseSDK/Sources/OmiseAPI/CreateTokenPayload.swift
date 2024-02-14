import Foundation

/// Card Information to create a token container
/// Used as payload in createToken API
public struct CreateTokenPayload: Codable {
    let card: Card

    /// Card Information to create a token
    /// A token represents a credit or debit card
    /// https://docs.opn.ooo/tokens-api
    public struct Card: Codable, Equatable {
        /// Card holder's full name
        public let name: String
        /// Card number
        public let number: String
        /// Card expiration month (1-12)
        public let expirationMonth: Int
        /// Card expiration year (Gregorian)
        public let expirationYear: Int
        /// Security code (CVV, CVC, etc) printed on the back of the card
        public let securityCode: String
        /// Billing address country as two-letter ISO 3166 code.
        public let countryCode: String?
        /// Billing address city
        public let city: String?
        /// Billing address state
        public let state: String?
        /// Billing address street #1
        public let street1: String?
        /// Billing address street #2.
        public let street2: String?
        /// Card postal code
        public let postalCode: String?
        /// Phone number
        public let phoneNumber: String?

        private enum CodingKeys: String, CodingKey {
            case number
            case name
            case expirationMonth = "expiration_month"
            case expirationYear = "expiration_year"
            case securityCode = "security_code"
            case city
            case postalCode = "postal_code"
            case countryCode = "country"
            case state
            case street1
            case street2
            case phoneNumber = "phone_number"
        }

        public init(name: String, number: String, expirationMonth: Int, expirationYear: Int, securityCode: String, countryCode: String?, city: String?, state: String?, street1: String?, street2: String?, postalCode: String?, phoneNumber: String?) {
            self.name = name
            self.number = number
            self.expirationMonth = expirationMonth
            self.expirationYear = expirationYear
            self.securityCode = securityCode
            self.countryCode = countryCode
            self.city = city
            self.state = state
            self.street1 = street1
            self.street2 = street2
            self.postalCode = postalCode
            self.phoneNumber = phoneNumber
        }
    }
}
