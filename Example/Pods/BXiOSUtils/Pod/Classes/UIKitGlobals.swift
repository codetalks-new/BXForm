//
//  UIKitGlobals.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//

import UIKit

public let screenScale = UIScreen.mainScreen().scale
public let screenWidth = UIScreen.mainScreen().bounds.width
public let screenHeight = UIScreen.mainScreen().bounds.height
public var designBaseWidth:CGFloat = 375 //  // Design Pointer to Devices Pointer

public func dp2dp(dp:CGFloat) -> CGFloat{
  let coefficent = screenWidth / designBaseWidth
  return ceil(dp * coefficent)
}