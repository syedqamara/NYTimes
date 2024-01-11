//
//  DetailView.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation
import core_architecture
import UIKit
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
struct ArticleDetailView: View {
    let article: NYTArticleUIM

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Display important information
                Text("Details")
                    .font(.title.bold())
                
                informationView()
                
                
                // Display more details
                VStack(alignment: .leading, spacing: 8) {
                    Text("Abstract:")
                        .font(.title.bold())
                    
                    Text(article.abstract ?? "")
                }
                
                // Display media information
                if let media = article.media, !media.isEmpty {
                    Text("Media:")
                        .font(.title.bold())
                    
                    ForEach(media) { mediaItem in
                        MediaView(media: mediaItem)
                    }
                }
            }
            .padding()
        }
    }
    @ViewBuilder
    func informationView() -> some View {
        VStack {
            InformationRow(label: "Title", value: article.title)
            
            InformationRow(label: "Published Date", value: article.publishedDate)
            
            InformationRow(label: "Type", value: article.type)
            
            InformationRow(label: "Source", value: article.source)
            
            InformationRow(label: "Adx Keywords", value: article.adxKeywords)
            
            InformationRow(label: "NYTimes Section", value: article.nytdsection)
            
            InformationRow(label: "Section", value: article.section)
            
            InformationRow(label: "Sub-Section", value: article.subsection)
            
            InformationRow(label: "Byline", value: article.byline)
        }
    }
}

struct InformationRow: View {
    let label: String
    let value: String?

    var body: some View {
        if let value, value.isNotEmpty {
            HStack {
                Text("\(label):")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .multilineTextAlignment(.trailing)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
    }
}

struct MediaView: View {
    let media: NYTMediaUIM

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            InformationRow(label: "Type", value: media.type ?? "")
            InformationRow(label: "Caption", value: media.caption ?? "")
            // Display media metadata
            if let metadata = media.mediaMetadata, !metadata.isEmpty {
                Text("Media Metadata:")
                    .font(.headline)
                
                ForEach(metadata) { metadataItem in
                    MediaMetadataView(metadata: metadataItem)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.bottom, 8)
    }
}

struct MediaMetadataView: View {
    let metadata: NYTMediaMetadataUIM

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let url = metadata.url, let height = CGFloat(metadata.height ?? 0), let width = CGFloat(metadata.width ?? 0)  {
                HStack {
                    RemoteImage(
                        url: url,
                        lottiePlaceholder: Lotties.loading,
                        size: .init(width: height, height: width)
                    )
                }
                .frame(maxWidth: width, maxHeight: height)
            }
            InformationRow(label: "Format", value: metadata.format ?? "")
            InformationRow(label: "Height", value: String(metadata.height ?? 0))
            InformationRow(label: "Width", value: String(metadata.width ?? 0))
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.bottom, 8)
    }
}
