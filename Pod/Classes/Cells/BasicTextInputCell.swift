//
//  BasicTextInputCell.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/1/9.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import UIKit
import BXModel
import BXiOSUtils
import PinAuto


public class BasicTextInputCell : StaticTableViewCell{
  public let textView = ExpandableTextView(frame:CGRectZero)
  
  
  public convenience init() {
    self.init(style: .Default, reuseIdentifier: "BasicTextInputCellCell")
  }
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [textView]
  }
  var allUITextViewOutlets :[UITextView]{
    return [textView]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func commonInit(){
    staticHeight = 100
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  public func installConstaints(){
    textView.pa_trailing.eq(15).install() // pa_trailing.eq(15)
    textView.pa_bottom.eq(10).install() //pinBottom(10)
    textView.pa_leading.eq(15).install() // pa_leading.eq(15)
    textView.pa_top.eq(10).install() // pa_top.eq(10)
    
  }
  
  public func setupAttrs(){
    textView.setTextPlaceholderColor(FormColors.tertiaryTextColor)
    textView.setTextPlaceholderFont(UIFont.systemFontOfSize(15))
    textView.font = UIFont.systemFontOfSize(15)
  }
  
  public func setTextPlaceholder(placeholder:String){
    textView.setTextPlaceholder(placeholder)
  }
}
