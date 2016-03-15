//
//  ThumbnailType.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Foundation

/**
 The size of the thumbnail.
 
 - Small: 50x75px
 - Medium: 100x150px
 - XLarge: 150x225px
 - Fantastic: 168x252px
 - Uncanny: 300x450px
 - Incredible: 216x324px
 */
enum ThumbnailType: String {
    
    case Small = "portrait_small"
    case Medium = "portrait_medium"
    case XLarge = "portrait_xlarge"
    case Fantastic = "portrait_fantastic"
    case Incredible = "portrait_incredible"
    case Uncanny = "portrait_uncanny"
    
}
