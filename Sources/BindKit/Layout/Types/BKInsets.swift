//
//  BKInsets.swift
//  BindKit
//
//  Created by Yuşa on 2.10.2025.
//

import Foundation

// MARK: - BKInsets

/// Directional insets model, fully RTL (right-to-left) aware.
///
/// Use this type to express spacing around a view or guide where
/// `leading` and `trailing` automatically adapt to the current
/// layout direction (LTR vs RTL).
public struct BKInsets {
    
    // MARK: - Properties
    
    /// Top spacing.
    public var top: CGFloat
    
    /// Leading spacing (left in LTR, right in RTL).
    public var leading: CGFloat
    
    /// Bottom spacing.
    public var bottom: CGFloat
    
    /// Trailing spacing (right in LTR, left in RTL).
    public var trailing: CGFloat
    
    // MARK: - Initialization
    
    /// Creates a new set of insets.
    ///
    /// - Parameters:
    ///   - top: Top spacing.
    ///   - leading: Leading spacing (adapts with layout direction).
    ///   - bottom: Bottom spacing.
    ///   - trailing: Trailing spacing (adapts with layout direction).
    public init(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
    
    // MARK: - Factory
    
    /// Creates uniform insets on all edges.
    ///
    /// - Parameter v: Value to apply to all edges.
    /// - Returns: A `BKInsets` with each edge set to `v`.
    public static func all(_ value: CGFloat) -> BKInsets {
        .init(
            top: value,
            leading: value,
            bottom: value,
            trailing: value
        )
    }
    
    /// Zero insets.
    ///
    /// - Returns: A `BKInsets` with all edges set to `0`.
    public static var zero: BKInsets {
        .init()
    }
}
