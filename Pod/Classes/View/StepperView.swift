//
//  StepperView.swift
//
//  Created by Haizhen Lee on 15/12/26.
//

import Foundation
import UIKit
import BXModel
import BXiOSUtils

// -LabelStepper:v
// dec[l0,y,w22,a1]:b
// value[l8,r8,y](f14,cdt)
// inc[r0,y,w22,a1]:b

open class StepperView : UIView{
  public let decButton = UIButton(type:.custom)
  public let valueLabel = UILabel(frame:.zero)
  public let incButton = UIButton(type:.custom)
  
  
  public var displayIntValue = true
  public var onValueChanged:( (Double) -> Void)?
  public var onIncValueBlock:( () -> Void)?
  public var onDecValueBlock:( () -> Void)?
  public var onOverflowBlock:( () -> Void)?
  public var enableEventTrigger = true
  
  private var modelValue:Double = 0{
    didSet{
      valueLabel.text = String(Int(modelValue))
      if enableEventTrigger{
        self.onValueChanged?(modelValue)
        if modelValue > oldValue{
          self.onIncValueBlock?()
        }
        if modelValue < oldValue{
          self.onDecValueBlock?()
        }
      }
    }
  }
  
  public var value: Double{ // default is 0. sends UIControlEventValueChanged. clamped to min/max
    set{
      if newValue < minimumValue {
//        onOverflowBlock?()
      }else if newValue > maximumValue{
        onOverflowBlock?()
      }else{
        modelValue = newValue
      }
    }get{
      return modelValue
    }
  }
  public var minimumValue: Double = 0 // default 0. must be less than maximumValue
  public var maximumValue: Double  = 100// default 100. must be greater than minimumValue
  public var stepValue: Double  = 1
  // default 1. must be greater than 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  open var allOutlets :[UIView]{
    return [decButton,valueLabel,incButton]
  }
  var allUIButtonOutlets :[UIButton]{
    return [decButton,incButton]
  }
  var allUILabelOutlets :[UILabel]{
    return [valueLabel]
  }
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open func commonInit(){
    for childView in allOutlets{
      addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
    incButton.addTarget(self, action: #selector(onIncButtonPressed), for: .touchUpInside)
    decButton.addTarget(self, action: #selector(onDecButtonPressed), for: .touchUpInside)
    
  }
  
  @IBAction func onDecButtonPressed(sender:UIButton){
    value = value - stepValue
  }
  
  @IBAction func onIncButtonPressed(sender:UIButton){
    value = value + stepValue
  }
  
  private var labelMarginConstraintLeft:NSLayoutConstraint?
  private var labelMarginConstraintRight:NSLayoutConstraint?
  
  open func installConstaints(){
    decButton.pa_centerY.install()
    decButton.pa_leading.eq(0).install()
    
    valueLabel.pa_centerY.install()
    labelMarginConstraintLeft = valueLabel.pa_before(incButton, offset: labelMargin).install()
    labelMarginConstraintLeft = valueLabel.pa_after(decButton, offset: labelMargin).install()
    
    incButton.pa_centerY.install()
    incButton.pa_trailing.eq(0).install()
    incButton.pa_width.eq(buttonSize.width).install()
    
    for button in [incButton,decButton] {
        button.pa_width.eq(buttonSize.width).install()
        button.pa_height.eq(buttonSize.height).install()
    }
    
  }
  public var labelMargin:CGFloat = 2{
    didSet{
      labelMarginConstraintLeft?.constant = labelMargin
      labelMarginConstraintRight?.constant = labelMargin
    }
  }
 
  var buttonSize  = CGSize(width:36,height:42)
  
  open override var intrinsicContentSize: CGSize {
    let decSize = decButton.intrinsicContentSize
    let labelSize =  valueLabel.intrinsicContentSize
    let incSize = buttonSize
    let width = decSize.width + labelMargin + labelSize.width + labelMargin + incSize.width
    let height = [decSize.height,labelSize.height,incSize.height].max()!
    return CGSize(width: width, height: height)
  }
 
  open override class var requiresConstraintBasedLayout: Bool{
    return true
  }
  
  open func setupAttrs(){
    translatesAutoresizingMaskIntoConstraints = false
//    decButton.setImage(Images.Jian.image, for: .normal)
//    incButton.setImage(Images.Jia.image, for: .normal)
    // 这里不方便使用 Image 所以使用 特殊字符代替.
    decButton.setTitle("－", for: .normal) // FULLWIDTH HYPHEN-MINUS
    incButton.setTitle("＋", for: .normal) // FULLWIDTH PLUS SIGN
    decButton.setTitleColor(.blue, for: .normal)
    incButton.setTitleColor(.blue, for: .normal)
    valueLabel.textColor = .darkText
    valueLabel.font = UIFont.systemFont(ofSize: FormMetrics.primaryFontSize)
    valueLabel.text = String(Int(value))
    
  }
}

