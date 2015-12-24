//
//  IconLabel.swift
//
//  Created by Haizhen Lee on 15/12/20.
//

import UIKit
import PinAutoLayout

// -IconLabel:v
// icon[l0,y]:i
// text[l8,t0,b0](f15,cdt)

public class IconLabel : UIView{
  public let iconImageView = UIImageView(frame:CGRectZero)
  public let textLabel = UILabel(frame:CGRectZero)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
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
  
  public var iconLeadingConstraint:NSLayoutConstraint!
  var iconPaddingConstraint:NSLayoutConstraint!
  
  public var iconPadding : CGFloat = 6{
    didSet{
      iconPaddingConstraint.constant = iconPadding
    }
  }
  
  func installConstaints(){
    translatesAutoresizingMaskIntoConstraints = false
    
    iconImageView.pinCenterY()
    iconLeadingConstraint =  iconImageView.pinLeading(0)
    
    textLabel.pinBottom(0)
    iconPaddingConstraint = textLabel.pinLeadingToSibling(iconImageView, margin: iconPadding)
    textLabel.pinTop(0)
    textLabel.pinTrailing(0)
    
  }
  
  public override class func requiresConstraintBasedLayout() -> Bool{
    return true
  }
  
  public override func intrinsicContentSize() -> CGSize {
    let iconSize = iconImageView.intrinsicContentSize()
    let textSize = textLabel.intrinsicContentSize()
    let width = iconSize.width + iconPadding + textSize.width
    let height = max(iconSize.height,textSize.height)
    return CGSize(width: width, height: height)
  }
  
  func setupAttrs(){
    textLabel.textAlignment = .Left
    textLabel.setContentHuggingPriority(240, forAxis: .Horizontal)
    textLabel.textColor = UIColor.darkTextColor()
    textLabel.font = UIFont.systemFontOfSize(15)
    userInteractionEnabled = false
  }
  
  //MARK: Getter And Setter
  
  public var text:String?{
    get{
      return textLabel.text
    }set{
      textLabel.text = newValue
      invalidateIntrinsicContentSize()
    }
  }
  
  public var icon:UIImage?{
    get{
      return iconImageView.image
    }set{
      iconImageView.image = newValue
      invalidateIntrinsicContentSize()
    }
  }
}



