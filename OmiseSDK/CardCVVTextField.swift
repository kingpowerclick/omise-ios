import Foundation
import UIKit


/// UITextField subclass for entering card's CVV number.
@objc(OMSCardCVVTextField) @IBDesignable
open class CardCVVTextField: OmiseTextField {
    private let validLengths = 3...4
    
    public var shouldBeginEditingHandler: (() -> Bool)?
    
    @available(iOS, unavailable)
    open override var delegate: UITextFieldDelegate? {
        get {
            return self
        }
        set {}
    }
    
    open override var keyboardType: UIKeyboardType {
        didSet {
            super.keyboardType = .numberPad
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initializeInstance()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeInstance()
    }
    
    override public init() {
        super.init(frame: CGRect.zero)
        initializeInstance()
    }
    
    private func initializeInstance() {
        super.keyboardType = .numberPad
        super.delegate = self
        
        validator = try! NSRegularExpression(pattern: "\\d{3,4}", options: [])
    }
    
    public override func validate() throws {
        try super.validate()
        
        guard let text = self.text else {
            throw OmiseTextFieldValidationError.emptyText
        }
        if !(validLengths ~= text.count) {
            throw OmiseTextFieldValidationError.invalidData
        }
    }
}

extension CardCVVTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard range.length >= 0 else {
            return true
        }
        let maxLength = 4
        
        return maxLength >= (self.text?.count ?? 0) - range.length + string.count
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        return shouldBeginEditingHandler?() ?? true
    }
}
