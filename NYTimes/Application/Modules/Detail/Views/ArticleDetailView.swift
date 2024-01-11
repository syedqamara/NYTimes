//
//  ArticleDetailView.swift
//  NYTimes
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import SwiftUI

public struct ArticleDetailView: View {
    let article: NYTArticleUIM

    public var body: some View {
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

public struct ArticleDetailView_Previews: PreviewProvider {
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    public static var snapshots: Previewer<NYTArticleUIM> {
        .init(
            configurations: [
                .init(name: "Preview", state: .init(dataModel: .preview))
            ]) { input in
                ArticleDetailView(article: input)
            }
    }
}
