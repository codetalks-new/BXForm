//
//  GroupButtonBar.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import Foundation

public enum GroupButtonBarAlignment:Int{
  case Left
  case Right
}

public class GroupButtonBar:UIView{
  
  public var buttonCount:Int{
    return buttons.count
  }
  
  public var buttonHeight:CGFloat = 34{
    didSet{
      setNeedsLayout()
    }
  }
  public var buttonWidth:CGFloat = 94{
    didSet{
      setNeedsLayout()
    }
  }
  public var buttonSpace:CGFloat = 10{
    didSet{
      setNeedsLayout()
    }
  }
  public var margin:CGFloat = 15{
    didSet{
      setNeedsLayout()
    }
  }
  public var alignment = GroupButtonBarAlignment.Right{
    didSet{
      setNeedsLayout()
    }
  }
  
  public var onButtonClicked:(UIButton -> Void)?
  
  private var buttons:[UIButton] = []
  
  public func appendButton(button:UIButton){
    self.buttons.append(button)
    setupButtons()
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  public func appendButtons(buttons:[UIButton]){
    self.buttons.appendContentsOf(buttons)
    setupButtons()
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  public func buttonAtIndex(index:Int) -> UIButton?{
    return ( index > -1 && index < buttons.count) ? buttons[index] : nil
  }
  
  public var firstButton:UIButton?{
    return buttonAtIndex(0)
  }
  
  public var secondButton:UIButton?{
    return buttonAtIndex(1)
  }
  
  public var thirdButton:UIButton?{
    return buttonAtIndex(2)
  }
  
  
  public init(
    buttons:[UIButton],
    alignment:GroupButtonBarAlignment = .Right
    ){
    self.buttons = buttons
    self.alignment = alignment
    super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 54))
    setupButtons()
  }
  
  func setupButtons(){
    for button in buttons{
      button.removeFromSuperview()
      addSubview(button)
      button.addTarget(self, action: "onPressedButton:", forControlEvents: .TouchUpInside)
    }
  }

  func onPressedButton(sender:UIButton){
    onButtonClicked?(sender)
  }
  
 public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    switch alignment{
    case .Right:layoutButtonsAlignRight()
    case .Left:layoutButtonsAlignLeft()
    }
    
  }
  
  private func layoutButtonsAlignLeft(){
    let originY = bounds.height * 0.5 - buttonHeight * 0.5
    var buttonFrame = CGRect(x: margin, y: originY, width: buttonWidth, height: buttonHeight)
    for button in buttons{
      button.frame = buttonFrame
      buttonFrame.offsetInPlace(dx: buttonWidth + buttonSpace, dy: 0)
    }
  }
  
  private func layoutButtonsAlignRight(){
    let originY = bounds.height * 0.5 - buttonHeight * 0.5
    var buttonFrame = CGRect(x: bounds.maxX - margin, y: originY, width: buttonWidth, height: buttonHeight)
    for button in buttons{
      button.frame = buttonFrame
      buttonFrame.offsetInPlace(dx: -(buttonWidth + buttonSpace), dy: 0)
    }
  }
  
}