//
//  BKEdges.swift
//  BindKit
//
//  Created by Yuşa on 2.10.2025.
//

// MARK: - BKEdges

/// A grouped edge selector for more sentence-like APIs.
public enum BKEdges {
    /// All four edges: top, leading, bottom, trailing.
    case all
    /// Horizontal pair: leading & trailing.
    case horizontally
    /// Vertical pair: top & bottom.
    case vertically
    /// Custom list of edges (e.g., `[.top, .leading]`).
    case custom([BKEdge])
    
    /// Expands to individual edges.
    ///
    /// - Returns: The concrete list of `BKEdge` represented by the case.
    public func unpacked() -> [BKEdge] {
        switch self {
        case .all:
            return [
                .top,
                .leading,
                .bottom,
                .trailing
            ]
        case .horizontally:
            return [
                .leading,
                .trailing
            ]
        case .vertically:
            return [
                .top,
                .bottom
            ]
        case .custom(let list):
            return list
        }
    }
}
