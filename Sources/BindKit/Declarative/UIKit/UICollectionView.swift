//
//  UICollectionView.swift
//  BindKit
//
//  Created by Yuşa on 8.10.2025.
//

import UIKit

public extension UICollectionView {
    
    // MARK: - Basics
    
    /// Applies a new layout to the collection view.
    ///
    /// Internally calls `setCollectionViewLayout(_:animated:)`.
    ///
    /// - Parameters:
    ///   - layout: The layout object to apply.
    ///   - animated: Pass `true` to animate the layout change; otherwise, `false`. Default is `false`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func collectionViewLayout(
        _ layout: UICollectionViewLayout,
        animated: Bool = false
    ) -> Self {
        setCollectionViewLayout(
            layout,
            animated: animated
        )
        return self
    }
    
    /// Sets the content inset of the collection view.
    ///
    /// Mirrors `contentInset` assignment.
    ///
    /// - Parameter contentInset: Insets to apply to the scrollable content.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func contentInset(_ contentInset: UIEdgeInsets) -> Self {
        self.contentInset = contentInset
        return self
    }
    
    /// Sets the scroll indicator insets of the collection view.
    ///
    /// Mirrors `scrollIndicatorInsets` assignment.
    ///
    /// - Parameter scrollIndicatorInsets: Insets for the scroll indicators.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func scrollIndicatorInsets(_ scrollIndicatorInsets: UIEdgeInsets) -> Self {
        self.scrollIndicatorInsets = scrollIndicatorInsets
        return self
    }
    
    /// Enables or disables cell selection.
    ///
    /// Mirrors `allowsSelection` assignment.
    ///
    /// - Parameter allowsSelection: `true` to allow selection; otherwise, `false`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func allowsSelection(_ allowsSelection: Bool) -> Self {
        self.allowsSelection = allowsSelection
        return self
    }
    
    /// Enables or disables paging.
    ///
    /// Mirrors `isPagingEnabled` assignment.
    ///
    /// - Parameter isPagingEnabled: `true` to enable paging; otherwise, `false`.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func isPagingEnabled(_ isPagingEnabled: Bool) -> Self {
        self.isPagingEnabled = isPagingEnabled
        return self
    }
    
    // MARK: - DataSource & Delegate
    
    /// Sets the data source of the collection view.
    ///
    /// - Important: Do **not** retain the data source strongly to avoid reference cycles if it also retains the collection view.
    ///
    /// - Parameter dataSource: The data source object. Pass `nil` to unset.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func dataSource(_ dataSource: UICollectionViewDataSource?) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    /// Sets the delegate of the collection view.
    ///
    /// - Important: Do **not** retain the delegate strongly to avoid reference cycles if it also retains the collection view.
    ///
    /// - Parameter delegate: The delegate object. Pass `nil` to unset.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func delegate(_ delegate: UICollectionViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    // MARK: - Register helpers
    
    /// Registers a cell class for reuse.
    ///
    /// Uses `String(describing: cellClass)` as the reuse identifier when `reuseIdentifier` is `nil`.
    ///
    /// - Parameters:
    ///   - cellClass: The cell `AnyClass` (e.g., `MyCell.self`).
    ///   - reuseIdentifier: Optional reuse identifier. If omitted, the class name string is used.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func registerCell(
        _ cellClass: AnyClass,
        reuseIdentifier: String? = nil
    ) -> Self {
        register(
            cellClass,
            forCellWithReuseIdentifier: reuseIdentifier ?? String(describing: cellClass)
        )
        return self
    }
    
    /// Registers a nib-based cell for reuse.
    ///
    /// - Parameters:
    ///   - nib: The nib containing the cell.
    ///   - reuseIdentifier: The reuse identifier to associate with the cell in the nib.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func registerCell(
        nib: UINib,
        reuseIdentifier: String
    ) -> Self {
        register(
            nib,
            forCellWithReuseIdentifier: reuseIdentifier
        )
        return self
    }
    
    /// Registers a supplementary **header** view class.
    ///
    /// Uses `String(describing: viewClass)` as the reuse identifier when `reuseIdentifier` is `nil`.
    ///
    /// - Parameters:
    ///   - viewClass: The reusable view class (e.g., `MyHeaderView.self`).
    ///   - reuseIdentifier: Optional reuse identifier. If omitted, the class name string is used.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func registerHeader(
        _ viewClass: AnyClass,
        reuseIdentifier: String? = nil
    ) -> Self {
        register(
            viewClass,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: reuseIdentifier ?? String(describing: viewClass)
        )
        return self
    }
    
    /// Registers a supplementary **footer** view class.
    ///
    /// Uses `String(describing: viewClass)` as the reuse identifier when `reuseIdentifier` is `nil`.
    ///
    /// - Parameters:
    ///   - viewClass: The reusable view class (e.g., `MyFooterView.self`).
    ///   - reuseIdentifier: Optional reuse identifier. If omitted, the class name string is used.
    /// - Returns: `Self` to allow fluent chaining.
    @discardableResult
    func registerFooter(
        _ viewClass: AnyClass,
        reuseIdentifier: String? = nil
    ) -> Self {
        register(
            viewClass,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: reuseIdentifier ?? String(describing: viewClass)
        )
        return self
    }
    
    // MARK: - Dequeue sugar (generic)
    
    /// Dequeues a reusable cell of type `Element`.
    ///
    /// Convenience sugar around `dequeueReusableCell(withReuseIdentifier:for:)` that:
    ///  - Defaults the reuse identifier to `String(describing: Element.self)` when not provided.
    ///  - Force-casts the dequeued cell to `Element`. Make sure the registration matches the generic type.
    ///
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell.
    ///   - type: The cell type you expect. Defaults to `Element.self` and is used only for clarity at call site.
    ///   - reuseIdentifier: Optional reuse identifier. If omitted, `String(describing: Element.self)` is used.
    /// - Returns: A cell instance of type `Element`.
    /// - Note: If the dequeued cell cannot be cast to `Element`, this will `fatalError` at runtime due to the force-cast (`as!`).
    func dequeueCell<Element: UICollectionViewCell>(
        for indexPath: IndexPath,
        as type: Element.Type = Element.self,
        reuseIdentifier: String? = nil
    ) -> Element {
        let id = reuseIdentifier ?? String(describing: Element.self)
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(
            withReuseIdentifier: id,
            for: indexPath
        ) as! Element
    }
    
    /// Dequeues a reusable supplementary view of type `Element`.
    ///
    /// Convenience sugar around `dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)` that:
    ///  - Defaults the reuse identifier to `String(describing: Element.self)` when not provided.
    ///  - Force-casts the dequeued view to `Element`. Ensure registration matches the generic type and kind.
    ///
    /// - Parameters:
    ///   - kind: The kind of supplementary view to retrieve. For example:
    ///       - `UICollectionView.elementKindSectionHeader`
    ///       - `UICollectionView.elementKindSectionFooter`
    ///   - indexPath: The index path specifying the location of the supplementary view.
    ///   - type: The reusable view type you expect. Defaults to `Element.self` and is used only for clarity at call site.
    ///   - reuseIdentifier: Optional reuse identifier. If omitted, `String(describing: Element.self)` is used.
    /// - Returns: A supplementary view instance of type `Element`.
    /// - Note: If the dequeued view cannot be cast to `Element`, this will `fatalError` at runtime due to the force-cast (`as!`).
    func dequeueSupplementary<Element: UICollectionReusableView>(
        kind: String,
        for indexPath: IndexPath,
        as type: Element.Type = Element.self,
        reuseIdentifier: String? = nil
    ) -> Element {
        let id = reuseIdentifier ?? String(describing: Element.self)
        return dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath
        ) as! Element
    }
}
