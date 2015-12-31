//
//  OvalLabel.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/29.
//
//

import UIKit

public class OvalLabel:UILabel{
  
  public lazy var maskLayer : CAShapeLayer = { [unowned self] in
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.frame
    self.layer.mask = maskLayer
    return maskLayer
    }()
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    maskLayer.path = UIBezierPath(ovalInRect:bounds).CGPath
  }
  
//  public override func intrinsicContentSize() -> CGSize {
//    let size = super.intrinsicContentSize()
//    return CGSize(width: size.width + 8, height: size.height + 8)
//  }
}
