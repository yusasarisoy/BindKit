//
//  BKAxisTests.swift
//  BindKit
//
//  Created by Yuşa on 3.10.2025.
//

import Testing
@testable import BindKitLayout

@Suite("BKAxis")
struct BKAxisTests {
    
    // MARK: - Tests

    @Test
    func allCases_exist_andSwitchWorks() {
        let axes: [BKAxis] = [
            .horizontal,
            .vertical,
            .both
        ]
        
        for axis in axes {
            switch axis {
            case .horizontal:
                #expect(axis == .horizontal)
            case .vertical:
                #expect(axis == .vertical)
            case .both:
                #expect(axis == .both)
            }
        }
    }
}
