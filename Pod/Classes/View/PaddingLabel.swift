//
//  PaddingLabel.swift
//  Youjia
//
//  Created by Haizhen Lee on 16/4/11.
//  Copyright © 2016年 xiyili. All rights reserved.
//

import Foundation

public class PaddingLabel:UILabel{
  public var horizontalPadding:CGFloat = 4
  public var verticalPadding: CGFloat = 4
  
  public override func intrinsicContentSize() -> CGSize {
    let size = super.intrinsicContentSize()
    return CGSize(width: size.width + horizontalPadding * 2, height: size.height + verticalPadding*2)
  }
}