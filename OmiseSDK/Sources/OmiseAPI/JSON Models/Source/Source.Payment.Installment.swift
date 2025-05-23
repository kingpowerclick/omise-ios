import Foundation

extension Source.Payment {
    /// Payloads for Installment payment methods
    /// https://docs.omise.co/installment-payments
    public struct Installment: Equatable {
        /// Valid installment term length in months
        let installmentTerm: Int
        /// Whether customer or merchant absorbs interest. true when merchant absorbs interest
        let zeroInterestInstallments: Bool?
        // swiftlint:disable:previous discouraged_optional_boolean
        /// Source type of payment
        var sourceType: SourceType
        
        public init(
            installmentTerm: Int,
            zeroInterestInstallments: Bool?,// swiftlint:disable:this discouraged_optional_boolean
            sourceType: SourceType
        ) {
            self.installmentTerm = installmentTerm
            self.zeroInterestInstallments = zeroInterestInstallments
            self.sourceType = sourceType
        }
    }
}

/// Encoding/decoding JSON string
extension Source.Payment.Installment: Codable {
    private enum CodingKeys: String, CodingKey {
        case sourceType = "type"
        case installmentTerm = "installment_term"
        case zeroInterestInstallments = "zero_interest_installments"
    }
}

extension Source.Payment.Installment {
    /// Available Installments terms (months) for given sourceType
    public static func availableTerms(for sourceType: SourceType) -> [Int] {
        switch sourceType {
        case .installmentBAY:
            return [ 3, 4, 6, 10 ]
        case .installmentBBL:
            return [ 4, 6, 8, 10 ]
        case .installmentFirstChoice:
            return [ 3, 4, 6, 10, 12, 18, 24, 36 ]
        case .installmentMBB:
            return [ 6, 12, 18, 24 ]
        case .installmentKTC:
            return [ 3, 4, 5, 6, 7, 8, 9, 10 ]
        case .installmentKBank:
            return [ 3, 4, 6, 10 ]
        case .installmentSCB:
            return [ 3, 4, 6, 9, 10 ]
        case .installmentTTB:
            return [ 3, 4, 6, 10, 12 ]
        case .installmentUOB, .installmentWhiteLabelUOB:
            return [ 3, 4, 6, 10 ]
        case .installmentWhiteLabelBAY:
            return [ 3, 4, 6, 9, 10 ]
        case .installmentWhiteLabelFirstChoice:
            return [ 3, 4, 6, 9, 10, 12, 18, 24, 36 ]
        case .installmentWhiteLabelBBL:
            return [ 4, 6, 8, 10 ]
        case .installmentWhiteLabelKTC:
            return [ 3, 4, 5, 6, 7, 8, 9, 10 ]
        case .installmentWhiteLabelSCB:
            return [ 3, 4, 6, 9, 10 ]
        case .installmentWhiteLabelKBank:
            return [ 3, 6, 10 ]
        case .installmentWhiteLabelTTB:
            return [ 4, 6, 10 ]
        default:
            return []
        }
    }
}
