//
//  IconLabel.swift
//
//  Created by Haizhen Lee on 15/12/20.
//

import UIKit
import PinAuto

// -IconLabel:v
// icon[l0,y]:i
// text[l8,t0,b0](f15,cdt)

public enum IconPosition{
  case left,right,top, bottom
  
  public var isVerticalAlign: Bool{
    return [.top, .bottom].contains(self)
  }
  
  public var isHorizontalAlign: Bool{
    return [.left, .right].contains(self)
  }
}

open class IconLabel : UIView{
  open let iconImageView = UIImageView(frame:CGRect.zero)
  open let textLabel = UILabel(frame:CGRect.zero)
  private var _iconPosition: IconPosition  = .left
  public var iconPosition: IconPosition{
    get{
      return _iconPosition
    }set{
      _iconPosition = newValue
      onIconPositionChanged()
    }
  }
  
  
  public init(iconPosition: IconPosition = .left) {
    self._iconPosition = iconPosition
    super.init(frame: .zero)
    commonInit()
  }
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  func onIconPositionChanged(){
      relayout()
  }
  
  var allOutlets :[UIView]{
    return [iconImageView,textLabel]
  }
  var allUIImageViewOutlets :[UIImageView]{
    return [iconImageView]
  }
  var allUILabelOutlets :[UILabel]{
    return [textLabel]
  }
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func relayout(){
    for childView in allOutlets{
      childView.removeFromSuperview()
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
  }
  
  open var horizontalPadding:CGFloat = 4{
    didSet{
      relayout()
    }
  }
  
  open var verticalPadding: CGFloat = 4 {
    didSet{
      relayout()
    }
  }
  
  var iconPaddingConstraint:NSLayoutConstraint?
  open var iconPadding : CGFloat = 2{
    didSet{
      relayout()
    }
  }
  
  func installConstaints(){
    translatesAutoresizingMaskIntoConstraints = false

    if iconPosition.isVerticalAlign{
      for view in [iconImageView, textLabel]{
        view.pa_leading.gte(horizontalPadding).withPriority(240).install()
        view.pa_trailing.gte(horizontalPadding).withPriority(240).install()
      }
      
      iconImageView.pa_centerX.install()
      textLabel.pa_centerX.install()
    }else if iconPosition.isHorizontalAlign{
      for view in [iconImageView, textLabel]{
        view.pa_top.gte(verticalPadding).withPriority(240).install()
        view.pa_bottom.gte(verticalPadding).withPriority(240).install()
      }
      textLabel.pa_centerY.install()
    }
    switch iconPosition {
    case .left:
      iconImageView.pa_leading.eq(horizontalPadding).install()
      textLabel.pa_after(iconImageView, offset: iconPadding).install()
      textLabel.pa_trailing.eq(horizontalPadding).install()
    case .right:
      iconImageView.pa_trailing.eq(horizontalPadding).install() 
      textLabel.pa_before(iconImageView, offset: iconPadding).install()
      textLabel.pa_leading.eq(horizontalPadding).install()
    case .top:
      iconImageView.pa_top.eq(verticalPadding).install()
      textLabel.pa_below(iconImageView, offset: iconPadding).install()
      textLabel.pa_bottom.eq(verticalPadding).install()
    case .bottom:
      iconImageView.pa_bottom.eq(verticalPadding).install()
      textLabel.pa_above(iconImageView, offset: iconPadding).install()
      textLabel.pa_top.eq(verticalPadding).install()
    }
    
    
  }
  
  open override class var requiresConstraintBasedLayout : Bool{
    return true
  }
  
  open override var intrinsicContentSize : CGSize {
    let iconSize = iconImageView.intrinsicContentSize
    let textSize = textLabel.intrinsicContentSize
    let width:CGFloat
    let height: CGFloat
    if iconPosition.isHorizontalAlign{
      width = iconSize.width + iconPadding + textSize.width
      height = max(iconSize.height,textSize.height)
    }else{
      width = max(iconSize.width,textSize.width)
      height = iconSize.height + iconPadding + textSize.height
    }
    return CGSize(width: width + horizontalPadding * 2, height: height + verticalPadding * 2)
  }
  
  func setupAttrs(){
    textLabel.textAlignment = .left
    textLabel.setContentHuggingPriority(240, for: .horizontal)
    textLabel.textColor = UIColor.darkText
    textLabel.font = UIFont.systemFont(ofSize: 15)
    isUserInteractionEnabled = false
  }
  
  //MARK: Getter And Setter
  
  open var text:String?{
    get{
      return textLabel.text
    }set{
      textLabel.text = newValue
      invalidateIntrinsicContentSize()
    }
  }
  
  open var icon:UIImage?{
    get{
      return iconImageView.image
    }set{
      iconImageView.image = newValue
      invalidateIntrinsicContentSize()
    }
  }
  
  open var textColor:UIColor?{
    get{
      return textLabel.textColor
    }set{
      textLabel.textColor = newValue
    }
  }
  
  open var font:UIFont{
    get{
      return textLabel.font
    }set{
      textLabel.font = newValue
      invalidateIntrinsicContentSize()
    }
  }
  
  open var outlineStyle = BXOutlineStyle.none{
    didSet{
      updateOvalPath()
    }
  }
  
  open var cornerRadius:CGFloat = 4.0 {
    didSet{
      updateOvalPath()
    }
  }
  
  open lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    updateOvalPath()
  }
  
  fileprivate func updateOvalPath(){
    let path:UIBezierPath
    switch outlineStyle{
    case .rounded:
      path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    case .oval:
      path = UIBezierPath(ovalIn: bounds)
    case .semicircle:
      path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height * 0.5)
    case .none:
      maskLayer.path = nil
      return
    }
    maskLayer.path = path.cgPath
  }

}




