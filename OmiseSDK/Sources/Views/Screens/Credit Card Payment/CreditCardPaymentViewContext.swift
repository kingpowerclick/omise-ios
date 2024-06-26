import UIKit

struct CreditCardPaymentViewContext {
    enum Field: String, CaseIterable {
        case address
        case city
        case state
        case postalCode
    }

    var number: String = ""
    var expirationMonth: Int = 0
    var expirationYear: Int = 0
    var name: String = ""
    var securityCode: String = ""
    var countryCode: String = ""

    private var fields: [Field: String] = [:]

    init(fields: [Field: String] = [:]) {
        self.fields = fields
    }

    subscript(field: Field) -> String {
        get {
            fields[field] ?? ""
        }
        set {
            fields[field] = newValue
        }
    }
}

extension CreditCardPaymentViewContext.Field {
    var title: String {
        "CreditCard.field.\(self.rawValue)".localized()
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .postalCode, .address: return .numbersAndPunctuation
        default: return .asciiCapable
        }
    }

    var capitalization: UITextAutocapitalizationType {
        switch self {
        case .city, .state, .address: return .words
        default: return .none
        }
    }

    var contentType: UITextContentType {
        switch self {
        case .city: return .addressCity
        case .postalCode: return .postalCode
        case .state: return .addressState
        case .address: return .streetAddressLine1
        }
    }

    var error: String? {
        switch self {
        default: return "CreditCard.field.\(self.rawValue).error".localized()
        }
    }
}
