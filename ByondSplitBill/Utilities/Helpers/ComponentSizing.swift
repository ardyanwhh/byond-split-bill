//
//  ComponentSizing.swift
//  ByondSplitBill
//
//  Created by Ardyan Atmojo on 07/05/25.
//

import UIKit

import UIKit

private let screen = UIScreen.main.bounds
private let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
private let bottomSafeArea = safeAreaInsets?.bottom ?? 0

extension CGRect {
    
    enum DeviceGeometryReader {
        case screenBounds
    }
    
    static func apply(currentDevice option: DeviceGeometryReader) -> CGRect {
        switch option {
        case .screenBounds: return screen
        }
    }
}

extension CGFloat {
    
    enum DeviceGeometryReader {
        case screenWidth
        case screenHeight
        case statusBarHeight
    }
    
    static func apply(currentDevice option: DeviceGeometryReader) -> CGFloat {
        switch option {
        case .screenWidth: return screen.width
        case .screenHeight: return screen.height
        case .statusBarHeight: return safeAreaInsets?.top ?? 0
        }
    }
    
    static let isOldScreenRatio: Bool = screen.height / screen.width < 1.8
}

