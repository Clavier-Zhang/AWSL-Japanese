//
//  UIDevice.swift
//  awsl
//
//  Created by clavier on 2020-01-02.
//  Copyright © 2020 clavier. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {
    
    static let isPad = UIDevice.modelName == "iPad"

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone"
            case "iPhone4,1":                               return "iPhone"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone"
            case "iPhone7,2":                               return "iPhone"
            case "iPhone7,1":                               return "iPhone"
            case "iPhone8,1":                               return "iPhone"
            case "iPhone8,2":                               return "iPhone"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone"
            case "iPhone8,4":                               return "iPhone"
            case "iPhone10,1", "iPhone10,4":                return "iPhone"
            case "iPhone10,2", "iPhone10,5":                return "iPhone"
            case "iPhone10,3", "iPhone10,6":                return "iPhone"
            case "iPhone11,2":                              return "iPhone"
            case "iPhone11,4", "iPhone11,6":                return "iPhone"
            case "iPhone11,8":                              return "iPhone"
            case "iPhone12,1":                              return "iPhone"
            case "iPhone12,3":                              return "iPhone"
            case "iPhone12,5":                              return "iPhone"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad"
            case "iPad6,11", "iPad6,12":                    return "iPad"
            case "iPad7,5", "iPad7,6":                      return "iPad"
            case "iPad7,11", "iPad7,12":                    return "iPad"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad"
            case "iPad5,3", "iPad5,4":                      return "iPad"
            case "iPad11,4", "iPad11,5":                    return "iPad"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad"
            case "iPad5,1", "iPad5,2":                      return "iPad"
            case "iPad11,1", "iPad11,2":                    return "iPad"
            case "iPad6,3", "iPad6,4":                      return "iPad"
            case "iPad6,7", "iPad6,8":                      return "iPad"
            case "iPad7,1", "iPad7,2":                      return "iPad"
            case "iPad7,3", "iPad7,4":                      return "iPad"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}
