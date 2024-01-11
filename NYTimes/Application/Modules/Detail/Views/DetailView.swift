//
//  DetailView.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation
import core_architecture
import Dependencies
import SwiftUI

public struct NYTDetailView<VM: NYTDetailViewModeling>: SwiftUIView {
    public typealias ViewModelType = VM
    
    @StateObject var viewModel: VM
    public init(viewModel: VM) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    public var body: some View {
        if let article = viewModel.article {
            ArticleDetailView(article: article)
                .navigationTitleView(article.title ?? "", font: .caption)
        }
    }
}






public struct NYTDetailView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var viewFactory
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    public static var snapshots: Previewer<NYTArticleUIM> {
        .init(
            configurations: [
                .init(name: "Preview", state: .init(dataModel: .preview))
            ]) { input in
                NYTDetailView(
                    viewModel: NYTDetailViewModel(article: input)
                )
            }
    }
}
