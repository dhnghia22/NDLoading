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

public class NDLoadingSetting {
    public var mainColor: UIColor?
    public var mainBackgroundColor: UIColor?
    public var widthLoading: CGFloat?
    public var mainCornerRadius: CGFloat?
    public init(mainColor: UIColor? = nil, mainBackgroundColor: UIColor? = nil, widthLoading: CGFloat? = nil, mainCornerRadius: CGFloat? = nil) {
        self.mainColor = mainColor
        self.mainBackgroundColor = mainBackgroundColor
        self.widthLoading = widthLoading
        self.mainCornerRadius = mainCornerRadius
    }
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

