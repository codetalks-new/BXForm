//
//  TwoStageCascadeSelectPickerController.swift
//  Pods
//
//  Created by Haizhen Lee on 16/6/14.
//
//

import UIKit

public protocol ChildPickerItem: CustomStringConvertible,Equatable{
  
}
public protocol ParentPickerItem: CustomStringConvertible,Equatable,Hashable{
}


public class TwoStageCascadeSelectPickerController<T:ParentPickerItem,C:ChildPickerItem>:PickerController,UIPickerViewDataSource,UIPickerViewDelegate{
  public typealias ParentChildDict = Dictionary<T,[C]>
  private var dict: ParentChildDict = [:]
  private var parents:[T] = []
  
  public var parentCount:Int{
    return parents.count
  }
  
  public func childCountAtSection(section:Int) -> Int{
    return childrenAtSection(section).count
  }
  
  public func childrenAtSection(section:Int) -> [C]{
    return dict[parentAtSection(section)]!
  }
  
  public func parentAtSection(section:Int) -> T {
    return parents[section]
  }
  
  public func childAtSection(section:Int,index:Int) -> C{
    return childrenAtSection(section)[index]
  }
  
  public var rowHeight:CGFloat = 36{
    didSet{
      picker.reloadAllComponents()
    }
  }
  public var textColor = UIColor.darkTextColor(){
    didSet{
      picker.reloadAllComponents()
    }
  }
  public var font = UIFont.systemFontOfSize(14){
    didSet{
      picker.reloadAllComponents()
    }
  }
  
  public var onSelectOption:((T,C) -> Void)?
  
  public init(parents:[T],dict:ParentChildDict){
    super.init(nibName: nil, bundle: nil)
    self.updateOptions(parents,dict:dict)
  }
  
  public init(){
    super.init(nibName: nil, bundle: nil)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    picker.delegate = self
    picker.dataSource = self
    picker.showsSelectionIndicator = true
  }
  
  
  public func selectOption(option:T,of item:C){
    let index = parents.indexOf { $0 == option }
    if let section = index{
      let rowIndex = childrenAtSection(section).indexOf {$0 == item }
      if let row = rowIndex {
        picker.selectRow(row, inComponent: section, animated: true)
      }
    }
    
  }
  
  public func updateOptions(parents:[T],dict:ParentChildDict){
    self.parents = parents
    self.dict = dict
    if isViewLoaded(){
      picker.reloadAllComponents()
    }
  }
  

  var selectedSection:Int{
    return picker.selectedRowInComponent(0)
  }
  
 
  
  // MARK: UIPickerViewDataSource
  public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 2
  }
  
  public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if parents.isEmpty || dict.isEmpty {
      return 0
    }
    switch component{
    case 0: return parents.count
    case 1:
      let parentRow = pickerView.selectedRowInComponent(0)
      let count = childCountAtSection(parentRow)
      return count
    default: return 0
    }
  }
  
  
  // MARK: UIPickerViewDelegate
  public func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return rowHeight
  }
  
  public func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let option:CustomStringConvertible
    switch component{
    case 0: option = parentAtSection(row)
    case 1:
      let section = pickerView.selectedRowInComponent(0)
      let children = childrenAtSection(section)
      if children.count <= row {
        return nil
      }else{
        option = children[row]
      }
    default:return nil
    }
    let title = option.description
    let attributedText = NSAttributedString(string: title, attributes: [
      NSForegroundColorAttributeName:textColor,
      NSFontAttributeName:font
      ])
    return attributedText
  }
  
  public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0{
      pickerView.reloadComponent(1)
//      if childCountAtSection(1) > 0 {
//        pickerView.selectRow(0, inComponent: 1, animated: true)
//      }
    }
  }
  
  // MARK: Base Controller
  override public func onPickDone() {
    if parents.isEmpty || dict.isEmpty{
      return
    }
    let parentRow = picker.selectedRowInComponent(0)
    let childRow = picker.selectedRowInComponent(1)
    let parent = parentAtSection(parentRow)
    let children = childrenAtSection(parentRow)
    if children.count <= childRow {
      return
    }
    
    let child = children[childRow]
    onSelectOption?(parent,child)
  }
  
}