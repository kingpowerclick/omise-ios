import Foundation

/// Brand of the Card Network
public enum CardBrand: String, CustomStringConvertible, Codable {
    
    /// VISA card newtwork brand
    case visa = "Visa"
    /// Master Card card newtwork brand
    case masterCard = "MasterCard"
    /// jcb card newtwork brand
    case jcb = "JCB"
    /// AMEX card newtwork brand
    case amex = "American Express"
    /// Diners card newtwork brand
    case diners = "Diners Club"
    /// Laser card newtwork brand
    case laser = "Laser"
    /// Maestro card newtwork brand
    case maestro = "Maestro"
    /// Discover card newtwork brand
    case discover = "Discover"

    public static let all: [CardBrand] = [
        visa,
        masterCard,
        jcb,
        amex,
        diners,
        laser,
        maestro,
        discover
    ]
    
    /// Regular expression pattern that can detect cards issued by the brand.
    public var pattern: String {
        switch self {
        case .visa:
            return "^4"
        case .masterCard:
            return "^(5[1-5]|2(2(2[1-9]|[3-9])|[3-6]|7(0|1|20)))"
        case .jcb:
            return "^35(2[89]|[3-8])"
        case .amex:
            return "^3[47]"
        case .diners:
            return "^3(0[0-5]|[6,8-9])|^5[4-5]"
        case .laser:
            return "^(6304|670[69]|6771)"
        case .maestro:
            return "^(5[0,6-8]|6304|6759|676[1-3])"
        case .discover:
            return "^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5]|64[4-9])|65)"
        }
    }
    
    /// Range of valid card number lengths for cards issued by the brand.
    public var validLengths: ClosedRange<Int> {
        switch self {
        case .visa:
            return 16...16
        case .masterCard:
            return 16...16
        case .jcb:
            return 16...16
        case .amex:
            return 15...15
        case .diners:
            return 14...14
        case .laser:
            return 16...19
        case .maestro:
            return 12...19
        case .discover:
            return 16...16
        }
    }
    
    public var description: String {
        self.rawValue
    }
}
