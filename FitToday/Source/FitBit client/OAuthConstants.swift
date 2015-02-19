//
//  OAuthConstants.swift
//  FitToday
//
//  Created by Marcin Kuptel on 14/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

enum OAuthConstants: String {
    case ConsumerKey = "ea2390368f1641ae8a4c0491974331e0"
    case ConsumerSecret = "2c146e029ad04f7a899af67aa6c82d8c"
    case RequestTokenURL = "https://api.fitbit.com/oauth/request_token"
    case AuthorizeURL = "https://www.fitbit.com/oauth/authorize"
    case AccessTokenURL = "https://api.fitbit.com/oauth/access_token"
}