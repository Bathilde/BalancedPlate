//
//  BalancedPlateWidgetBundle.swift
//  BalancedPlateWidget
//
//  Created by Bathilde Rocchia on 09/05/2026.
//

import WidgetKit
import SwiftUI

@main
struct BalancedPlateWidgetBundle: WidgetBundle {
    var body: some Widget {
        BalancedPlateWidget()
        BalancedPlateWidgetControl()
        BalancedPlateWidgetLiveActivity()
    }
}
