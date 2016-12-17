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

//LabelTextCell:stc

open class LabelTextCell : StaticTableViewCell{
  open let labelLabel = UILabel(frame:.zero)
  open let inputTextField = UITextField(frame:.zero)
  
  public convenience init() {
    self.init(style: .default, reuseIdentifier: "AbelTextCellCell")
  }
  
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  
  
  open func bind(label:String,text:String){
    labelLabel.text  = label
    inputTextField.text  = text
  }
  
  open func bind(label:String,placeholder:String){
    labelLabel.text  = label
    inputTextField.placeholder  = placeholder
  }
  
  open override func awakeFromNib() {
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
  
  open var paddingLeft:CGFloat = FormMetrics.cellPaddingLeft{
    didSet{
      paddingLeftConstraint?.constant = paddingLeft
    }
  }
  
  open var paddingRight:CGFloat = FormMetrics.cellPaddingRight{
    didSet{
      paddingRightConstraint?.constant = paddingRight
    }
  }
  
  open var labelWidth:CGFloat = FormMetrics.cellLabelWidth{
    didSet{
      labelWidthConstraint?.constant = labelWidth
    }
  }
  
  fileprivate var paddingLeftConstraint:NSLayoutConstraint?
  fileprivate var paddingRightConstraint:NSLayoutConstraint?
  fileprivate var labelWidthConstraint:NSLayoutConstraint?
  
  func installConstaints(){
    labelLabel.pa_centerY.install()
     paddingLeftConstraint = labelLabel.pa_leading.eq(paddingLeft).install()
    labelWidthConstraint = labelLabel.pa_width.eq(labelWidth).install()
    
    inputTextField.pa_centerY.install()
    paddingRightConstraint = inputTextField.pa_trailing.eq(paddingRight).install()
    inputTextField.pa_after(labelLabel,offset:8).install()
    
  }
  
  func setupAttrs(){
    labelLabel.textColor = FormColors.primaryTextColor
    labelLabel.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
    labelLabel.textAlignment = .right
    
    inputTextField.textAlignment = .right
    
  }
  
  open var label: String?{
    get{ return labelLabel.text }
    set{ labelLabel.text = newValue }
  }
  

  open var inputText:String{
    get{ return inputTextField.text?.trimmed() ?? "" }
    set{ inputTextField.text = newValue }
  }
  
  public var placeholder:String?{
    get{ return inputTextField.placeholder }
    set{ inputTextField.placeholder = newValue }
  }
}

