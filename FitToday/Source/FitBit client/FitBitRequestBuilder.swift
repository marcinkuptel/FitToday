//
//  FitBitRequestBuilder.swift
//  FitToday
//
//  Created by Marcin Kuptel on 14/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

class FitBitRequestBuilder: NSObject {

    class func getUserInfoRequest(tokenKeeper: OAuthTokenKeeper) -> NSURLRequest
    {
        return buildRequest(tokenKeeper, endpoint: FitBitEndpoints.GetUserInfo)
    }
    
    class func getActivityStatsRequest(tokenKeeper: OAuthTokenKeeper) -> NSURLRequest
    {
        return buildRequest(tokenKeeper, endpoint: FitBitEndpoints.GetActivityStats)
    }
    
    private class func buildRequest(tokenKeeper: OAuthTokenKeeper, endpoint: FitBitEndpoints) -> NSURLRequest
    {
        let httpMethod = "GET"
        let url = NSURL(string: endpoint.URL())
        let oauth_signature_method = "HMAC-SHA1"
        let oauth_timestamp = NSString(format: "%i", Int(NSDate().timeIntervalSince1970))
        let oauth_nonce = NSUUID().UUIDString
        let oauth_version = "1.0"
        
        let params = [
            "oauth_consumer_key" : OAuthConstants.ConsumerKey.rawValue,
            "oauth_token" : tokenKeeper.oauthToken()!,
            "oauth_signature_method" : oauth_signature_method,
            "oauth_timestamp" : oauth_timestamp,
            "oauth_nonce" : oauth_nonce,
            "oauth_version" : oauth_version
        ]
        
        
        let signatureBaseString = String(format: "%@&%@&%@", encodeString(httpMethod), encodeString(endpoint.URL()), encodeString(computeParameterString(params)))
        let signingKey = String(format: "%@&%@", encodeString(OAuthConstants.ConsumerSecret.rawValue), encodeString(tokenKeeper.oauthTokenSecret()!))
        let signature = signatureBaseString.hmac(key: signingKey)
        
        let format = "OAuth oauth_consumer_key=\"%@\", oauth_token=\"%@\", oauth_nonce=\"%@\", oauth_signature=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_version=\"%@\""
        let authHeader = String(format: format, OAuthConstants.ConsumerKey.rawValue, tokenKeeper.oauthToken()!, oauth_nonce, encodeString(signature), oauth_signature_method, oauth_timestamp, oauth_version)
        
        var request = NSMutableURLRequest(URL: url!)
        request.addValue(authHeader, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    private class func computeParameterString(params: [String:String]) -> String
    {
        var encodedValues: [String:String] = [String:String]()
        
        for (parameter, value) in params {
            let parameterEncoded = encodeString(parameter)
            let valueEncoded = encodeString(value)
            encodedValues[parameterEncoded] = valueEncoded
        }
        
        let sortedKeys = ([String](encodedValues.keys)).sorted {$0 < $1}
        
        var pairs = [String]()
        for key in sortedKeys {
            let format = "%@=%@"
            let result = NSString(format: format, key, encodedValues[key]!)
            pairs.append(result)
        }
        
        return "&".join(pairs)
    }
    
    
    private class func encodeString(str: String) -> String
    {
        var customAllowedSet =  NSCharacterSet(charactersInString:":=\"#%/<>?@\\^`{|}&").invertedSet
        var escapedString = str.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        return escapedString!
    }
    
}
