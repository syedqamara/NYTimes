//
//  NYTListView.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation
import SwiftUI
import core_architecture
import Dependencies
import DebuggerUI

public struct NYTListView<VM: NYTListViewModeling>: SwiftUIView {
    @Dependency(\.viewFactory) var viewFactory
    public typealias ViewModelType = VM
    @StateObject var viewModel: VM
    public init(viewModel: VM) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            if viewModel.isLoading {
                AnimatedView(animationFileName: "loading", loopMode: .loop, size: CGSize(width: 50, height: 50))
                .scaleEffect(.init(width: 0.35, height: 0.35))
            }
            else if let error = viewModel.error {
                Text(error)
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
            }else {
                ScrollView {
                    ForEach(viewModel.articles) { article in
                        articleCell(article: article)
                    }
                }
            }
        }
        .padding(.top, 10)
        .background(Color.gray.opacity(0.1))
        .onAppear() {
            viewModel.onAppear()
        }
        .navigationTitleView("NYTimes Articles")
        .navigationBarTitleDisplayMode(.large)
    }
    
    @ViewBuilder
    func articleCell(article: NYTArticleUIM) -> some View {
        NavigationLink {
            AnyView(
                viewFactory.makeView(
                    input: .detail(article)
                )
            )
            .navigationTitle("NYTimes Article Detail")
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            NYTArticleView(article: article)
        }
    }
}


public struct NYTListView_Previews: PreviewProvider {
    @Dependency(\.viewFactory) static var viewFactory
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    public struct Input {
        public let isLoading: Bool
        public let error: String?
        public let articles: [NYTArticleUIM]
        public init(isLoading: Bool, error: String?, articles: [NYTArticleUIM]) {
            self.isLoading = isLoading
            self.error = error
            self.articles = articles
        }
    }
    public static var snapshots: Previewer<Input> {
        .init(
            configurations: [
                .init(name: "Preview Loading", state: .init(isLoading: true, error: nil, articles: [])),
                .init(name: "Preview Error", state: .init(isLoading: false, error: "This is a preview error", articles: [])),
                .init(name: "Preview Article", state: .init(isLoading: false, error: nil, articles: [.init(dataModel: .preview), .init(dataModel: .preview), .init(dataModel: .preview)]))
            ]) { input in
                NYTListView(
                    viewModel: NYTListViewModel(isLoading: input.isLoading, error: input.error, articles: input.articles)
                )
            }
    }
}
