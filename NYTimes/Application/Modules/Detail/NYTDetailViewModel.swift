//
//  NYTDetailViewModel.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Foundation

public final class NYTDetailViewModel: NYTDetailViewModeling {
    public var article: NYTArticleUIM? = nil
    
    public init(article: NYTArticleUIM? = nil) {
        self.article = article
    }
}
