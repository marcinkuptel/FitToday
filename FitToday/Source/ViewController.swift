//
//  ViewController.swift
//  FitToday
//
//  Created by Marcin Kuptel on 13/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import UIKit
import OAuthSwift


class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if false {
            // OAuth1.0
            let oauthswift = OAuth1Swift(
                consumerKey:    "",
                consumerSecret: "",
                requestTokenUrl: "https://api.fitbit.com/oauth/request_token",
                authorizeUrl:    "https://www.fitbit.com/oauth/authorize",
                accessTokenUrl:  "https://api.fitbit.com/oauth/access_token"
            )
            
            
            let failure = {
                (error: NSError) -> Void in
                
            }
            
            oauthswift.authorizeWithCallbackURL(NSURL(string: "oauth-swift://oauth-callback/fitbit")!,
                success: {
                    credential, response in
                    println(credential.oauth_token)
                    println(credential.oauth_token_secret)
                }, failure: failure)
        }
        
        
        let urlString = "https://api.fitbit.com/1/user/-/profile.json"
        let consumer_secret = ""
        let oauth_token_secret = "20712b1315c0787a2fbb5b4a08381d7f"
        let httpMethod = "GET"
        let url = NSURL(string: urlString)
        let oauth_consumer_key = ""
        let oauth_token = "8493cd3bcda7171d832aa847b210dd7c"
        let oauth_signature_method = "HMAC-SHA1"
        let oauth_timestamp = NSString(format: "%i", Int(NSDate().timeIntervalSince1970))
        let oauth_nonce = NSUUID().UUIDString
        let oauth_version = "1.0"
        
        let params = [
            "oauth_consumer_key" : oauth_consumer_key,
            "oauth_token" : oauth_token,
            "oauth_signature_method" : oauth_signature_method,
            "oauth_timestamp" : oauth_timestamp,
            "oauth_nonce" : oauth_nonce,
            "oauth_version" : oauth_version
        ]
        
        
        let signatureBaseString = String(format: "%@&%@&%@", encodeString(httpMethod), encodeString(urlString), encodeString(computeParameterString(params)))
        println(String(format: ">>>> Signature base string: %@", signatureBaseString))
        let signingKey = String(format: "%@&%@", encodeString(consumer_secret), encodeString(oauth_token_secret))
        println(String(format: ">>>> Signing key: %@", signingKey))
        let signature = signatureBaseString.hmac(HMACAlgorithm.SHA1, key: signingKey)
        println(String(format: ">>>> Nonce: %@", oauth_nonce))
        println(String(format: ">>>> Timestamp: %@", oauth_timestamp))
        
        let format = "OAuth oauth_consumer_key=\"%@\", oauth_token=\"%@\", oauth_nonce=\"%@\", oauth_signature=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_version=\"%@\""
        let authHeader = String(format: format, oauth_consumer_key, oauth_token, oauth_nonce, encodeString(signature), oauth_signature_method, oauth_timestamp, oauth_version)
        println(authHeader)
        
        var request = NSMutableURLRequest(URL: url!)
        request.addValue(authHeader, forHTTPHeaderField: "Authorization")
        
        let session = NSURLSession.sharedSession()
        
        let completion = {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            let response = NSString(data: data, encoding: NSUTF8StringEncoding)
            println(response)
        }
        
        var task = session.dataTaskWithRequest(request, completionHandler: completion)
        task.resume()

}
    
    func computeParameterString(params: [String:String]) -> String
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
    
    
    func encodeString(str: String) -> String {
        var customAllowedSet =  NSCharacterSet(charactersInString:":=\"#%/<>?@\\^`{|}&").invertedSet
        var escapedString = str.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        return escapedString!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

