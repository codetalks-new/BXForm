//
//  AttributedTextFactory.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/23.
//
//

import UIKit
import BXiOSUtils

extension TextFactory{
  public static func createAccentAttributedText(label:String,text:String,labelColor:UIColor=UIColor.darkTextColor()) -> NSAttributedString{
    let labelAttr = BXTextAttribute(text: label, font: UIFont.systemFontOfSize(15), textColor: labelColor)
    let textAttr = BXTextAttribute(text: text, font: UIFont.systemFontOfSize(15), textColor: FormColors.accentColor)
    return createAttributedText([labelAttr,textAttr])
    
  }
}