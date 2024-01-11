//
//  NYTimesDM+Preview.swift
//  NYTimes
//
//  Created by Apple on 12/01/2024.
//

import Foundation

// Extension for NYTimesDM
extension NYTimesDM {
    static var preview: NYTimesDM {
        return NYTimesDM(
            status: "OK",
            copyright: "© 2024 New York Times",
            numResults: 1,
            results: [NYTArticle.preview]
        )
    }
}

// Extension for NYTArticle
extension NYTArticle {
    static var preview: NYTArticle {
        return NYTArticle(
            uri: "nyt://article/123456",
            url: "https://www.nytimes.com/123456",
            id: 123456,
            assetId: 789012,
            source: "New York Times",
            publishedDate: "2024-01-10",
            updated: "2024-01-11T08:00:00Z",
            section: "Technology",
            subsection: "Science",
            nytdsection: "sci-tech",
            adxKeywords: "technology, science, innovation",
            column: nil,
            byline: "John Doe",
            type: "Article",
            title: "Sample Article",
            abstract: "This is a sample article abstract.",
            desFacet: ["Technology", "Innovation"],
            orgFacet: ["NY Times"],
            perFacet: ["John Doe"],
            geoFacet: ["New York"],
            media: [NYTMedia.preview],
            etaId: 987654
        )
    }
}

// Extension for NYTMedia
extension NYTMedia {
    static var preview: NYTMedia {
        return NYTMedia(
            type: "image",
            subtype: "photo",
            caption: "A sample photo",
            copyright: "© 2024 New York Times",
            approvedForSyndication: 1,
            mediaMetadata: [NYTMediaMetadata.preview]
        )
    }
}

// Extension for NYTMediaMetadata
extension NYTMediaMetadata {
    static var preview: NYTMediaMetadata {
        return NYTMediaMetadata(
            url: "preview_url",
            format: "Standard Thumbnail",
            height: 150,
            width: 150
        )
    }
}
