//
//  BKEdge.swift
//  BindKit
//
//  Created by Yuşa on 2.10.2025.
//

// MARK: - BKEdge

/// Represents a single edge for pinning or aligning constraints.
///
/// Combine multiple edges (e.g., `[.top, .leading, .trailing]`) to
/// create a group of constraints.
public enum BKEdge {
    /// Top edge.
    case top
    /// Leading edge (adapts with layout direction).
    case leading
    /// Bottom edge.
    case bottom
    /// Trailing edge (adapts with layout direction).
    case trailing
}
