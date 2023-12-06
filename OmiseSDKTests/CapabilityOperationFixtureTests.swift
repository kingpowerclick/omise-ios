import XCTest
@testable import OmiseSDK

class CapabilityOperationFixtureTests: XCTestCase {

    func testCapabilityRetrieve() {
        let decoder = Client.makeJSONDecoder(for: Request<Source>?.none)

        do {
            let capabilityData = try XCTestCase.fixturesData(forFilename: "capability")
            let capability = try decoder.decode(Capability.self, from: capabilityData)

            XCTAssertEqual(capability.supportedBackends.count, 34)

            if let creditCardBackend = capability.creditCardBackend {
                XCTAssertEqual(creditCardBackend.payment, .card([]))
                XCTAssertEqual(creditCardBackend.supportedCurrencies, [.thb, .jpy, .usd, .eur, .gbp, .sgd, .aud, .chf, .cny, .dkk, .hkd])
            } else {
                XCTFail("Capability doesn't have the Credit Card backend")
            }

            if let bayInstallmentBackend = capability[SourceTypeValue.installmentBAY] {
                XCTAssertEqual(
                    bayInstallmentBackend.payment,
                    .installment(.bay, availableNumberOfTerms: IndexSet([3, 4, 6, 9, 10]))
                )
                XCTAssertEqual(bayInstallmentBackend.supportedCurrencies, [.thb])
            } else {
                XCTFail("Capability doesn't have the BAY Installment backend")
            }

            if let trueMoneyBackend = capability[SourceTypeValue.trueMoney] {
                XCTAssertEqual(trueMoneyBackend.supportedCurrencies, [.thb])
            } else {
                XCTFail("Capability doesn't have the TrueMoney backend")
            }

            if let citiPointsBackend = capability[SourceTypeValue.pointsCiti] {
                XCTAssertEqual(citiPointsBackend.supportedCurrencies, [.thb])
            } else {
                XCTFail("Capability doesn't have the Citi Points backend")
            }

            if let rabbitLinePayBackend = capability[SourceTypeValue.rabbitLinepay] {
                XCTAssertEqual(rabbitLinePayBackend.supportedCurrencies, [.thb])
            } else {
                XCTFail("Capability doesn't have the Rabbit LINE Pay backend")
            }
            
            if let ocbcPaoBackend = capability[SourceTypeValue.mobileBankingOCBCPAO] {
                XCTAssertEqual(ocbcPaoBackend.supportedCurrencies, [.sgd])
            } else {
                XCTFail("Capability doesn't have the OCBC Pay Anyone backend")
            }

            if let fpxBackend = capability[SourceTypeValue.fpx] {
                XCTAssertEqual(fpxBackend.banks, [
                    Capability.Backend.Bank(name: "UOB", code: "uob", isActive: true)
                ])
            } else {
               XCTFail("Capability doesn't have the FPX backend")
            }

            if let mobileBankingKBankBackend = capability[SourceTypeValue.mobileBankingKBank] {
                XCTAssertEqual(
                    mobileBankingKBankBackend.payment, .mobileBanking(.kbank))
                XCTAssertEqual(mobileBankingKBankBackend.supportedCurrencies, [.thb])
            } else {
                XCTFail("Capability doesn't have the Mobile Banking KBank backend")
            }

            if let grabPayBackend = capability[SourceTypeValue.grabPay] {
                XCTAssertEqual(grabPayBackend.supportedCurrencies, [.sgd, .myr])
            } else {
                XCTFail("Capability doesn't have the GrabPay backend")
            }
            
            if let payPayBackend = capability[SourceTypeValue.payPay] {
                XCTAssertEqual(payPayBackend.supportedCurrencies, [.jpy])
            } else {
                XCTFail("Capability doesn't have the PayPay backend")
            }

            func testCapabilitySupportsCurrency(_ capability: Capability, sourceType: SourceTypeValue, currencies: Set<Currency>) {
                if let backend = capability[sourceType] {
                    XCTAssertEqual(backend.supportedCurrencies, currencies)
                } else {
                    XCTFail("Capability doesn't have the \(sourceType) backend")
                }
            }

            testCapabilitySupportsCurrency(capability, sourceType: .trueMoney, currencies: [.thb])
            testCapabilitySupportsCurrency(capability, sourceType: .pointsCiti, currencies: [.thb])
            testCapabilitySupportsCurrency(capability, sourceType: .rabbitLinepay, currencies: [.thb])
            testCapabilitySupportsCurrency(capability, sourceType: .mobileBankingOCBCPAO, currencies: [.sgd])
            testCapabilitySupportsCurrency(capability, sourceType: .grabPay, currencies: [.sgd, .myr])
            testCapabilitySupportsCurrency(capability, sourceType: .payPay, currencies: [.jpy])
        } catch {
            XCTFail("Cannot decode the source \(error)")
        }
    }

    func testEncodeCapabilityRetrieve() throws {
        let decoder = Client.makeJSONDecoder(for: Request<Source>?.none)
        let capabilityData = try XCTestCase.fixturesData(forFilename: "capability")
        let capability = try decoder.decode(Capability.self, from: capabilityData)

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let encodedData = try encoder.encode(capability)

        let decodedCapability = try decoder.decode(Capability.self, from: encodedData)
        XCTAssertEqual(capability.supportedBackends.count, decodedCapability.supportedBackends.count)

        XCTAssertEqual(capability.creditCardBackend?.payment, decodedCapability.creditCardBackend?.payment)
        XCTAssertEqual(capability.creditCardBackend?.supportedCurrencies,
                       decodedCapability.creditCardBackend?.supportedCurrencies)
        XCTAssertEqual(
            capability[.installmentBAY]?.payment,
            decodedCapability[.installmentBAY]?.payment
        )
        XCTAssertEqual(capability[.installmentBAY]?.supportedCurrencies,
                       decodedCapability[.installmentBAY]?.supportedCurrencies)
        XCTAssertEqual(capability[.installmentBAY]?.payment,
                       decodedCapability[.installmentBAY]?.payment)
    }
}
