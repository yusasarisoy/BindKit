//
//  UIView+BindKit.swift
//
//
//  Created by Yuşa on 1.10.2025.
//

import UIKit

// MARK: - UIView + BK

public extension UIView {
    
    /// Entry point for BindKit DSL.
    ///
    /// Example:
    /// ```swift
    /// let title = UILabel()
    /// view.addSubview(title)
    /// title.bk.center(axes: .both)
    /// ```
    ///
    /// - Returns: A `BKProxy` that exposes BindKit DSL methods for this view.
    @MainActor
    var bk: BKProxy {
        BKProxy(self)
    }
}

// MARK: - Helpers

extension UIView {
    /// Prepares the view for Auto Layout by disabling autoresizing mask translation.
    @MainActor
    func bk_prepareForAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - BKProxy: Subview Management & Layout

public extension BKProxy {
    
    // MARK: - Add Subview
    
    /// Adds the current view to a superview.
    ///
    /// This is equivalent to `superview.addSubview(view)` but returns the view
    /// for convenient chaining.
    ///
    /// - Parameters:
    ///   - superview: The container to add into.
    ///   - configure: Optional configuration block executed after adding.
    /// - Returns: The same `UIView` instance that was added, allowing call chaining.
    @discardableResult
    func add(
        to superview: UIView,
        configure: ((UIView) -> Void)? = nil
    ) -> UIView {
        superview.addSubview(view)
        configure?(view)
        return view
    }
    
    // MARK: - Pin Edges
    
    /// Pins the view to the given superview’s edges.
    ///
    /// By default this method uses the container’s `layoutMarginsGuide`. Pass `safe: true`
    /// to use `safeAreaLayoutGuide` instead.
    ///
    /// - Parameters:
    ///   - superview: The container. If `nil`, uses `view.superview`.
    ///   - safe: Whether to use `safeAreaLayoutGuide` instead of `layoutMarginsGuide`. Default is `false`.
    ///   - edges: Edges to pin. Default is all four.
    ///   - insets: Insets applied to each pinned edge. Default is `.zero`.
    /// - Returns: An **activated** `BKConstraintGroup` containing the created constraints.
    ///
    /// Example:
    /// ```swift
    /// contentView.bk.pinEdges(to: view, safe: true, insets: .all(16))
    /// ```
    @discardableResult
    func pinEdges(
        to superview: UIView? = nil,
        safe: Bool = false,
        edges: [BKEdge] = [
            .top,
            .leading,
            .bottom,
            .trailing
        ],
        insets: BKInsets = .zero
    ) -> BKConstraintGroup {
        guard let container = superview ?? view.superview else {
            assertionFailure("pinEdges: superview not found. Call add(to:) first or provide 'to:' explicitly.")
            return BKConstraintGroup()
        }
        view.bk_prepareForAutoLayout()
        
        let guide: UILayoutGuide = safe ? container.safeAreaLayoutGuide : container.layoutMarginsGuide
        if !safe {
            container.layoutMargins = .zero
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        if edges.contains(.top) {
            constraints.append(
                view.topAnchor.constraint(
                    equalTo: guide.topAnchor,
                    constant: insets.top
                )
            )
        }
        if edges.contains(.leading) {
            constraints.append(
                view.leadingAnchor.constraint(
                    equalTo: guide.leadingAnchor,
                    constant: insets.leading
                )
            )
        }
        if edges.contains(.bottom) {
            constraints.append(
                view.bottomAnchor.constraint(
                    equalTo: guide.bottomAnchor,
                    constant: -insets.bottom
                )
            )
        }
        if edges.contains(.trailing) {
            constraints.append(
                view.trailingAnchor.constraint(
                    equalTo: guide.trailingAnchor,
                    constant: -insets.trailing
                )
            )
        }
        
        return BKConstraintGroup(constraints).activate()
    }
    
    // MARK: - Align Edges
    
    /// Aligns the view to another view’s edges.
    ///
    /// - Parameters:
    ///   - edges: Which edges to align.
    ///   - other: The target view.
    ///   - insets: Insets applied when aligning. Positive values add spacing outward.
    /// - Returns: An **activated** `BKConstraintGroup` containing the created constraints.
    ///
    /// Example:
    /// ```swift
    /// title.bk.align([.leading, .trailing], to: container, insets: .all(16))
    /// ```
    @discardableResult
    func align(
        _ edges: [BKEdge],
        to other: UIView,
        insets: BKInsets = .zero
    ) -> BKConstraintGroup {
        view.bk_prepareForAutoLayout()
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.top) {
            constraints.append(
                view.topAnchor.constraint(
                    equalTo: other.topAnchor,
                    constant: insets.top
                )
            )
        }
        if edges.contains(.leading) {
            constraints.append(
                view.leadingAnchor.constraint(
                    equalTo: other.leadingAnchor,
                    constant: insets.leading
                )
            )
        }
        if edges.contains(.bottom) {
            constraints.append(
                view.bottomAnchor.constraint(
                    equalTo: other.bottomAnchor,
                    constant: -insets.bottom
                )
            )
        }
        if edges.contains(.trailing) {
            constraints.append(
                view.trailingAnchor.constraint(
                    equalTo: other.trailingAnchor,
                    constant: -insets.trailing
                )
            )
        }
        return BKConstraintGroup(constraints).activate()
    }
    
