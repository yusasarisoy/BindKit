//
//  UITextField.swift
//  BindKit
//
//  Created by Yuşa on 10.10.2025.
//

import UIKit

/// A fluent interface for configuring `UITextField` instances.
///
/// This extension adds chainable methods that make it easier
/// to configure common text field properties in a concise, readable way.
///
/// Example:
/// ```swift
/// let emailField = UITextField()
///     .placeholder("Email")
///     .font(.systemFont(ofSize: 16))
///     .textColor(.label)
///     .keyboard(type: .emailAddress)
///     .returnKey(.done)
///     .leftPadding(12)
///     .rightPadding(12)
///     .onEditingChanged { text in
///         print("Typing:", text)
///     }
///     .onReturn {
///         print("Return pressed")
///     }
/// ```
@available(iOS 14.0, *)
@MainActor
public extension UITextField {
    
    // MARK: - Text & Placeholder
    
    /// Sets the text value of the text field.
    ///
    /// - Parameter value: The string to display.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func text(_ value: String?) -> Self {
        text = value
        return self
    }
    
    /// Sets the placeholder text displayed when the field is empty.
    ///
    /// - Parameter value: The placeholder string.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func placeholder(_ value: String?) -> Self {
        placeholder = value
        return self
    }
    
    // MARK: - Font & Colors
    
    /// Sets the font of the text.
    ///
    /// - Parameter value: A `UIFont` instance.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func font(_ value: UIFont) -> Self {
        font = value
        return self
    }
    
    /// Sets the text color.
    ///
    /// - Parameter value: A `UIColor` value.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func textColor(_ value: UIColor) -> Self {
        textColor = value
        return self
    }
    
    /// Sets the tint color, which affects the cursor and selection handles.
    ///
    /// - Parameter value: A `UIColor` value.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func tintColor(_ value: UIColor) -> Self {
        tintColor = value
        return self
    }
    
    // MARK: - Behavior
    
    /// Sets the keyboard type for the text field.
    ///
    /// - Parameter type: A `UIKeyboardType` value.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func keyboard(type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }
    
    /// Sets the return key type for the keyboard.
    ///
    /// - Parameter type: A `UIReturnKeyType` value.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func returnKey(_ type: UIReturnKeyType) -> Self {
        returnKeyType = type
        return self
    }
    
    /// Sets the autocorrection behavior.
    ///
    /// - Parameter type: A `UITextAutocorrectionType` value.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func autocorrection(_ type: UITextAutocorrectionType) -> Self {
        autocorrectionType = type
        return self
    }
    
    /// Sets the autocapitalization behavior.
    ///
    /// - Parameter type: A `UITextAutocapitalizationType` value.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func autocapitalization(_ type: UITextAutocapitalizationType) -> Self {
        autocapitalizationType = type
        return self
    }
    
    /// Enables or disables secure text entry (useful for password fields).
    ///
    /// - Parameter isSecure: A Boolean value that indicates whether the field hides the text. Default is `true`.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func secure(_ isSecure: Bool = true) -> Self {
        isSecureTextEntry = isSecure
        return self
    }
    
    // MARK: - Border & Style
    
    /// Sets the border style of the text field.
    ///
    /// - Parameter style: A `UITextField.BorderStyle` value.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func borderStyle(_ style: UITextField.BorderStyle) -> Self {
        borderStyle = style
        return self
    }
    
    // MARK: - Padding
    
    /// Adds left padding by inserting an invisible view.
    ///
    /// - Parameter width: The width of the padding, in points.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func leftPadding(_ width: CGFloat) -> Self {
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        spacer.isUserInteractionEnabled = false
        leftView = spacer
        leftViewMode = .always
        return self
    }
    
    /// Adds right padding by inserting an invisible view.
    ///
    /// - Parameter width: The width of the padding, in points.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func rightPadding(_ width: CGFloat) -> Self {
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        spacer.isUserInteractionEnabled = false
        rightView = spacer
        rightViewMode = .always
        return self
    }
    
    // MARK: - Events (Closure-Based)
    
    /// A private namespace that defines unique `UIAction.Identifier`
    /// values for internal text field event handlers.
    ///
    /// These identifiers ensure that `UIAction` closures can be safely
    /// removed and replaced without adding duplicate event listeners.
    ///
    /// Example:
    /// ```swift
    /// // Removes the existing `.editingChanged` action (if any)
    /// textField.removeAction(identifiedBy: BKActionID.editingChanged, for: .editingChanged)
    ///
    /// // Adds a new one with the same identifier
    /// let action = UIAction(identifier: BKActionID.editingChanged) { [weak textField] _ in
    ///     print(textField?.text ?? "")
    /// }
    /// textField.addAction(action, for: .editingChanged)
    /// ```
    ///
    /// Using consistent identifiers prevents multiple identical
    /// actions from stacking up on the same control event.
    private enum BKActionID {
        /// Identifier for the `.editingChanged` UIControl event.
        static let editingChanged = UIAction.Identifier("bindkit.textfield.editingChanged")
        
        /// Identifier for the `.editingDidEndOnExit` (Return key pressed) UIControl event.
        static let returnPressed  = UIAction.Identifier("bindkit.textfield.returnPressed")
    }
    
    /// Registers a closure to be executed whenever the text field’s text changes.
    ///
    /// - Parameter handler: A closure that receives the current text value.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func onEditingChanged(_ handler: @escaping (String) -> Void) -> Self {
        removeAction(identifiedBy: BKActionID.editingChanged, for: .editingChanged)
        
        let action = UIAction(identifier: BKActionID.editingChanged) { [weak self] _ in
            handler(self?.text ?? "")
        }
        addAction(action, for: .editingChanged)
        return self
    }
    
    /// Registers a closure to be executed when the Return key is pressed.
    ///
    /// - Parameter handler: A closure with no parameters.
    /// - Returns: The text field, enabling method chaining.
    @discardableResult
    func onReturn(_ handler: @escaping () -> Void) -> Self {
        removeAction(identifiedBy: BKActionID.returnPressed, for: .editingDidEndOnExit)
        
        let action = UIAction(identifier: BKActionID.returnPressed) { _ in
            handler()
        }
        addAction(action, for: .editingDidEndOnExit)
        return self
    }
}
