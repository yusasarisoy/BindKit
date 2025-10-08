//
//  BKChainable.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import Foundation

/// A helper protocol that provides a generic, key-path–based setter for fluent chaining.
///
/// Conforming types can use the `set(_:_: )` function to mutate
/// writable properties using key paths, returning the instance itself.
///
/// Typically used alongside `BKConfigurable` and BindKit's `.bk` syntax:
///
/// ```swift
/// let label = UILabel().bk
///     .set(\.textColor, .secondaryLabel)
///     .set(\.textAlignment, .center)
/// ```
///
/// This pattern is particularly useful for less commonly configured
/// properties that don’t have dedicated fluent methods.
public protocol BKChainable: BKConfigurable { }

public extension BKChainable where Self: AnyObject {
    
    /// Assigns a value to a writable key path on the current instance.
    ///
    /// ```swift
    /// label.set(\.numberOfLines, 2)
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: The reference-writable key path to the property you want to modify.
    ///   - value: The new value to assign.
    /// - Returns: The same instance (`Self`), enabling fluent chaining.
    @discardableResult
    func set<Value>(
        _ keyPath: ReferenceWritableKeyPath<Self, Value>,
        _ value: Value
    ) -> Self {
        self[keyPath: keyPath] = value
        return self
    }
}
