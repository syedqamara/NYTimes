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
            articleView(article: article)
        }
    }
    
    @ViewBuilder
    func articleView(article: NYTArticleUIM) -> some View {
        HStack {
            // Rounded Image
            if let imageURL = article.media?.last?.mediaMetadata?.last?.url {
                RemoteImage(
                    url: imageURL,
                    lottiePlaceholder: Lotties.loading,
                    size: CGSize(width: 50, height: 50)
                )
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.vertical)
                .padding(.horizontal, 10)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.vertical)
                    .padding(.horizontal, 10)
            }
            
            
            
            // VStack with Title, Subtitle, and HStack
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title ?? "")
                    .font(.subheadline.bold())
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text(article.byline ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    // Author Name and Date
                    Text("\(article.source ?? "")")
                        .font(.callout.bold())
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    Spacer()
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                        Text("\(article.publishedDate ?? "")")
                            .font(.callout.bold())
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
            }
            Spacer()
            // Arrow
            Image(systemName: "chevron.right")
                .resizable()
                .font(.title.bold())
                .frame(width: 10, height: 15)
                .foregroundColor(.gray)
                .padding(.trailing)
        }
    }
    
}

