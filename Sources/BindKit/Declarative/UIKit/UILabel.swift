//
//  UILabel.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

public extension UILabel {
    
    // MARK: - Text
    
    /// Sets the plain text displayed by the label.
    ///
    /// Fluent wrapper around `text` assignment.
    ///
    /// ```swift
    /// UILabel()
    ///     .text("Hello World")
    ///     .font(.systemFont(ofSize: 16))
    /// ```
    ///
    /// - Parameter text: The string to display. Pass `nil` to clear the text.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    /// Sets the attributed text displayed by the label.
    ///
    /// Fluent wrapper around `attributedText` assignment.
    ///
    /// ```swift
    /// let attr = NSAttributedString(
    ///     string: "Bold",
    ///     attributes: [.font: UIFont.boldSystemFont(ofSize: 18)]
    /// )
    /// UILabel().attributedText(attr)
    /// ```
    ///
    /// - Parameter attributedText: The attributed string to display. Pass `nil` to clear the text.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    // MARK: - Font & Color
    
    /// Sets the font used to display the label’s text.
    ///
    /// Fluent wrapper around `font` assignment.
    ///
    /// ```swift
    /// label.font(.boldSystemFont(ofSize: 18))
    /// ```
    ///
    /// - Parameter font: The font to apply to the text.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    /// Sets the color of the label’s text.
    ///
    /// Fluent wrapper around `textColor` assignment.
    ///
    /// ```swift
    /// label.textColor(.secondaryLabel)
    /// ```
    ///
    /// - Parameter textColor: The text color to apply.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    // MARK: - Alignment
    
    /// Sets the alignment of the text within the label’s bounds.
    ///
    /// Fluent wrapper around `textAlignment` assignment.
    ///
    /// ```swift
    /// label.textAlignment(.center)
    /// ```
    ///
    /// - Parameter textAlignment: The text alignment to apply (e.g., `.left`, `.center`, `.right`).
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    // MARK: - Lines & Wrapping
    
    /// Sets the maximum number of lines for the label’s text.
    ///
    /// Fluent wrapper around `numberOfLines` assignment.
    ///
    /// ```swift
    /// label.numberOfLines(2)
    /// ```
    ///
    /// - Parameter numberOfLines: The maximum number of lines. Use `0` for unlimited lines.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    /// Sets the line break mode for the label’s text.
    ///
    /// Fluent wrapper around `lineBreakMode` assignment.
    ///
    /// ```swift
    /// label.lineBreakMode(.byTruncatingTail)
    /// ```
    ///
    /// - Parameter lineBreakMode: The line break mode to apply (e.g., `.byWordWrapping`, `.byTruncatingTail`).
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    // MARK: - Auto-Fitting
    
    /// Enables or disables automatic font size adjustment to fit the label’s width.
    ///
    /// Fluent wrapper around `adjustsFontSizeToFitWidth` assignment.
    ///
    /// ```swift
    /// label.adjustsFontSizeToFitWidth(true)
    /// ```
    ///
    /// - Parameter adjustsFontSizeToFitWidth: `true` to shrink the font to fit the width, `false` to disable. Default is `false`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
}
