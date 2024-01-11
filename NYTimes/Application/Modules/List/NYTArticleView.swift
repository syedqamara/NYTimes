//
//  NYTArticleView.swift
//  NYTimes
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import SwiftUI

public struct NYTArticleView: View {
    public var article: NYTArticleUIM
    
    public var body: some View {
        articleView(article: article)
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

public struct NYTArticleView_Previews: PreviewProvider {
    
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    public static var snapshots: Previewer<NYTArticleUIM> {
        .init(
            configurations: [
                .init(name: "Preview", state: .init(dataModel: .preview))
            ]) { article in
                NYTArticleView(article: article)
            }
    }
}
