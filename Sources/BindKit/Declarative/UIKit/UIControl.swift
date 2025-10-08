//
//  UIControl.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

public extension UIControl {
    
    // MARK: - Event Binding
    
    /// Adds a closure-based target for the specified control event(s).
    ///
    /// This method brings a Swift-native API to UIKit’s traditional target–action pattern,
    /// allowing you to attach event handlers using closures rather than selectors.
    ///
    /// ```swift
    /// let button = UIButton(type: .system).bk
    ///     .title("Send")
    ///     .onTap { [weak self] _ in
    ///         self?.submit()
    ///     }
    /// ```
    ///
    /// - Parameters:
    ///   - events: The control event(s) to listen for.
    ///     Defaults to `.touchUpInside`.
    ///   - action: A closure that receives the triggering `UIControl` instance.
    /// - Returns: `Self` for fluent chaining.
    ///
    /// - Important: Each call to `onTap` adds an additional target.
    ///   If you want to remove previous handlers, call
    ///   `removeTarget(_:action:for:)` manually.
    ///
    /// - Note: This method is annotated with `@MainActor`
    ///   because UIKit control events must run on the main thread.
    @MainActor
    @discardableResult
    func onTap(
        for events: UIControl.Event = .touchUpInside,
        _ action: @escaping (UIControl) -> Void
    ) -> Self {
        
        let trampoline = _BKActionTrampoline(action: action)
        
        // Store the trampoline using an associated object.
        // The control retains it for the lifetime of the control.
        objc_setAssociatedObject(
            self,
            &_BKAssocKeys.trampoline,
            trampoline,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
        
        addTarget(
            trampoline,
            action: #selector(_BKActionTrampoline.fire(_:)),
            for: events
        )
        
        return self
    }
}
