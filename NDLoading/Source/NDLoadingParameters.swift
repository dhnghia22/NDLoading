//
//  NDLoadingParameters.swift
//  NDLoading
//
//  Created by Nghia Dinh on 4/7/21.
//

import Foundation
import UIKit


protocol NDLoadingSettingProtocol {
    var setting: NDLoadingSetting? { get set }
    func stopAnimation()
}

public struct NDLoadingSetting {
    var mainColor: UIColor?
    var mainBackgroundColor: UIColor?
    var widthLoading: CGFloat?
    var mainCornerRadius: CGFloat?
}

public enum LoadingStyle {
    case Style1
    case Style2
    case Style3
    case Style4
    case Style5
    case Style6
    case Style7
}

