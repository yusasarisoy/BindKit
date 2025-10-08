//
//  BKConstraintGroup.swift
//  BindKit
//
//  Created by Yuşa on 2.10.2025.
//

import UIKit

// MARK: - BKConstraintGroup

/// A group of constraints created by BindKit DSL methods.
///
/// Each DSL method returns a `BKConstraintGroup` which is automatically activated.
/// You can later deactivate or re-activate the group as needed.
///
/// Example:
/// ```swift
/// let group = titleLabel.bk.pinEdges(to: view, safe: true, insets: .all(16))
/// group.deactivate()
/// group.activate().priority(.defaultHigh)
/// ```
@MainActor
public final class BKConstraintGroup {
    
    // MARK: - Properties
    
    /// Underlying constraints in this group.
    public private(set) var constraints: [NSLayoutConstraint] = []
    
    // MARK: - Initialization
    
    /// Initializes a new group.
    ///
    /// - Parameter constraints: Initial list of constraints to include.
    /// - Returns: A new `BKConstraintGroup` instance containing the provided constraints.
    public init(_ constraints: [NSLayoutConstraint] = []) {
        self.constraints = constraints
    }
    
    // MARK: - Mutation
    
    /// Appends new constraints to this group (does not automatically activate them).
    ///
    /// - Parameter newConstraints: Constraints to append.
    public func append(_ newConstraints: [NSLayoutConstraint]) {
        constraints.append(contentsOf: newConstraints)
    }
    
    // MARK: - Activation
    
    /// Activates all constraints in this group.
    ///
    /// - Returns: The same `BKConstraintGroup` instance, allowing for method chaining.
    ///
    /// Example:
    /// ```swift
    /// group.activate().priority(.defaultHigh)
    /// ```
    @discardableResult
    public func activate() -> Self {
        NSLayoutConstraint.activate(constraints)
        return self
    }
    
    /// Deactivates all constraints in this group.
    ///
    /// - Returns: The same `BKConstraintGroup` instance, allowing for method chaining.
    ///
    /// Example:
    /// ```swift
    /// group.deactivate()
    /// ```
    @discardableResult
    public func deactivate() -> Self {
        NSLayoutConstraint.deactivate(constraints)
        return self
    }
    
    // MARK: - Priority
    
    /// Updates the priority of all constraints in this group.
    ///
    /// - Parameter priority: New `UILayoutPriority` to apply.
    /// - Returns: The same `BKConstraintGroup` instance, allowing for method chaining.
    ///
    /// Example:
    /// ```swift
    /// group.priority(.defaultLow)
    /// ```
    @discardableResult
    public func priority(_ priority: UILayoutPriority) -> Self {
        constraints.forEach { $0.priority = priority }
        return self
    }
}
