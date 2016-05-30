//
//  LabelTextCell.swift
//  Pods
//
//  Created by Haizhen Lee on 16/5/24.
//
//

import Foundation
// Build for target uimodel
import UIKit
import BXModel
import SwiftyJSON
import BXiOSUtils
import BXForm

//LabelTextCell:stc

public class LabelTextCell : StaticTableViewCell{
  public let labelLabel = UILabel(frame:CGRectZero)
  public let inputTextField = UITextField(frame:CGRectZero)
  
  public convenience init() {
    self.init(style: .Default, reuseIdentifier: "AbelTextCellCell")
  }
  
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  
  
  public func bind(label label:String,text:String){
    labelLabel.text  = label
    inputTextField.text  = text
  }
  
  public func bind(label label:String,placeholder:String){
    labelLabel.text  = label
    inputTextField.placeholder  = placeholder
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  var allOutlets :[UIView]{
    return [labelLabel,inputTextField]
  }
  var allUILabelOutlets :[UILabel]{
    return [labelLabel]
  }
  var allUITextFieldOutlets :[UITextField]{
    return [inputTextField]
  }
  
  func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  public var paddingLeft:CGFloat = 15{
    didSet{
      paddingLeftConstraint?.constant = paddingLeft
    }
  }
  
  public var paddingRight:CGFloat = 15{
    didSet{
      paddingRightConstraint?.constant = paddingRight
    }
  }
  
  public var labelWidth:CGFloat = 68{
    didSet{
      labelWidthConstraint?.constant = labelWidth
    }
  }
  
  private var paddingLeftConstraint:NSLayoutConstraint?
  private var paddingRightConstraint:NSLayoutConstraint?
  private var labelWidthConstraint:NSLayoutConstraint?
  
  func installConstaints(){
    labelLabel.pa_centerY.install()
     paddingLeftConstraint = labelLabel.pa_leading.eq(paddingLeft).install()
    labelWidthConstraint = labelLabel.pa_width.eq(110).install()
    
    inputTextField.pa_centerY.install()
    paddingRightConstraint = inputTextField.pa_trailing.eq(paddingRight).install()
    inputTextField.pa_after(labelLabel,offset:4).install()
    
  }
  
  func setupAttrs(){
    labelLabel.textColor = FormColors.primaryTextColor
    labelLabel.font = UIFont.systemFontOfSize(15)
    
    
    
  }
  

  public var inputText:String{
    return inputTextField.text?.trimmed() ?? ""
  }
}

