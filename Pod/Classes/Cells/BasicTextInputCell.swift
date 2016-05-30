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
import Cent


public class BasicTextInputCell : StaticTableViewCell{
  public let labelLabel = UILabel(frame:CGRectZero)
  public let textView = ExpandableTextView(frame:CGRectZero)
  public let countLabel = UILabel(frame:CGRectZero)
  
  
  convenience init() {
    self.init(style: .Default, reuseIdentifier: "BasicTextInputCellCell")
  }
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return [textView,labelLabel,countLabel]
  }
  var allUITextViewOutlets :[UITextView]{
    return [textView]
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  

  
  public func bindLabel(label:String){
    labelLabel.text = label
    labelLabel.hidden = label.isEmpty
    if label.isEmpty{
      textTopConstraint?.active = true
      textBelowLabelConstraint?.active = false
    }else{
      textTopConstraint?.active = false
      textBelowLabelConstraint?.active = true
    }
  }
  
  func commonInit(){
    staticHeight = 100
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  var textBelowLabelConstraint:NSLayoutConstraint?
  var textTopConstraint:NSLayoutConstraint?
  
  func installConstaints(){
    labelLabel.pa_top.eq(11).install()
    labelLabel.pa_leading.eq(15).install()
    
    textView.pac_horizontal(15)
    
    textBelowLabelConstraint =  textView.pa_below(labelLabel, offset: 8).install()
    textBelowLabelConstraint?.active = false
    textTopConstraint = textView.pa_top.eq(12).install()
    
    countLabel.pa_below(textView, offset: 8).install()
    countLabel.pa_trailing.eq(15).install()
    countLabel.pa_bottom.eq(10).install()
    
    textView.setContentHuggingPriority(200, forAxis: .Vertical)
    
  }
  
  func setupAttrs(){
    labelLabel.textColor = FormColors.primaryTextColor
    labelLabel.font = UIFont.systemFontOfSize(16)
    labelLabel.textAlignment = .Left
    
    textView.setTextPlaceholderColor(FormColors.tertiaryTextColor)
    textView.setTextPlaceholderFont(UIFont.systemFontOfSize(15))
    textView.font = UIFont.systemFontOfSize(15)
    
    countLabel.textColor = FormColors.hintTextColor
    countLabel.font = UIFont.systemFontOfSize(14)
    
    textView.delegate = self
    
    textView.onTextDidChangeCallback = { text in
      self.countLabel.attributedText = self.createCountDownAttributedText(text)
    }
    countLabel.text = "最多\(inputMaxLength)字"
  }
  
  public func setTextPlaceholder(placeholder:String){
    textView.setTextPlaceholder(placeholder)
  }
  
  public var inputText:String{
    return textView.text ?? ""
  }
  
  public var inputMaxLength = 100{
    didSet{
      if inputText.isEmpty{
        countLabel.text = "最多\(inputMaxLength)字"
      }else{
        self.countLabel.attributedText = self.createCountDownAttributedText(inputText.strip())
      }
    }
  }
  
  func createCountDownAttributedText(text:String) -> NSAttributedString{
    let count = text.strip().length
    if count <= inputMaxLength{
      return NSAttributedString(string: "\(count)/\(inputMaxLength)")
    }else{
      let attributedText =  NSMutableAttributedString(string:"\(count)",attributes:[
        NSForegroundColorAttributeName:UIColor.redColor()
        ])
      attributedText.appendAttributedString(NSAttributedString(string: "/ \(inputMaxLength)"))
      return attributedText
    }
  }
  
}


extension BasicTextInputCell: UITextViewDelegate{
  
  public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    //NSLog("\(#function) \(range) \(text)")
    let content = textView.text ?? ""
    let currentCount = content.characters.count
    let postCount = currentCount + text.characters.count
    if range.length == 0 {
      // append
      return postCount <= inputMaxLength
    }else{
      // delete
      return true
    }
  }
}
