//
//  UIControl+BKActions.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

// MARK: - UIControl onTap (closure-based)

/// A trampoline object that bridges Objective-C selectors to Swift closures.
///
/// UIKit’s target–action pattern requires an Objective-C selector,
/// but Swift closures cannot be used directly.
/// This helper stores the closure and exposes a selector that calls it.
///
/// Marked `@MainActor` since control events are always delivered on the main thread.
@MainActor
final class _BKActionTrampoline: NSObject {
    /// The closure to be executed when the control event fires.
    let action: (UIControl) -> Void
    
    /// Creates a new trampoline with a closure to execute.
    /// - Parameter action: The closure to run when the event is triggered.
    init(action: @escaping (UIControl) -> Void) { self.action = action }
    
    /// Called by UIKit via selector when the event occurs.
    /// - Parameter sender: The control that triggered the event.
    @objc func fire(_ sender: UIControl) { action(sender) }
}

/// Associated object keys used for runtime storage.
///
/// Uses the standard “address-based `UInt8` static var” pattern to provide
/// a unique memory address as the key for Objective-C association.
///
/// Annotated with `@MainActor` to isolate mutable global state on the main thread.
@MainActor
enum _BKAssocKeys {
    /// Key used to store the `_BKActionTrampoline` on a control instance.
    static var trampoline: UInt8 = 0
}
