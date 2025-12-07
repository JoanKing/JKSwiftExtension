//
//  JKImageButton.swift
//  JKSwiftExtension
//
//  Created by chongwang on 2025/12/7.
//
/// 在此基础进行的优化: https://github.com/Tencent/QMUI_iOS/blob/master/QMUIKit/QMUIComponents/QMUIButton/QMUIButton.m

import UIKit

open class JKImageButton: UIButton {
    
    // MARK: - Types
    /// Defines the position of the image relative to the title
    public enum ImagePosition {
        case top, left, bottom, right
    }
    
    // MARK: - Public Properties
    /// The position of the image relative to the title
    public var imagePosition: ImagePosition = .left {
        didSet {
            if oldValue != imagePosition {
                invalidateLayout()
            }
        }
    }
    
    /// The spacing between the image and title
    public var spacingBetweenImageAndTitle: CGFloat = 0 {
        didSet {
            if oldValue != spacingBetweenImageAndTitle {
                invalidateLayout()
            }
        }
    }
    
    // MARK: - Private Properties
    /// Cache for layout calculations to improve performance
    private var layoutCache: LayoutCache?
    
    /// Computed properties for showing state
    private var isImageViewShowing: Bool {
        return currentImage != nil
    }
    
    private var isTitleLabelShowing: Bool {
        return currentTitle != nil || currentAttributedTitle != nil
    }
    
    /// Safe access to imageView (accepts potential layout trigger)
    private var safeImageView: UIImageView? {
        return imageView
    }
    
    // MARK: - Initialization
    
    public init(position: ImagePosition = .left, spacing: CGFloat = 0) {
        self.imagePosition = position
        self.spacingBetweenImageAndTitle = spacing
        super.init(frame: .zero)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    open func setup() {
        // Using small non-zero values to work around UIKit edge insets handling
        contentEdgeInsets = UIEdgeInsets(
            top: .leastNormalMagnitude,
            left: 0,
            bottom: .leastNormalMagnitude,
            right: 0
        )
    }
    
    // MARK: - Layout
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var measureSize = size
        
        // If size equals current bounds, measure with unlimited size
        if bounds.size == size {
            measureSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        }
        
        let layout = calculateLayout(for: measureSize)
        return layout.totalSize
    }
    
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard !bounds.isEmpty else { return }
        
        let layout = calculateLayout(for: bounds.size)
        
        // Apply frames
        if isImageViewShowing, let imageView = safeImageView {
            imageView.frame = layout.imageFrame
        }
        
