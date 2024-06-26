import Foundation
import ThreeDS_SDK

public class ThreeDSLabelCustomization: ThreeDSCustomization {
    /// Color of the heading label text in Hex format.
    public var headingTextColorHex: String?

    /// Dark color of the heading label text in Hex format.
    public var headingDarkTextColorHex: String?

    /// Font name of the heading label text.
    public var headingTextFontName: String?

    /// Font size of the heading label text.
    public var headingTextFontSize: Int?

    public init(
        headingTextColorHex: String? = nil,
        headingDarkTextColorHex: String? = nil,
        headingTextFontName: String? = nil,
        headingTextFontSize: Int? = nil,
        textFontName: String? = nil,
        textColorHex: String? = nil,
        darkTextColorHex: String? = nil,
        textFontSize: Int? = nil
    ) {
        super.init(textFontName: textFontName,
                   textColorHex: textColorHex,
                   darkTextColorHex: darkTextColorHex,
                   textFontSize: textFontSize)
        self.headingTextColorHex = headingTextColorHex
        self.headingDarkTextColorHex = headingDarkTextColorHex
        self.headingTextFontName = headingTextFontName
        self.headingTextFontSize = headingTextFontSize
    }

    @discardableResult
    public func headingTextColorHex(_ headingTextColorHex: String?) -> Self {
        self.headingTextColorHex = headingTextColorHex
        return self
    }
    @discardableResult
    public func headingDarkTextColorHex(_ headingDarkTextColorHex: String?) -> Self {
        self.headingDarkTextColorHex = headingDarkTextColorHex
        return self
    }
    @discardableResult
    public func headingTextFontName(_ headingTextFontName: String?) -> Self {
        self.headingTextFontName = headingTextFontName
        return self
    }
    @discardableResult
    public func headingTextFontSize(_ headingTextFontSize: Int?) -> Self {
        self.headingTextFontSize = headingTextFontSize
        return self
    }
}

extension ThreeDS_SDK.LabelCustomization {
    convenience init(_ custom: ThreeDSLabelCustomization) throws {
        self.init()
        try customize(custom)
    }

    func customize(_ custom: ThreeDSLabelCustomization) throws {
        try customize(omiseThreeDSCustomization: custom)

        if let headingTextColorHex = custom.headingTextColorHex {
            try setHeadingTextColor(hexColorCode: headingTextColorHex)
        }

        if let headingDarkTextColorHex = custom.headingDarkTextColorHex {
            try setHeadingDarkTextColor(hexColorCode: headingDarkTextColorHex)
        }

        if let headingTextFontName = custom.headingTextFontName {
            try setHeadingTextFontName(fontName: headingTextFontName)
        }

        if let headingTextFontSize = custom.headingTextFontSize {
            try setHeadingTextFontSize(fontSize: headingTextFontSize)
        }
    }
}
