# BindKit
**Auto Layout, without the headache.**

BindKit is a lightweight, developer-friendly DSL for UIKit Auto Layout.  
The goal: readable, chainable, headache-free constraints without `NSLayoutConstraint.activate` boilerplate.

---

## Example

```swift
titleLabel.bk
    .added(to: contentView)
    .pinned(.horizontal, to: .view(contentView), insets: .all(12))
    .pinned(.custom([.bottom]), to: .view(contentView))
```

It almost reads like plain English:  
“titleLabel was added to contentView, pinned horizontally with 12pt insets,  
pinned to the bottom of contentView, and placed 6pt below the thumbnail.”

---

## Installation

Add BindKit using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/yusasarisoy/BindKit.git", from: "1.0.0")
]
```

Then import it in your code:

```swift
import BindKit
```
---

## What You Can Do

```swift
// Add to hierarchy
view.bk.added(to: superview)

// Pin edges
label.bk.pinned(.all, to: .safeArea(of: view), insets: .all(16))

// Center
icon.bk.centered(in: container)

// Size & aspect ratio
avatar.bk.sized(width: 44, height: 44)
image.bk.withAspect(ratio: 16/9)
```

---

## Safety By Default

- All APIs are `@MainActor` → no concurrency warnings.  
- `translatesAutoresizingMaskIntoConstraints = false` is handled for you.  
- Constraints can be grouped (`BKConstraintGroup`) and re-activated/deactivated as needed.  

---

## Contributing

Got an idea for a sweeter sugar syntax?  
Open an issue or PR — let’s improve BindKit together.

---

## License

MIT