        if isTitleLabelShowing, let titleLabel = titleLabel {
            titleLabel.frame = layout.titleFrame
        }
    }
    
    // MARK: - Layout Calculation
    
    /// Calculates the complete layout for the given size
    private func calculateLayout(for size: CGSize) -> Layout {
        // Check cache
        if let cache = layoutCache, cache.size == size {
            return cache.layout
        }
        
        let contentEdgeInsets = self.contentEdgeInsets.removeFloatMin
        let contentSize = CGSize(
            width: size.width - contentEdgeInsets.horizontal,
            height: size.height - contentEdgeInsets.vertical
        )
        
        // Calculate effective spacing (only if both image and title are showing)
        let effectiveSpacing = (isImageViewShowing && isTitleLabelShowing)
        ? spacingBetweenImageAndTitle.flat
        : 0
        
        let layout: Layout
        
        switch imagePosition {
        case .top, .bottom:
            layout = calculateVerticalLayout(
                contentSize: contentSize,
                contentEdgeInsets: contentEdgeInsets,
                spacing: effectiveSpacing
            )
        case .left, .right:
            layout = calculateHorizontalLayout(
                contentSize: contentSize,
                contentEdgeInsets: contentEdgeInsets,
                spacing: effectiveSpacing
            )
        }
        
        // Cache the result
        layoutCache = LayoutCache(size: size, layout: layout)
        
        return layout
    }
    
    /// Calculates layout for vertical image positions (top/bottom)
    private func calculateVerticalLayout(
        contentSize: CGSize,
        contentEdgeInsets: UIEdgeInsets,
        spacing: CGFloat
    ) -> Layout {
        var imageTotalSize: CGSize = .zero
        var titleTotalSize: CGSize = .zero
        var imageFrame: CGRect = .zero
        var titleFrame: CGRect = .zero
        
        // Calculate image size
        if isImageViewShowing {
            let imageLimitSize = CGSize(
                width: contentSize.width - imageEdgeInsets.horizontal,
                height: contentSize.height - imageEdgeInsets.vertical
            )
            
            var imageSize = getImageSize(limitSize: imageLimitSize)
            imageSize.width = min(imageSize.width, imageLimitSize.width)
            imageSize.height = min(imageSize.height, imageLimitSize.height)
            
            imageFrame = CGRect(origin: .zero, size: imageSize)
            imageTotalSize = CGSize(
                width: imageSize.width + imageEdgeInsets.horizontal,
                height: imageSize.height + imageEdgeInsets.vertical
            )
        }
        
        // Calculate title size
        if isTitleLabelShowing {
            let titleLimitSize = CGSize(
                width: contentSize.width - titleEdgeInsets.horizontal,
                height: contentSize.height - imageTotalSize.height - spacing - titleEdgeInsets.vertical
            )
            
            var titleSize = getTitleSize(limitSize: titleLimitSize)
            titleSize.width = min(titleSize.width, titleLimitSize.width)
            titleSize.height = min(titleSize.height, titleLimitSize.height)
            
            titleFrame = CGRect(origin: .zero, size: titleSize)
            titleTotalSize = CGSize(
                width: titleSize.width + titleEdgeInsets.horizontal,
                height: titleSize.height + titleEdgeInsets.vertical
            )
        }
        
        // Position frames horizontally
        positionFramesHorizontally(
            imageFrame: &imageFrame,
            titleFrame: &titleFrame,
            imageTotalSize: imageTotalSize,
            titleTotalSize: titleTotalSize,
            contentSize: contentSize,
            contentEdgeInsets: contentEdgeInsets
        )
        
        // Position frames vertically
        positionFramesVertically(
            imageFrame: &imageFrame,
            titleFrame: &titleFrame,
            imageTotalSize: imageTotalSize,
            titleTotalSize: titleTotalSize,
            contentSize: contentSize,
            contentEdgeInsets: contentEdgeInsets,
            spacing: spacing,
            isVerticalLayout: true
        )
        
        let totalSize = CGSize(
            width: contentEdgeInsets.horizontal + max(imageTotalSize.width, titleTotalSize.width),
            height: contentEdgeInsets.vertical + imageTotalSize.height + spacing + titleTotalSize.height
        )
        
        return Layout(
            imageFrame: imageFrame.flatted,
            titleFrame: titleFrame.flatted,
            totalSize: totalSize
        )
    }
    
    /// Calculates layout for horizontal image positions (left/right)
    private func calculateHorizontalLayout(
        contentSize: CGSize,
        contentEdgeInsets: UIEdgeInsets,
        spacing: CGFloat
    ) -> Layout {
        var imageTotalSize: CGSize = .zero
        var titleTotalSize: CGSize = .zero
        var imageFrame: CGRect = .zero
        var titleFrame: CGRect = .zero
        
        // Calculate image size
        if isImageViewShowing {
            let imageLimitSize = CGSize(
                width: contentSize.width - imageEdgeInsets.horizontal,
                height: contentSize.height - imageEdgeInsets.vertical
            )
            
            var imageSize = getImageSize(limitSize: imageLimitSize)
            imageSize.height = min(imageSize.height, imageLimitSize.height)
            
            imageFrame = CGRect(origin: .zero, size: imageSize)
            imageTotalSize = CGSize(
                width: imageSize.width + imageEdgeInsets.horizontal,
                height: imageSize.height + imageEdgeInsets.vertical
            )
        }
        
        // Calculate title size
        if isTitleLabelShowing {
            let titleLimitSize = CGSize(
                width: contentSize.width - titleEdgeInsets.horizontal - imageTotalSize.width - spacing,
                height: contentSize.height - titleEdgeInsets.vertical
            )
            
            var titleSize = getTitleSize(limitSize: titleLimitSize)
            titleSize.width = min(titleSize.width, titleLimitSize.width)
            titleSize.height = min(titleSize.height, titleLimitSize.height)
            
            titleFrame = CGRect(origin: .zero, size: titleSize)
            titleTotalSize = CGSize(
                width: titleSize.width + titleEdgeInsets.horizontal,
                height: titleSize.height + titleEdgeInsets.vertical
            )
        }
        
        // Position frames vertically
        positionFramesVertically(
            imageFrame: &imageFrame,
            titleFrame: &titleFrame,
            imageTotalSize: imageTotalSize,
            titleTotalSize: titleTotalSize,
            contentSize: contentSize,
            contentEdgeInsets: contentEdgeInsets,
            spacing: spacing,
            isVerticalLayout: false
        )
        
        // Position frames horizontally
        positionFramesHorizontally(
            imageFrame: &imageFrame,
            titleFrame: &titleFrame,
            imageTotalSize: imageTotalSize,
            titleTotalSize: titleTotalSize,
            contentSize: contentSize,
            contentEdgeInsets: contentEdgeInsets,
            spacing: spacing,
            isHorizontalLayout: true
        )
        
        let totalSize = CGSize(
            width: contentEdgeInsets.horizontal + imageTotalSize.width + spacing + titleTotalSize.width,
            height: contentEdgeInsets.vertical + max(imageTotalSize.height, titleTotalSize.height)
        )
        
        return Layout(
            imageFrame: imageFrame.flatted,
            titleFrame: titleFrame.flatted,
            totalSize: totalSize
        )
    }
    
    // MARK: - Positioning Helpers
    
    /// Positions frames horizontally based on content alignment
    private func positionFramesHorizontally(
        imageFrame: inout CGRect,
        titleFrame: inout CGRect,
        imageTotalSize: CGSize,
        titleTotalSize: CGSize,
        contentSize: CGSize,
        contentEdgeInsets: UIEdgeInsets,
        spacing: CGFloat = 0,
        isHorizontalLayout: Bool = false
    ) {
        guard isHorizontalLayout else {
            // For vertical layout, just align each element
            switch contentHorizontalAlignment {
            case .left:
                if isImageViewShowing {
                    imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                }
                
            case .center:
                if isImageViewShowing {
                    let imageLimitWidth = contentSize.width - imageEdgeInsets.horizontal
                    imageFrame = imageFrame.setX(
                        contentEdgeInsets.left + imageEdgeInsets.left +
                        imageLimitWidth.center(imageFrame.width)
                    )
                }
                if isTitleLabelShowing {
                    let titleLimitWidth = contentSize.width - titleEdgeInsets.horizontal
                    titleFrame = titleFrame.setX(
                        contentEdgeInsets.left + titleEdgeInsets.left +
                        titleLimitWidth.center(titleFrame.width)
                    )
                }
                
            case .right:
                if isImageViewShowing {
                    imageFrame = imageFrame.setX(
                        bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageFrame.width
                    )
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(
                        bounds.width - contentEdgeInsets.right - titleEdgeInsets.right - titleFrame.width
                    )
                }
                
            case .fill:
                if isImageViewShowing {
                    imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                    imageFrame = imageFrame.setWidth(contentSize.width - imageEdgeInsets.horizontal)
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                    titleFrame = titleFrame.setWidth(contentSize.width - titleEdgeInsets.horizontal)
                }
            default:
                break
            }
            return
        }
        
        // For horizontal layout
        let isImageLeft = imagePosition == .left
        let contentWidth = imageTotalSize.width + spacing + titleTotalSize.width
        
        switch contentHorizontalAlignment {
        case .left:
            if isImageLeft {
                if isImageViewShowing {
                    imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(
                        contentEdgeInsets.left + imageTotalSize.width + spacing + titleEdgeInsets.left
                    )
                }
            } else {
                // Image on right - check if content fits
                if contentWidth <= contentSize.width {
                    if isTitleLabelShowing {
                        titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                    }
                    if isImageViewShowing {
                        imageFrame = imageFrame.setX(
                            contentEdgeInsets.left + titleTotalSize.width + spacing + imageEdgeInsets.left
                        )
                    }
                } else {
                    // Doesn't fit, align to right
                    if isImageViewShowing {
                        imageFrame = imageFrame.setX(
                            bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageFrame.width
                        )
                    }
                    if isTitleLabelShowing {
                        titleFrame = titleFrame.setX(
                            bounds.width - contentEdgeInsets.right - imageTotalSize.width -
                            spacing - titleTotalSize.width + titleEdgeInsets.left
                        )
                    }
                }
            }
            
        case .center:
            let minX = contentEdgeInsets.left + contentSize.width.center(contentWidth)
            if isImageLeft {
                if isImageViewShowing {
                    imageFrame = imageFrame.setX(minX + imageEdgeInsets.left)
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(
                        minX + imageTotalSize.width + spacing + titleEdgeInsets.left
                    )
                }
            } else {
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(minX + titleEdgeInsets.left)
                }
                if isImageViewShowing {
                    imageFrame = imageFrame.setX(
                        minX + titleTotalSize.width + spacing + imageEdgeInsets.left
                    )
                }
            }
            
        case .right:
            if isImageLeft {
                // Image on left - check if content fits
                if contentWidth <= contentSize.width {
                    if isTitleLabelShowing {
                        titleFrame = titleFrame.setX(
                            bounds.width - contentEdgeInsets.right - titleEdgeInsets.right - titleFrame.width
                        )
                    }
                    if isImageViewShowing {
                        imageFrame = imageFrame.setX(
                            bounds.width - contentEdgeInsets.right - titleTotalSize.width -
                            spacing - imageTotalSize.width + imageEdgeInsets.left
                        )
                    }
                } else {
                    // Doesn't fit, align to left
                    if isImageViewShowing {
                        imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                    }
                    if isTitleLabelShowing {
                        titleFrame = titleFrame.setX(
                            contentEdgeInsets.left + imageTotalSize.width + spacing + titleEdgeInsets.left
                        )
                    }
                }
            } else {
                if isImageViewShowing {
                    imageFrame = imageFrame.setX(
                        bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageFrame.width
                    )
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(
                        bounds.width - contentEdgeInsets.right - imageTotalSize.width -
                        spacing - titleEdgeInsets.right - titleFrame.width
                    )
                }
            }
            
        case .fill:
            if isImageLeft {
                if isImageViewShowing && isTitleLabelShowing {
                    imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                    titleFrame = titleFrame.setX(
                        contentEdgeInsets.left + imageTotalSize.width + spacing + titleEdgeInsets.left
                    )
                    titleFrame = titleFrame.setWidth(
                        bounds.width - contentEdgeInsets.right - titleEdgeInsets.right - titleFrame.minX
                    )
                } else if isImageViewShowing {
                    imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                    imageFrame = imageFrame.setWidth(contentSize.width - imageEdgeInsets.horizontal)
                } else if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                    titleFrame = titleFrame.setWidth(contentSize.width - titleEdgeInsets.horizontal)
                }
            } else {
                if isImageViewShowing && isTitleLabelShowing {
                    imageFrame = imageFrame.setX(
                        bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageFrame.width
                    )
                    titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                    titleFrame = titleFrame.setWidth(
                        imageFrame.minX - imageEdgeInsets.left - spacing -
                        titleEdgeInsets.right - titleFrame.minX
                    )
                } else if isImageViewShowing {
                    imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                    imageFrame = imageFrame.setWidth(contentSize.width - imageEdgeInsets.horizontal)
                } else if isTitleLabelShowing {
                    titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                    titleFrame = titleFrame.setWidth(contentSize.width - titleEdgeInsets.horizontal)
                }
            }
        default:
            break
        }
    }
    
    /// Positions frames vertically based on content alignment
    private func positionFramesVertically(
        imageFrame: inout CGRect,
        titleFrame: inout CGRect,
        imageTotalSize: CGSize,
        titleTotalSize: CGSize,
        contentSize: CGSize,
        contentEdgeInsets: UIEdgeInsets,
        spacing: CGFloat,
        isVerticalLayout: Bool
    ) {
        guard isVerticalLayout else {
            // For horizontal layout, just align each element
            switch contentVerticalAlignment {
            case .top:
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                }
                
            case .center:
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(
                        contentEdgeInsets.top + contentSize.height.center(imageFrame.height) +
                        imageEdgeInsets.top
                    )
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(
                        contentEdgeInsets.top + contentSize.height.center(titleFrame.height) +
                        titleEdgeInsets.top
                    )
                }
                
            case .bottom:
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(
                        bounds.height - contentEdgeInsets.bottom - imageEdgeInsets.bottom - imageFrame.height
                    )
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(
                        bounds.height - contentEdgeInsets.bottom - titleEdgeInsets.bottom - titleFrame.height
                    )
                }
                
            case .fill:
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                    imageFrame = imageFrame.setHeight(contentSize.height - imageEdgeInsets.vertical)
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                    titleFrame = titleFrame.setHeight(contentSize.height - titleEdgeInsets.vertical)
                }
                
            @unknown default:
                break
            }
            return
        }
        
        // For vertical layout
        let isImageTop = imagePosition == .top
        let contentHeight = imageTotalSize.height + spacing + titleTotalSize.height
        
        switch contentVerticalAlignment {
        case .top:
            if isImageTop {
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(
                        contentEdgeInsets.top + imageTotalSize.height + spacing + titleEdgeInsets.top
                    )
                }
            } else {
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                }
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(
                        contentEdgeInsets.top + titleTotalSize.height + spacing + imageEdgeInsets.top
                    )
                }
            }
            
        case .center:
            let minY = contentEdgeInsets.top + contentSize.height.center(contentHeight)
            if isImageTop {
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(minY + imageEdgeInsets.top)
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(
                        minY + imageTotalSize.height + spacing + titleEdgeInsets.top
                    )
                }
            } else {
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(minY + titleEdgeInsets.top)
                }
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(
                        minY + titleTotalSize.height + spacing + imageEdgeInsets.top
                    )
                }
            }
            
        case .bottom:
            if isImageTop {
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(
                        bounds.height - contentEdgeInsets.bottom - titleEdgeInsets.bottom - titleFrame.height
                    )
                }
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(
                        bounds.height - contentEdgeInsets.bottom - titleTotalSize.height -
                        spacing - imageEdgeInsets.bottom - imageFrame.height
                    )
                }
            } else {
                if isImageViewShowing {
                    imageFrame = imageFrame.setY(
                        bounds.height - contentEdgeInsets.bottom - imageEdgeInsets.bottom - imageFrame.height
                    )
                }
                if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(
                        bounds.height - contentEdgeInsets.bottom - imageTotalSize.height -
                        spacing - titleEdgeInsets.bottom - titleFrame.height
                    )
                }
            }
            
        case .fill:
            if isImageTop {
                if isImageViewShowing && isTitleLabelShowing {
                    imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                    titleFrame = titleFrame.setY(
                        contentEdgeInsets.top + imageTotalSize.height + spacing + titleEdgeInsets.top
                    )
                    titleFrame = titleFrame.setHeight(
                        bounds.height - contentEdgeInsets.bottom - titleEdgeInsets.bottom - titleFrame.minY
                    )
                } else if isImageViewShowing {
                    imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                    imageFrame = imageFrame.setHeight(contentSize.height - imageEdgeInsets.vertical)
                } else if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                    titleFrame = titleFrame.setHeight(contentSize.height - titleEdgeInsets.vertical)
                }
            } else {
                if isImageViewShowing && isTitleLabelShowing {
                    imageFrame = imageFrame.setY(
                        bounds.height - contentEdgeInsets.bottom - imageEdgeInsets.bottom - imageFrame.height
                    )
                    titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                    titleFrame = titleFrame.setHeight(
                        bounds.height - contentEdgeInsets.bottom - imageTotalSize.height -
                        spacing - titleEdgeInsets.bottom - titleFrame.minY
                    )
                } else if isImageViewShowing {
                    imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                    imageFrame = imageFrame.setHeight(contentSize.height - imageEdgeInsets.vertical)
                } else if isTitleLabelShowing {
                    titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                    titleFrame = titleFrame.setHeight(contentSize.height - titleEdgeInsets.vertical)
                }
            }
            
        @unknown default:
            break
        }
    }
    
    // MARK: - Size Calculation Helpers
    
    /// Gets the size of the image within the limit
    private func getImageSize(limitSize: CGSize) -> CGSize {
        if let imageView = safeImageView, imageView.image != nil {
            return imageView.sizeThatFits(limitSize)
        } else if let image = currentImage {
            return image.size
        }
        return .zero
    }
    
    /// Gets the size of the title within the limit
    private func getTitleSize(limitSize: CGSize) -> CGSize {
        guard let titleLabel = titleLabel else {
            return .zero
        }
        return titleLabel.sizeThatFits(limitSize)
    }
    
    // MARK: - Cache Management
    
    /// Invalidates the layout cache
    private func invalidateLayout() {
        layoutCache = nil
        setNeedsLayout()
        invalidateIntrinsicContentSize()
    }
    
    // MARK: - Override State Changes
    
    override open func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        invalidateLayout()
    }
    
    override open func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        super.setAttributedTitle(title, for: state)
        invalidateLayout()
    }
    
    override open func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        invalidateLayout()
    }
}

