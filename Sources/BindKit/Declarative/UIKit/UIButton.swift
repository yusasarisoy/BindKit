//
//  UIButton.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

public extension UIButton {
    
    // MARK: - Title
    
    /// Sets the button’s title for a specific control state.
    ///
    /// Convenience wrapper around `setTitle(_:for:)` that allows fluent chaining.
    ///
    /// ```swift
    /// UIButton(type: .system)
    ///     .title("Continue")
    ///     .titleColor(.white)
    /// ```
    ///
    /// - Parameters:
    ///   - value: The string to use for the title. Pass `nil` to remove the title.
    ///   - state: The control state for which to set the title. Default is `.normal`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func title(
        _ value: String?,
        for state: UIControl.State = .normal
    ) -> Self {
        setTitle(
            value,
            for: state
        )
        return self
    }
    
    /// Sets the title color for a specific control state.
    ///
    /// Convenience wrapper around `setTitleColor(_:for:)`.
    ///
    /// - Parameters:
    ///   - color: The color of the title text. Pass `nil` to use the default.
    ///   - state: The control state for which to set the title color. Default is `.normal`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func titleColor(
        _ color: UIColor?,
        for state: UIControl.State = .normal
    ) -> Self {
        setTitleColor(
            color,
            for: state
        )
        return self
    }
    
    // MARK: - Images
    
    /// Sets the button’s image for a specific control state.
    ///
    /// Convenience wrapper around `setImage(_:for:)`.
    ///
    /// - Parameters:
    ///   - image: The image to display on the button. Pass `nil` to remove the image.
    ///   - state: The control state for which to set the image. Default is `.normal`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func image(
        _ image: UIImage?,
        for state: UIControl.State = .normal
    ) -> Self {
        setImage(
            image,
            for: state
        )
        return self
    }
    
    /// Sets the background image for a specific control state.
    ///
    /// Convenience wrapper around `setBackgroundImage(_:for:)`.
    ///
    /// - Parameters:
    ///   - image: The background image to use. Pass `nil` to remove any background image.
    ///   - state: The control state for which to set the background image. Default is `.normal`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func backgroundImage(
        _ image: UIImage?,
        for state: UIControl.State = .normal
    ) -> Self {
        setBackgroundImage(
            image,
            for: state
        )
        return self
    }
    
    // MARK: - Insets
    
    /// Sets directional content insets for the button.
    ///
    /// - For iOS 15+, applies to `UIButton.Configuration.contentInsets`.
    /// - For earlier versions, maps to `contentEdgeInsets`.
    ///
    /// ```swift
    /// button.contentInsets(.init(top: 8, leading: 12, bottom: 8, trailing: 12))
    /// ```
    ///
    /// - Parameter contentInsets: Insets to apply to the button’s content area.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func contentInsets(_ contentInsets: NSDirectionalEdgeInsets) -> Self {
        if #available(iOS 15.0, *) {
            var conf = configuration ?? .plain()
            conf.contentInsets = contentInsets
            configuration = conf
        } else {
            contentEdgeInsets = UIEdgeInsets(
                top: contentInsets.top,
                left: contentInsets.leading,
                bottom: contentInsets.bottom,
                right: contentInsets.trailing
            )
        }
        return self
    }
    
    // MARK: - Configuration (iOS 15+)
    
    /// Applies a `UIButton.Configuration` object to the button.
    ///
    /// This enables modern configuration-based button styles such as `.filled()`, `.gray()`, or `.tinted()`.
    ///
    /// ```swift
    /// if #available(iOS 15.0, *) {
    ///     button.configuration(.filled())
    /// }
    /// ```
    ///
    /// - Parameter configuration: The configuration object to apply.
    /// - Returns: `Self` to allow fluent chaining.
    @available(iOS 15.0, *)
    @discardableResult
    func configuration(_ configuration: UIButton.Configuration) -> Self {
        self.configuration = configuration
        return self
    }
    
    // MARK: - State
    
    /// Enables or disables the button.
    ///
    /// Convenience wrapper around `isEnabled` assignment.
    ///
    /// ```swift
    /// button.isEnabled(false)
    /// ```
    ///
    /// - Parameter isEnabled: `true` to enable the button, `false` to disable it.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Self {
        self.isEnabled = isEnabled
        return self
    }
}
