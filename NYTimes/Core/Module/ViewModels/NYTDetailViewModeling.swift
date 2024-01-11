//
//  NYTDetailViewModeling.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation
import core_architecture

public protocol NYTDetailViewModeling: ViewModeling {
    var article: NYTArticleUIM? { get }
}
