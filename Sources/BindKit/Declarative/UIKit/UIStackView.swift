//
//  UIStackView.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

public extension UIStackView {
    
    // MARK: - Axis
    
    /// Sets the axis along which the arranged views are laid out.
    ///
    /// Fluent wrapper around the `axis` property.
    ///
    /// ```swift
    /// UIStackView()
    ///     .axis(.vertical)
    ///     .spacing(12)
    /// ```
    ///
    /// - Parameter axis: The layout axis for the arranged views (`.horizontal` or `.vertical`).
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }
    
    // MARK: - Spacing
    
    /// Sets the spacing between adjacent arranged views.
    ///
    /// Fluent wrapper around the `spacing` property.
    ///
    /// ```swift
    /// stack.spacing(8)
    /// ```
    ///
    /// - Parameter value: The spacing value in points.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func spacing(_ value: CGFloat) -> Self {
        self.spacing = value
        return self
    }
    
    // MARK: - Alignment
    
    /// Sets the alignment of the arranged views perpendicular to the stack’s axis.
    ///
    /// Fluent wrapper around the `alignment` property.
    ///
    /// ```swift
    /// stack.alignment(.center)
    /// ```
    ///
    /// - Parameter value: The alignment mode (e.g., `.fill`, `.center`, `.leading`, `.trailing`).
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func alignment(_ value: UIStackView.Alignment) -> Self {
        self.alignment = value
        return self
    }
    
    // MARK: - Distribution
    
    /// Sets the distribution of the arranged views along the stack’s axis.
    ///
    /// Fluent wrapper around the `distribution` property.
    ///
    /// ```swift
    /// stack.distribution(.fillEqually)
    /// ```
    ///
    /// - Parameter value: The distribution mode (e.g., `.fill`, `.fillEqually`, `.equalSpacing`, `.equalCentering`).
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func distribution(_ value: UIStackView.Distribution) -> Self {
        self.distribution = value
        return self
    }
    
    // MARK: - Arranged Subviews
    
    /// Sets multiple arranged subviews for the stack view.
    ///
    /// This removes the need for multiple `addArrangedSubview(_:)` calls.
    ///
    /// ```swift
    /// stack.arrangedSubviews([label, button, imageView])
    /// ```
    ///
    /// - Parameter views: The array of views to add as arranged subviews.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func arrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach(addArrangedSubview)
        return self
    }
    
    /// Adds multiple arranged subviews to the stack view.
    ///
    /// Variadic overload for convenience.
    ///
    /// ```swift
    /// stack.addArrangedSubviews(label, button, imageView)
    /// ```
    ///
    /// - Parameter views: The list of views to add as arranged subviews.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func addArrangedSubviews(_ views: UIView...) -> Self {
        views.forEach(addArrangedSubview)
        return self
    }
    
    /// Removes all arranged subviews from the stack view.
    ///
    /// This method safely removes each arranged subview from both the arrangedSubviews
    /// array and its superview.
    ///
    /// ```swift
    /// stack.removeAllArrangedSubviews()
    /// ```
    ///
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func removeAllArrangedSubviews() -> Self {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        return self
    }
    
    // MARK: - Padding
    
    /// Sets layout margins as padding around the arranged subviews.
    ///
    /// Enables `isLayoutMarginsRelativeArrangement` automatically
    /// to make layout margins act as stack padding.
    ///
    /// ```swift
    /// stack.padding(.init(top: 12, left: 16, bottom: 12, right: 16))
    /// ```
    ///
    /// - Parameter insets: The edge insets to apply as padding.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func padding(_ insets: UIEdgeInsets) -> Self {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = insets
        return self
    }
}
