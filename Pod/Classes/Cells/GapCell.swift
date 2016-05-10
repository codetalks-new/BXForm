//
//  GapCell.swift
//  Pods
//

import UIKit
import BXModel

class GapCell : StaticTableViewCell{
  
  
  convenience init() {
    self.init(height:10)
  }
  
  convenience init(height:CGFloat) {
    self.init(style: .Default, reuseIdentifier: "GapCellCell")
    staticHeight = height
  }
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  var allOutlets :[UIView]{
    return []
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func commonInit(){
    for childView in allOutlets{
      contentView.addSubview(childView)
      childView.translatesAutoresizingMaskIntoConstraints = false
    }
    installConstaints()
    setupAttrs()
    
  }
  
  func installConstaints(){
  }
  
  func setupAttrs(){
    backgroundColor = FormColors.backgroundColor
  }
}