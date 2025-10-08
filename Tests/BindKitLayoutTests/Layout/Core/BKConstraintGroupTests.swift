//
//  BKConstraintGroupTests.swift
//  BindKit
//
//  Created by Yuşa on 3.10.2025.
//

import Testing
import UIKit
@testable import BindKitLayout

@Suite("BKConstraintGroup")
@MainActor
struct BKConstraintGroupTests {
    
    // MARK: - Properties

    private let container: UIView = .init()
    private let subview: UIView = .init()

    // MARK: - Initialization
    
    init() {
        container.addSubview(subview)
    }

    // MARK: - Helpers

    private func contains(_ constraint: NSLayoutConstraint, in array: [NSLayoutConstraint]) -> Bool {
        array.contains { $0 === constraint }
    }

    // MARK: - Tests

    @Test("Initializer with constraints adds them and constraints are stored")
    func testInitWithConstraints() {
        let constraint = subview.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        let group = BKConstraintGroup([constraint])

        #expect(group.constraints.count == 1)
        #expect(group.constraints.first === constraint)
    }

    @Test("Append adds constraints without activating")
    func testAppendConstraints() {
        let constraint1 = subview.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        let constraint2 = subview.trailingAnchor.constraint(equalTo: container.trailingAnchor)

        let group = BKConstraintGroup([constraint1])
        group.append([constraint2])

        #expect(group.constraints.count == 2)
        #expect(contains(constraint1, in: group.constraints))
        #expect(contains(constraint2, in: group.constraints))
        #expect(constraint1.isActive == false && constraint2.isActive == false)
    }

    @Test("Activate() activates all")
    func testActivateConstraints() {
        let constraint = subview.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        let group = BKConstraintGroup([constraint])

        group.activate()

        #expect(constraint.isActive == true)
    }

    @Test("Deactivate() deactivates all")
    func testDeactivateConstraints() {
        let constraint = subview.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        let group = BKConstraintGroup([constraint])

        group.activate()
        #expect(constraint.isActive == true)

        group.deactivate()
        #expect(constraint.isActive == false)
    }

    @Test("priority(_:) updates all")
    func testSetPriority() {
        let constraint1 = subview.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        let constraint2 = subview.trailingAnchor.constraint(equalTo: container.trailingAnchor)

        let group = BKConstraintGroup([constraint1, constraint2])
        group.priority(.defaultLow)

        #expect(constraint1.priority == .defaultLow)
        #expect(constraint2.priority == .defaultLow)
    }

    @Test("Method chaining works (activate -> priority -> deactivate)")
    func testMethodChaining() {
        let constraint = subview.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        let group = BKConstraintGroup([constraint])

        group.activate()
             .priority(.defaultHigh)
             .deactivate()

        #expect(constraint.priority == .defaultHigh)
        #expect(constraint.isActive == false)
    }
}