// MARK: - Supporting Types
private extension JKImageButton {
    
    /// Represents a calculated layout
    struct Layout {
        let imageFrame: CGRect
        let titleFrame: CGRect
        let totalSize: CGSize
    }
    
    /// Cache structure for layout calculations
    struct LayoutCache {
        let size: CGSize
        let layout: Layout
    }
}

// MARK: - Extensions

private extension CGFloat {
    
    /// Removes float minimum values used as sentinels
    var removeFloatMin: CGFloat {
        guard self != .leastNormalMagnitude,
              self != .leastNonzeroMagnitude else { return 0 }
        return self
    }
    
    /// Flattens value to pixel boundaries for a given scale
    func flatSpecificScale(_ scale: CGFloat = 0) -> CGFloat {
        let value = removeFloatMin
        return ceil(value * scale) / scale
    }
    
    /// Flattens value to pixel boundaries for main screen
    var flat: CGFloat {
        return flatSpecificScale(UIScreen.main.scale)
    }
    
    /// Calculates the centered offset for the given child size
    /// - Parameter child: The size of the child to center
    /// - Returns: The offset from the start edge to center the child
    func center(_ child: CGFloat) -> CGFloat {
        return ((self - child) / 2.0).flat
    }
}

private extension UIEdgeInsets {
    
