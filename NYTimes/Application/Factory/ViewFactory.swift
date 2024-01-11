//
//  ViewFactory.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation
import core_architecture
import Debugger
import Dependencies
public enum DebuggerViewFactoryInput {
case breakpoint, debug(NetworkDebuggerActions)
}
extension SwiftUIViewFactory {
    enum NYTViewsInput {
    case list(isLoading: Bool, error: String?, articles: [NYTArticleUIM]), detail(NYTArticleUIM?)
    }
    func makeView(input: NYTViewsInput) -> any SwiftUIView {
        switch input {
        case .list(let isLoading, let error, let articles):
            return NYTViewModule<NYTListView<NYTListViewModel>>(
                input: .init(
                    vm: .init(isLoading: isLoading, error: error, articles: articles)
                )
            ).view()
        case .detail(let article):
            return NYTViewModule<NYTDetailView<NYTDetailViewModel>>(
                input: .init(
                    vm: .init(article: article)
                )
            ).view()
        }
    }
}

