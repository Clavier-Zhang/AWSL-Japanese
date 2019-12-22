//
//  notification.swift
//  awsl
//
//  Created by clavier on 2019-12-21.
//  Copyright © 2019 clavier. All rights reserved.
//

import Foundation
import NotificationBannerSwift

func notification(_ message: String, _ type: BannerStyle) {
    let banner = StatusBarNotificationBanner(title: message, style: type)
    
    banner.show()
}
