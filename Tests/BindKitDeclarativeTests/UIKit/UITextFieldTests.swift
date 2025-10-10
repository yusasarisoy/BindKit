//
//  UITextFieldTests.swift
//  BindKit
//
//  Created by Yuşa on 10.10.2025.
//

import UIKit
import Testing
@testable import BindKitDeclarative

@MainActor
@Suite("UITextField BindKit (Swift Testing)")
struct UITextFieldBindKitTests {
    
    private func makeTextField() -> UITextField {
        UITextField(
            frame: .init(
                x: 0,
                y: 0,
                width: 200,
                height: 44
            )
        )
    }
    
    @available(iOS 14.0, *)
    @Test("Chaining sets all basic properties correctly")
    func testBasicConfigurationChaining() {
        let textField = makeTextField()
        textField.text("hello")
            .placeholder("mail")
            .font(.systemFont(ofSize: 15, weight: .medium))
            .textColor(.red)
            .tintColor(.blue)
            .keyboard(type: .emailAddress)
            .returnKey(.done)
            .autocorrection(.no)
            .autocapitalization(.none)
            .secure(true)
            .borderStyle(.roundedRect)
        
        #expect(textField.text == "hello")
        #expect(textField.placeholder == "mail")
        #expect(textField.keyboardType == .emailAddress)
        #expect(textField.returnKeyType == .done)
        #expect(textField.autocorrectionType == .no)
        #expect(textField.autocapitalizationType == .none)
        #expect(textField.isSecureTextEntry)
    }
    
    @available(iOS 14.0, *)
    @Test("onEditingChanged and onReturn handlers fire correctly")
    func testEventHandlers() {
        let textField = makeTextField()
        
        var text: String?
        var didReturn = false
        
        textField.onEditingChanged {
            text = $0
        }
        
        textField.onReturn {
            didReturn = true
        }
        
        textField.text = "abc"
        textField.sendActions(for: .editingChanged)
        textField.sendActions(for: .editingDidEndOnExit)
        
        #expect(text == "abc")
        #expect(didReturn)
    }
}
