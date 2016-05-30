//
//  VerticalIconButton.swift
//  Pods
//
//  Created by Haizhen Lee on 16/5/29.
//
//

import Foundation

// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils
import BXForm

//-VerticalIconButton(al,nobind):ct
//icon[x,y]:i
//title[x,bl4@icon](f15,cpt)

public class VerticalIconButton : UIControl  {
  public var iconPadding = FormMetrics.iconPadding
  public let iconImageView = UIImageView(frame:CGRect.zero)
  public let titleLabel = UILabel(frame:CGRect.zero)
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [iconImageView,titleLabel]
  }
  var allUIImageViewOutlets :[UIImageView]{
    return [iconImageView]
  }
  var allUILabelOutlets :[UILabel]{
    return [titleLabel]
  }
  
  func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func installConstaints(){
    iconImageView.pa_centerY.install()
    iconImageView.pa_centerX.install()
    
    titleLabel.pa_below(iconImageView,offset:iconPadding).install()
    titleLabel.pa_centerX.install()
    
  }
  
  func setupAttrs(){
    titleLabel.textColor = FormColors.primaryTextColor
    titleLabel.font = UIFont.systemFontOfSize(15)
    
  }
  
  public var icon:UIImage?{
    set{
      iconImageView.image = newValue
    }get{
      return iconImageView.image
    }
  }
  
  public class override func requiresConstraintBasedLayout() -> Bool{
    return true
  }
  
  public override func intrinsicContentSize() -> CGSize {
    let iconSize = iconImageView.intrinsicContentSize()
    let titleSize = titleLabel.intrinsicContentSize()
    let width = max(iconSize.width, titleSize.width)
    let height = iconSize.height + iconPadding + titleSize.height
    
    return CGSize(width: width, height: height)
  }
  
}

