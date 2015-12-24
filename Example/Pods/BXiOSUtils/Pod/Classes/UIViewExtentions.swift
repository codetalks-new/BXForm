//
//  UIViewExtentions.swift
//  Pods
//
//  Created by Haizhen Lee on 15/12/6.
//
//

import UIKit

public extension UIView /*frame based UI Layout*/ {
  public var width:CGFloat{
    set{
      var frame = self.frame
      frame.size.width = newValue
      self.frame = frame
    }get{
      return frame.width
    }
  }
  
 
  public var height:CGFloat{
    set{
      var frame = self.frame
      frame.size.height = newValue
      self.frame = frame
    }get{
      return frame.height
    }
  }
  
 
  public var size:CGSize{
    set{
      var frame = self.frame
      frame.size = newValue
      self.frame = frame
    }get{
      return frame.size
    }
  }
  
  public var origin:CGPoint{
    set{
      var frame = self.frame
      frame.origin = newValue
      self.frame = frame
    }get{
      return frame.origin
    }
  }
 
  public var centerX:CGFloat{
    set{
      center = CGPoint(x: newValue,y: center.y)
    }get{
      return center.x
    }
  }
  
  public var centerY:CGFloat{
    set{
      center = CGPoint(x: centerY,y: newValue)
    }get{
      return center.y
    }
  }
  
  
  public var minX:CGFloat{
    set{
      var frame = self.frame
      frame.origin.x = newValue
      self.frame = frame
    }get{
      return frame.minX
    }
  }
  
  public var maxX:CGFloat{
    set{
      var frame = self.frame
      frame.origin.x = newValue - frame.width
      self.frame = frame
    }get{
      return frame.maxX
    }
  }
  
  public var minY:CGFloat{
    set{
      var frame = self.frame
      frame.origin.y = newValue
      self.frame = frame
    }get{
      return frame.minY
    }
  }
  
  public var maxY:CGFloat{
    set{
      var frame = self.frame
      frame.origin.y = newValue - frame.height
      self.frame = frame
    }get{
      return frame.maxY
    }
  }
  
}
