//
//  UIImageView.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

public extension UIImageView {
    
    // MARK: - Image
    
    /// Sets the displayed image of the image view.
    ///
    /// Convenience wrapper around `image` assignment that supports fluent chaining.
    ///
    /// ```swift
    /// UIImageView()
    ///     .image(UIImage(named: "avatar"))
    ///     .contentMode(.scaleAspectFill)
    /// ```
    ///
    /// - Parameter image: The image to display. Pass `nil` to clear the image.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    // MARK: - Content Mode
    
    /// Sets the content mode used to layout the image within the image view’s bounds.
    ///
    /// Convenience wrapper around `contentMode` assignment.
    ///
    /// ```swift
    /// imageView.contentMode(.scaleAspectFit)
    /// ```
    ///
    /// - Parameter contentMode: The content mode to apply (e.g., `.scaleAspectFill`, `.center`, `.scaleToFill`).
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    // MARK: - Tint Color
    
    /// Sets the tint color used when rendering the image as a template image.
    ///
    /// Use this together with `.templateRendering(enabled:)` or `UIImage.tinted(_:)`
    /// to achieve dynamic color rendering using `tintColor`.
    ///
    /// ```swift
    /// UIImageView()
    ///     .image(UIImage(named: "icon")?.renderingMode(.alwaysTemplate))
    ///     .tintColor(.systemBlue)
    /// ```
    ///
    /// - Parameter tintColor: The color to apply to the image view’s `tintColor`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func tintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }
    
    // MARK: - Clipping
    
    /// Enables or disables clipping of the image view’s content to its bounds.
    ///
    /// Convenience wrapper around `clipsToBounds` assignment.
    ///
    /// ```swift
    /// imageView.clipsToBounds(true)
    /// ```
    ///
    /// - Parameter clipsToBounds: A Boolean value that determines whether subviews and content are confined to the bounds of the view. Default is `true`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool = true) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
    
    // MARK: - Template Rendering
    
    /// Converts the current image to use template or original rendering mode.
    ///
    /// When `enabled` is `true`, the image is converted to `.alwaysTemplate`, allowing it to take on the view’s `tintColor`.
    /// When `enabled` is `false`, it is converted back to `.alwaysOriginal`.
    ///
    /// ```swift
    /// UIImageView()
    ///     .image(UIImage(named: "icon"))
    ///     .templateRendering(enabled: true)
    ///     .tintColor(.systemRed)
    /// ```
    ///
    /// - Parameter enabled: A Boolean flag indicating whether template rendering mode should be applied. Default is `true`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func templateRendering(enabled: Bool = true) -> Self {
        guard let image else {
            return self
        }
        self.image = enabled
        ? image.withRenderingMode(.alwaysTemplate)
        : image.withRenderingMode(.alwaysOriginal)
        return self
    }
}
