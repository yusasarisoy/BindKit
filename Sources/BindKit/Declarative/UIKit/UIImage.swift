//
//  UIImage.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

public extension UIImage {
    
    // MARK: - Resource Loader
    
    /// Loads an image resource from the app’s asset catalog by name.
    ///
    /// This helper provides a declarative, BindKit-style initializer
    /// for asset-based images.
    ///
    /// ```swift
    /// let icon = UIImage.resource("base")
    /// imageView.image = icon
    /// ```
    ///
    /// - Parameter name: The name of the image in your asset catalog.
    /// - Returns: A `UIImage` instance if found, otherwise a placeholder 1×1 transparent image.
    static func resource(_ name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
    
    // MARK: - Rendering Mode
    
    /// Returns a copy of the image using the specified rendering mode.
    ///
    /// This method wraps UIKit’s `withRenderingMode(_:)` to create
    /// a more fluent, chainable API.
    ///
    /// ```swift
    /// let original = UIImage(named: "icon")
    /// let templated = original?.renderingMode(.alwaysTemplate)
    /// imageView.image = templated
    /// imageView.tintColor = .systemBlue
    /// ```
    ///
    /// - Parameter mode: The desired rendering mode for the new image.
    ///   Common values include:
    ///     - `.alwaysOriginal` — the image is drawn as-is.
    ///     - `.alwaysTemplate` — the image is drawn using the view’s tint color.
    /// - Returns: A new `UIImage` instance with the specified rendering mode applied.
    func renderingMode(_ mode: UIImage.RenderingMode) -> UIImage {
        withRenderingMode(mode)
    }
    
    // MARK: - Tinting
    
    /// Returns a tinted copy of the image.
    ///
    /// This method combines `withRenderingMode(_:)` and `withTintColor(_:)`
    /// to produce a new image tinted with the specified color.
    ///
    /// ```swift
    /// if #available(iOS 13.0, *) {
    ///     let tinted = UIImage(named: "icon")?.tinted(.systemRed)
    ///     imageView.image = tinted
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - color: The tint color to apply to the image.
    ///   - renderingMode: The rendering mode to use. Default is `.alwaysTemplate`.
    /// - Returns: A new `UIImage` instance tinted with the specified color.
    @available(iOS 13.0, *)
    func tinted(
        _ color: UIColor,
        renderingMode: UIImage.RenderingMode = .alwaysTemplate
    ) -> UIImage {
        withRenderingMode(renderingMode).withTintColor(color)
    }
    
    // MARK: - Scaling
    
    /// Returns a new scaled copy of the image using a `UIGraphicsImageRenderer`.
    ///
    /// This utility creates a resized version of the image while maintaining
    /// the specified scale factor. By default, it uses `UIScreen.main.scale`
    /// to match the current device’s display scale.
    ///
    /// ```swift
    /// let resized = await MainActor.run {
    ///     UIImage(named: "photo")?.scaled(to: CGSize(width: 100, height: 100))
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - size: The target size for the new image.
    ///   - scale: The scale factor to apply. Defaults to the main screen’s scale.
    /// - Returns: A new `UIImage` instance scaled to the given size.
    ///
    /// - Note: This function is marked with `@MainActor` because it accesses
    ///   `UIScreen.main`, which is main-thread-only. If you want to perform
    ///   image scaling off the main thread, provide your own `scale` value.
    @MainActor
    func scaled(
        to size: CGSize,
        scale: CGFloat = UIScreen.main.scale
    ) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
