//
//  BKTarget.swift
//
//
//  Created by Yuşa on 1.10.2025.
//

import UIKit

// MARK: - BKTarget

/// A target to pin against, described in a sentence-like way.
public enum BKTarget {
    /// Container's safe area.
    case safeArea(of: UIView)
    /// Container's layout margins guide.
    case margins(of: UIView)
    /// Raw container view (equivalent to `.margins(of:)` with zeroed margins).
    case view(UIView)
    
    /// Resolves to a concrete container and layout guide.
    ///
    /// - Returns: The container view, the layout guide to use, and whether the container's margins should be zeroed.
    @MainActor
    internal func resolved() -> (
        container: UIView,
        guide: UILayoutGuide,
        zeroMargins: Bool
    ) {
        switch self {
        case .safeArea(let view):
            return (
                view,
                view.safeAreaLayoutGuide,
                false
            )
        case .margins(let view):
            return (
                view,
                view.layoutMarginsGuide,
                true
            )
        case .view(let view):
            return (
                view,
                view.layoutMarginsGuide,
                true
            )
        }
    }
}
