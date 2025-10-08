//
//  BKProxy.swift
//  BindKit
//
//  Created by Yuşa on 2.10.2025.
//

import UIKit

// MARK: - BKProxy

/// DSL entry point, accessed via `view.bk`.
///
/// The proxy exposes a minimal, Swifty API to create and manage Auto Layout
/// constraints without touching `NSLayoutConstraint` directly.
@MainActor
public struct BKProxy {
    
    // MARK: - Properties
    
    /// The view this proxy operates on.
    /// Exposed as `internal` so that BindKit’s own extensions (like Expressive API)
    /// can access it. End users are not expected to use this directly.
    let view: UIView
    
    // MARK: - Initialization
    
    /// Creates a new proxy for the given view.
    ///
    /// - Parameter view: The target `UIView`.
    /// - Returns: A `BKProxy` bound to `view`.
    init(_ view: UIView) {
        self.view = view
    }
}

public extension BKProxy {
    
    // MARK: - Add / Added
    
    /// Adds the current view to the given superview, reading like English.
    ///
    /// Example:
    /// ```swift
    /// title.bk.added(to: header)
    /// ```
    ///
    /// - Parameters:
    ///   - superview: The superview to add into.
    ///   - configure: Optional configuration block executed after adding.
    /// - Returns: The same `BKProxy` to allow further chaining in a sentence-like style.
    @discardableResult
    func added(
        to superview: UIView,
        configure: ((UIView) -> Void)? = nil
    ) -> BKProxy {
        _ = add(
            to: superview,
            configure: configure
        )
        return self
    }
    
    // MARK: - Pin / Pinned
    
    /// Pins selected edges to a target (safe area / margins / raw view), reading like a sentence.
    ///
    /// Example:
    /// ```swift
    /// content.bk.pinned(.all, to: .safeArea(of: view), insets: .all(16))
    /// toolbar.bk.pinned(.horizontal, to: .margins(of: view))
    /// ```
    ///
    /// - Parameters:
    ///   - edges: The grouped edges to pin (e.g., `.all`, `.horizontal`, `.custom([.top])`).
    ///   - target: The pinning target (`.safeArea(of:)`, `.margins(of:)`, `.view(_)`).
    ///   - insets: Directional insets to apply (default `.zero`).
    /// - Returns: The same `BKProxy` for chaining additional calls.
    @discardableResult
    func pinned(
        _ edges: BKEdges,
        to target: BKTarget,
        insets: BKInsets = .zero
    ) -> BKProxy {
        let (container, guide, zeroMargins) = target.resolved()
        if zeroMargins {
            container.layoutMargins = .zero
        }
        view.bk_prepareForAutoLayout()
        
        var constraints: [NSLayoutConstraint] = []
        for edge in edges.unpacked() {
            switch edge {
            case .top:
                constraints.append(
                    view.topAnchor.constraint(
                        equalTo: guide.topAnchor,
                        constant: insets.top
                    )
                )
            case .leading:
                constraints.append(
                    view.leadingAnchor.constraint(
                        equalTo: guide.leadingAnchor,
                        constant: insets.leading
                    )
                )
            case .bottom:
                constraints.append(
                    view.bottomAnchor.constraint(
                        equalTo: guide.bottomAnchor,
                        constant: -insets.bottom
                    )
                )
            case .trailing:
                constraints.append(
                    view.trailingAnchor.constraint(
                        equalTo: guide.trailingAnchor,
                        constant: -insets.trailing
                    )
                )
            }
        }
        
        BKConstraintGroup(constraints).activate()
        return self
    }
    
    /// Shorthand that assumes the view is already in a superview
    /// and pins to that superview’s **safe area**, which is a sensible default.
    ///
    /// Example:
    /// ```swift
    /// content.bk.pinnedToSuperview(.all, insets: .all(12))
    /// ```
    ///
    /// - Parameters:
    ///   - edges: The grouped edges to pin.
    ///   - insets: Insets to apply.
    /// - Returns: The same `BKProxy` for chaining.
    @discardableResult
    func pinnedToSuperview(
        _ edges: BKEdges = .all,
        insets: BKInsets = .zero
    ) -> BKProxy {
        guard let superview = view.superview else {
            assertionFailure("pinnedToSuperview: superview not found. Call added(to:) first.")
            return self
        }
        return pinned(
            edges,
            to: .safeArea(
                of: superview
            ),
            insets: insets
        )
    }
    
    // MARK: - Align / Aligned
    
