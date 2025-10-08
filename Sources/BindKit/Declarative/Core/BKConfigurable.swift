//
//  BKConfigurable.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import Foundation

// MARK: - BKConfigurable

/// A lightweight marker protocol that enables BindKit's declarative `.bk` configuration syntax.
///
/// Conforming to `BKConfigurable` allows both reference and value types
/// to expose a uniform `.bk` interface for inline configuration and chaining.
///
/// For example:
/// ```swift
/// private let titleLabel = UILabel().bk {
///     $0.font = .systemFont(ofSize: 14, weight: .medium)
///     $0.textColor = .label
/// }
///
/// // or declarative chaining
/// private let titleLabel = UILabel().bk
///     .font(.systemFont(ofSize: 14))
///     .textColor(.label)
/// ```
public protocol BKConfigurable { }


// MARK: - Reference Types (Class-based)

public extension BKConfigurable where Self: AnyObject {
    
    /// Configures the current instance using an inline closure.
    ///
    /// This is the core of BindKit's declarative style:
    /// it allows inline configuration of objects, returning the same instance.
    ///
    /// ```swift
    /// UILabel().bk {
    ///     $0.text = "Hello"
    ///     $0.textColor = .label
    /// }
    /// ```
    ///
    /// - Parameter configure: A closure that receives the instance for configuration.
    /// - Returns: The same instance, allowing further chaining.
    @discardableResult
    func bk(_ configure: (Self) -> Void) -> Self {
        configure(self)
        return self
    }
    
    /// Provides a semantic entry point for fluent chaining.
    ///
    /// The `.bk` property returns the same instance,
    /// serving as a namespace marker that improves readability.
    ///
    /// ```swift
    /// UILabel().bk
    ///     .font(.systemFont(ofSize: 12))
    ///     .textColor(.secondaryLabel)
    /// ```
    ///
    /// - Returns: The same instance (`Self`), allowing direct chaining.
    var bk: Self { self }
}


// MARK: - Value Types (Structs & Enums)

public extension BKConfigurable {
    
    /// Configures a copy of the current value using an inline closure.
    ///
    /// This enables the same `.bk` syntax for value types like structs.
    /// The closure mutates a copy and returns the modified version.
    ///
    /// ```swift
    /// let rect = CGRect.zero.bk {
    ///     $0.size = CGSize(width: 100, height: 100)
    /// }
    /// ```
    ///
    /// - Parameter mutate: A closure that receives an inout copy for mutation.
    /// - Returns: A new, mutated copy of the value.
    func bk(_ mutate: (inout Self) -> Void) -> Self {
        var copy = self
        mutate(&copy)
        return copy
    }
}
