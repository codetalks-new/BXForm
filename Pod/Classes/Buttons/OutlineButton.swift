//
//  OutlineButton.swift
//  SubjectEditorDemo
//
//  Created by Haizhen Lee on 15/6/3.
//  Copyright (c) 2015年 banxi1988. All rights reserved.
//

import UIKit

public enum BXOutlineStyle:Int{
  case Rounded
  case Oval
}

public class OutlineButton: UIButton {
  public var outlineStyle = BXOutlineStyle.Rounded{
    didSet{
      setNeedsDisplay()
    }
  }
  
  public var cornerRadius:CGFloat = 4.0 {
    didSet{
      setNeedsDisplay()
    }
  }
  
  public var lineWidth :CGFloat = 1.0 {
    didSet{
      setNeedsDisplay()
    }
  }
  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    // Drawing code
    let pathRect = rect.insetBy(dx: lineWidth, dy: lineWidth)
    let path:UIBezierPath
    if outlineStyle == .Rounded{
      path = UIBezierPath(roundedRect: pathRect, cornerRadius: cornerRadius)
    }else{
      path = UIBezierPath(ovalInRect: pathRect)
    }
    path.lineWidth = lineWidth
    if let color = tintColor{
      color.setStroke()
      path.stroke()
    }
  }
  
  public override func tintColorDidChange() {
    super.tintColorDidChange()
    setNeedsDisplay()
  }
  
}