    /// Aligns the view’s edges to another view, expressed as a sentence.
    ///
    /// Example:
    /// ```swift
    /// title.bk.aligned(.horizontal, with: container, insets: .all(16))
    /// caption.bk.aligned(.custom([.leading, .trailing]), with: title)
    /// ```
    ///
    /// - Parameters:
    ///   - edges: Grouped edges to align (e.g., `.horizontal` → leading & trailing).
    ///   - other: The target view to align with.
    ///   - insets: Insets to apply while aligning.
    /// - Returns: The same `BKProxy` for chaining.
    @discardableResult
    func aligned(
        _ edges: BKEdges,
        with other: UIView,
        insets: BKInsets = .zero
    ) -> BKProxy {
        view.bk_prepareForAutoLayout()
        var constraints: [NSLayoutConstraint] = []
        for edge in edges.unpacked() {
            switch edge {
            case .top:
                constraints.append(
                    view.topAnchor.constraint(
                        equalTo: other.topAnchor,
                        constant: insets.top
                    )
                )
            case .leading:
                constraints.append(
                    view.leadingAnchor.constraint(
                        equalTo: other.leadingAnchor,
                        constant: insets.leading
                    )
                )
            case .bottom:
                constraints.append(
                    view.bottomAnchor.constraint(
                        equalTo: other.bottomAnchor,
                        constant: -insets.bottom
                    )
                )
            case .trailing:
                constraints.append(
                    view.trailingAnchor.constraint(
                        equalTo: other.trailingAnchor,
                        constant: -insets.trailing
                    )
                )
            }
        }
        BKConstraintGroup(constraints).activate()
        return self
    }
    
    // MARK: - Center / Centered
    
    /// Centers the view, as in plain English.
    ///
    /// Example:
    /// ```swift
    /// loader.bk.centered(in: container)                 // both axes
    /// badge.bk.centered(in: header, along: .horizontal) // centerX only
    /// ```
    ///
    /// - Parameters:
    ///   - container: The container to center in. If `nil`, uses superview.
    ///   - along: Which axes to center along (default `.both`).
    /// - Returns: The same `BKProxy` for chaining.
    @discardableResult
    func centered(
        in container: UIView? = nil,
        along: BKAxis = .both
    ) -> BKProxy {
        let parent = container ?? view.superview
        guard let parent else {
            assertionFailure("centered: container/superview not found. Call added(to:) first or pass a container.")
            return self
        }
        view.bk_prepareForAutoLayout()
        var constraints: [NSLayoutConstraint] = []
        switch along {
        case .horizontal:
            constraints.append(
                view.centerXAnchor.constraint(
                    equalTo: parent.centerXAnchor
                )
            )
        case .vertical:
            constraints.append(
                view.centerYAnchor.constraint(
                    equalTo: parent.centerYAnchor
                )
            )
        case .both:
            constraints.append(
                contentsOf: [
                    view.centerXAnchor.constraint(
                        equalTo: parent.centerXAnchor
                    ),
                    view.centerYAnchor.constraint(
                        equalTo: parent.centerYAnchor
                    )
                ]
            )
        }
        BKConstraintGroup(constraints).activate()
        return self
    }
    
    // MARK: - Size / Sized
    
    /// Applies fixed width and/or height in a sentence-like fashion.
    ///
    /// Example:
    /// ```swift
    /// avatar.bk.sized(width: 44, height: 44)
    /// hairline.bk.sized(height: 1)
    /// ```
    ///
    /// - Parameters:
    ///   - width: Optional fixed width.
    ///   - height: Optional fixed height.
    /// - Returns: The same `BKProxy` for chaining.
    @discardableResult
    func sized(
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) -> BKProxy {
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
        BKConstraintGroup(constraints).activate()
        return self
    }
    
    // MARK: - Aspect / Aspect-Ratio
    
    /// Makes the view keep an aspect ratio, like:
    /// “thumbnail.bk.withAspect(ratio: 9.0/16.0)”.
    ///
    /// - Parameter ratio: Height/width ratio (e.g., `1` for square).
    /// - Returns: The same `BKProxy` for chaining.
    @discardableResult
    func withAspect(
        ratio: CGFloat = 1
    ) -> BKProxy {
        view.bk_prepareForAutoLayout()
        let constraint = view.heightAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: ratio
        )
        BKConstraintGroup([constraint]).activate()
        return self
    }
    
    // MARK: - Match / Matched Size
    
    /// Matches the size of another view (optionally scaled).
    ///
    /// Example:
    /// ```swift
    /// image.bk.matchedSize(with: placeholder, multiplier: 0.75)
    /// ```
    ///
    /// - Parameters:
    ///   - other: The reference view to match.
    ///   - multiplier: Scaling multiplier (default `1`).
    /// - Returns: The same `BKProxy` for chaining.
    @discardableResult
    func matchedSize(
        with other: UIView,
        multiplier: CGFloat = 1
    ) -> BKProxy {
        view.bk_prepareForAutoLayout()
        let width = view.widthAnchor.constraint(
            equalTo: other.widthAnchor,
            multiplier: multiplier
        )
        let height = view.heightAnchor.constraint(
            equalTo: other.heightAnchor,
            multiplier: multiplier
        )
        BKConstraintGroup([width, height]).activate()
        return self
    }
}
