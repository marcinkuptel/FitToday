//
//  OAuthConstants.swift
//  FitToday
//
//  Created by Marcin Kuptel on 14/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

enum OAuthConstants: String {
    case ConsumerKey = ""
    case ConsumerSecret = " "
    case RequestTokenURL = "https://api.fitbit.com/oauth/request_token"
    case AuthorizeURL = "https://www.fitbit.com/oauth/authorize"
    case AccessTokenURL = "https://api.fitbit.com/oauth/access_token"
}