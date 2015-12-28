//
//  HRTime.swift
//  HRTime
//
//  Created by Evan Lucas on 12/28/15.
//  Copyright © 2015 Evan Lucas. All rights reserved.
//

import Foundation
import Darwin.Mach.mach_time

public func hrtime() -> UInt64 {
  var info = mach_timebase_info_data_t(numer: 0, denom: 0)
  mach_timebase_info(&info)
  
  let num = UInt64(info.numer)
  let den = UInt64(info.denom)
  return mach_absolute_time() * num / den
}

public func hrtime(prev:UInt64) -> UInt64 {
  return hrtime() - prev
}