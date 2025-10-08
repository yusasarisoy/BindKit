//
//  NSObject+BK.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

// MARK: - NSObject: BKConfigurable & BKChainable

/// Extends all `NSObject` subclasses to adopt
/// the BindKit configuration and chainable APIs.
///
/// This makes all UIKit and custom `NSObject`-based types
/// automatically support `.bk` and `set` style helpers.
extension NSObject: BKConfigurable {}

extension NSObject: BKChainable {}
