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
  
  public init(style:BXOutlineStyle = .Rounded){
    super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    outlineStyle = style
  }
  public var useTitleColorAsStrokeColor = true
  

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
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
  
  public var lineWidth :CGFloat = 0.5 {
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
    if useTitleColorAsStrokeColor{
      currentTitleColor.setStroke()
    }else{
      tintColor.setStroke()
    }
    path.stroke()
  }
  
  public override func tintColorDidChange() {
    super.tintColorDidChange()
    setNeedsDisplay()
  }
  
}
