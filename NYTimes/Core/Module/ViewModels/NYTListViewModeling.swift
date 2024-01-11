//
//  NYTListViewModeling.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import core_architecture

public protocol NYTListViewModeling: ViewModeling {
    var isLoading: Bool { get }
    var error: String? { get }
    var articles: [NYTArticleUIM] { get }
    func onAppear()
}
