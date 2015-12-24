//
//  MultipleSelectViewController.swift
//  Youjia
//
//  Created by Haizhen Lee on 15/11/12.
//


import UIKit
import SwiftyJSON
import BXModel


public class MultipleSelectViewController<T:BXBasicItemAware where T:Hashable>: UITableViewController {
    var options:[T] = []
    var adapter : SimpleTableViewAdapter<T>!
    var selectedItems :Set<T> = []
    var completionHandler : ( (Set<T>) -> Void )?
    var multiple = true
    var showSelectToolbar = true
  
   public init(options:[T] = []){
        self.options = options
        super.init(style: .Grouped)
    }
 
  
  public var selectAllButton:UIBarButtonItem?
  public override func loadView() {
    super.loadView()
    if showSelectToolbar{
      navigationController?.toolbarHidden = false
      navigationController?.toolbar.tintColor = FormColors.primaryColor
      let leftSpaceItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
      let selectAllButton = UIBarButtonItem(title:isSelectAll ? "全不选": "全选", style: .Plain, target: self, action: "selectAllButtonPressed:")
      selectAllButton.tintColor = UIColor.blueColor()
      toolbarItems = [leftSpaceItem,selectAllButton]
      self.selectAllButton = selectAllButton
    }
  }
  
  
  var isSelectAll = false
  func selectAllButtonPressed(sender:AnyObject){
    isSelectAll = !isSelectAll
    selectAllButton?.title = isSelectAll ? "全不选": "全选"
    if isSelectAll{
      selectedItems.unionInPlace(options)
    }else{
      selectedItems.removeAll()
    }
    tableView.reloadData()
  }
  
    public override func viewDidLoad() {
        super.viewDidLoad()
        adapter = SimpleTableViewAdapter(tableView: tableView, items:options, cellStyle: .Default)
        adapter.configureCellBlock = { (cell,indexPath) in
                let item = self.adapter.itemAtIndexPath(indexPath)
            cell.accessoryType =  self.selectedItems.contains(item) ? .Checkmark: .None
        }
        tableView.tableFooterView = UIView()
        if multiple{
          let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "selectDone:")
          self.navigationItem.rightBarButtonItem = doneButton
        }
      
        adapter.didSelectedItem = { (item,indexPath) in
            self.onSelectItem(item,atIndexPath:indexPath)
        }
    }
    
    func selectDone(sender:AnyObject){
        self.completionHandler?(selectedItems)
        #if DEBUG
        NSLog("selectDone")
        #endif
        let poped = navigationController?.popViewControllerAnimated(true)
      if poped == nil{
          dismissViewControllerAnimated(true, completion: nil)
      }
    }
    
    func onSelectItem(item:T,atIndexPath indexPath:NSIndexPath){
        guard let  cell = tableView.cellForRowAtIndexPath(indexPath) else{
            return
        }
      
        if selectedItems.contains(item){
            selectedItems.remove(item)
        }else{
            selectedItems.insert(item)
        }
       
        let isChecked = selectedItems.contains(item)
        cell.accessoryType = isChecked ? .Checkmark : .None
      
        if !multiple{
            selectDone(cell)
        }
    }

  public override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat.min
  }

}