    // MARK: - Centering
    
    /// Centers the view inside another container (or its own superview).
    ///
    /// - Parameters:
    ///   - other: Container view. If `nil`, uses `view.superview`.
    ///   - axes: Which axes to center along. Default is `.both`.
    /// - Returns: An **activated** `BKConstraintGroup` containing the created constraints.
    ///
    /// Example:
    /// ```swift
    /// loader.bk.center(axes: .both)
    /// badge.bk.center(in: header, axes: .horizontal)
    /// ```
    @discardableResult
    func center(
        in other: UIView? = nil,
        axes: BKAxis = .both
    ) -> BKConstraintGroup {
        let container = other ?? view.superview
        guard let container else {
            assertionFailure("center: superview not found. Call add(to:) first or provide 'in:' explicitly.")
            return BKConstraintGroup()
        }
        view.bk_prepareForAutoLayout()
        var constraints: [NSLayoutConstraint] = []
        switch axes {
        case .horizontal:
            constraints.append(
                view.centerXAnchor.constraint(
                    equalTo: container.centerXAnchor
                )
            )
        case .vertical:
            constraints.append(
                view.centerYAnchor.constraint(
                    equalTo: container.centerYAnchor
                )
            )
        case .both:
            constraints.append(
                view.centerXAnchor.constraint(
                    equalTo: container.centerXAnchor
                )
            )
            constraints.append(
                view.centerYAnchor.constraint(
                    equalTo: container.centerYAnchor
                )
            )
        }
        return BKConstraintGroup(constraints).activate()
    }
    
    // MARK: - Sizing
    
    /// Applies fixed width and/or height to the view.
    ///
    /// Only generates constraints for the specified dimensions.
    ///
    /// - Parameters:
    ///   - width: Optional fixed width.
    ///   - height: Optional fixed height.
    /// - Returns: An **activated** `BKConstraintGroup` containing the created constraints.
    ///
    /// Example:
    /// ```swift
    /// avatar.bk.size(width: 44, height: 44)
    /// separator.bk.size(height: 1)
    /// ```
    @discardableResult
    func size(
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) -> BKConstraintGroup {
        view.bk_prepareForAutoLayout()
        var constraints: [NSLayoutConstraint] = []
        if let width {
            constraints.append(
                view.widthAnchor.constraint(
                    equalToConstant: width
                )
            )
        }
        if let height {
            constraints.append(
                view.heightAnchor.constraint(
                    equalToConstant: height
                )
            )
        }
        return BKConstraintGroup(
            constraints
        ).activate()
    }
    
    // MARK: - Aspect Ratio
    
    /// Applies an aspect ratio constraint (height = width * ratio).
    ///
    /// - Parameter ratio: Height/width ratio. Example: `1` for square, `9.0/16.0` for 16:9.
    /// - Returns: An **activated** `BKConstraintGroup` containing the created constraint.
    ///
    /// Example:
    /// ```swift
    /// thumbnail.bk.aspectRatio(9.0/16.0)
    /// ```
    @discardableResult
    func aspectRatio(
        _ ratio: CGFloat = 1
    ) -> BKConstraintGroup {
        view.bk_prepareForAutoLayout()
        let constraint = view.heightAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: ratio
        )
        return BKConstraintGroup(
            [constraint]
        ).activate()
    }
    
    // MARK: - Match Size
    
    /// Matches the size of another view (optionally scaled by a multiplier).
    ///
    /// - Parameters:
    ///   - other: The reference view.
    ///   - multiplier: Scaling multiplier (default 1).
    /// - Returns: An **activated** `BKConstraintGroup` containing the created constraints.
    ///
    /// Example:
    /// ```swift
    /// image.bk.matchSize(to: placeholder)
    /// ```
    @discardableResult
    func matchSize(
        to other: UIView,
        multiplier: CGFloat = 1
    ) -> BKConstraintGroup {
        view.bk_prepareForAutoLayout()
        let width = view.widthAnchor.constraint(
            equalTo: other.widthAnchor,
            multiplier: multiplier
        )
        let height = view.heightAnchor.constraint(
            equalTo: other.heightAnchor,
            multiplier: multiplier
        )
        return BKConstraintGroup(
            [
                width,
                height
            ]
        ).activate()
    }
}
