//
//  OutlineLabel.swift
//  Pods
//
//  Created by Haizhen Lee on 16/6/8.
//
//

import UIKit

public class OutlineLabel:PaddingLabel{
  
  public var borderColor:UIColor = UIColor(hex: 0xe0e0e0){
    didSet{
      layer.borderColor = borderColor.CGColor
    }
  }
  
  public var borderWidth:CGFloat = 0.5{
    didSet{
      layer.borderWidth = borderWidth
    }
  }
  
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.CGColor
    clipsToBounds = true
  }
}