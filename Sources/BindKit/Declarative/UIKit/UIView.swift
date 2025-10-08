//
//  UIView.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

public extension UIView {
    
    // MARK: - Visual
    
    /// Sets the background color of the view.
    ///
    /// Fluent wrapper around `backgroundColor` assignment.
    ///
    /// ```swift
    /// view.backgroundColor(.secondarySystemBackground)
    /// ```
    ///
    /// - Parameter color: The background color. Pass `nil` to clear.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    /// Sets the opacity (alpha) of the view.
    ///
    /// Fluent wrapper around `alpha` assignment.
    ///
    /// - Parameter value: A value from `0.0` (transparent) to `1.0` (opaque).
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func alpha(_ value: CGFloat) -> Self {
        self.alpha = value
        return self
    }
    
    /// Hides or shows the view.
    ///
    /// Fluent wrapper around `isHidden` assignment.
    ///
    /// - Parameter hidden: `true` to hide; `false` to show.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func isHidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }
    
    // MARK: - Layer
    
    /// Sets the corner radius and optional masking behavior.
    ///
    /// - Parameters:
    ///   - radius: The radius to use when drawing rounded corners.
    ///   - masksToBounds: Whether sublayers are clipped to bounds. Default is `true`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func cornerRadius(_ radius: CGFloat, masksToBounds: Bool = true) -> Self {
        layer.cornerRadius = radius
        layer.masksToBounds = masksToBounds
        return self
    }
    
    /// Configures the layer’s border width and color.
    ///
    /// - Parameters:
    ///   - width: Border width in points.
    ///   - color: Border color. Pass `nil` to clear.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func border(width: CGFloat, color: UIColor?) -> Self {
        layer.borderWidth = width
        layer.borderColor = color?.cgColor
        return self
    }
    
    /// Applies a shadow to the view’s layer.
    ///
    /// Note: Sets `masksToBounds` to `false` to allow shadow to render.
    ///
    /// - Parameters:
    ///   - color: Shadow color. Default `.black`.
    ///   - opacity: Shadow opacity (0–1). Default `0.1`.
    ///   - radius: Blur radius. Default `8`.
    ///   - offset: Shadow offset. Default `.zero`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func shadow(
        color: UIColor = .black,
        opacity: Float = 0.1,
        radius: CGFloat = 8,
        offset: CGSize = .zero
    ) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.masksToBounds = false
        return self
    }
    
    // MARK: - Hierarchy
    
    /// Adds one or more subviews to the view.
    ///
    /// Variadic convenience over `addSubview(_:)`.
    ///
    /// - Parameter views: The subviews to add.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func addSubviews(_ views: UIView...) -> Self {
        views.forEach(addSubview)
        return self
    }
    
    // MARK: - Layout (Minimal Helpers)
    
    /// Constrains the view’s height to a constant.
    ///
    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false` and activates the constraint.
    ///
    /// - Parameter value: Height in points.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func height(_ value: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: value).isActive = true
        return self
    }
    
    /// Constrains the view’s width to a constant.
    ///
    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false` and activates the constraint.
    ///
    /// - Parameter value: Width in points.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func width(_ value: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: value).isActive = true
        return self
    }
    
    /// Constrains the view to a square with equal width and height.
    ///
    /// Internally calls `width(_:)` then `height(_:)`.
    ///
    /// - Parameter value: Side length in points.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func size(_ value: CGFloat) -> Self {
        width(value).height(value)
    }
    
    /// Pins the view to its superview’s edges with optional insets.
    ///
    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false`, then activates
    /// top/leading/trailing/bottom constraints to either the superview’s `safeAreaLayoutGuide`
    /// or `layoutMarginsGuide`.
    ///
    /// ```swift
    /// container.addSubview(content)
    /// content.pinToSuperview(insets: .init(top: 16, left: 16, bottom: 16, right: 16))
    /// ```
    ///
    /// - Parameters:
    ///   - insets: Edge insets to apply. Default `.zero`.
    ///   - useSafeArea: When `true`, pins to `safeAreaLayoutGuide`; otherwise to `layoutMarginsGuide`. Default `true`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func pinToSuperview(
        insets: UIEdgeInsets = .zero,
        useSafeArea: Bool = true
    ) -> Self {
        guard let superview else { return self }
        translatesAutoresizingMaskIntoConstraints = false
        let layoutGuide = useSafeArea ? superview.safeAreaLayoutGuide : superview.layoutMarginsGuide
        NSLayoutConstraint.activate(
            [
                leadingAnchor.constraint(
                    equalTo: layoutGuide.leadingAnchor,
                    constant: insets.left
                ),
                trailingAnchor.constraint(
                    equalTo: layoutGuide.trailingAnchor,
                    constant: -insets.right
                ),
                topAnchor.constraint(
                    equalTo: layoutGuide.topAnchor,
                    constant: insets.top
                ),
                bottomAnchor.constraint(
                    equalTo: layoutGuide.bottomAnchor,
                    constant: -insets.bottom
                )
            ]
        )
        return self
    }
}