    /// Total horizontal insets (left + right)
    var horizontal: CGFloat {
        return left + right
    }
    
    /// Total vertical insets (top + bottom)
    var vertical: CGFloat {
        return top + bottom
    }
    
    /// Returns edge insets with float minimum values removed
    var removeFloatMin: UIEdgeInsets {
        return UIEdgeInsets(
            top: top.removeFloatMin,
            left: left.removeFloatMin,
            bottom: bottom.removeFloatMin,
            right: right.removeFloatMin
        )
    }
}

private extension CGRect {
    
    /// Returns a rect with all values flattened to pixel boundaries
    var flatted: CGRect {
        return CGRect(
            x: origin.x.flat,
            y: origin.y.flat,
            width: size.width.flat,
            height: size.height.flat
        )
    }
    
    /// Returns a new rect with the specified x coordinate
    func setX(_ x: CGFloat) -> CGRect {
        return CGRect(x: x.flat, y: origin.y, width: size.width, height: size.height)
    }
    
    /// Returns a new rect with the specified y coordinate
    func setY(_ y: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: y.flat, width: size.width, height: size.height)
    }
    
    /// Returns a new rect with the specified width
    func setWidth(_ width: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: width.flat, height: size.height)
    }
    
    /// Returns a new rect with the specified height
    func setHeight(_ height: CGFloat) -> CGRect {
        return CGRect(x: origin.x, y: origin.y, width: size.width, height: height.flat)
    }
}
