//
//  HMAC.swift
//  FitToday
//
//  Created by Marcin Kuptel on 14/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    func hmac(# key: String) -> String
    {
        let keyData = key.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        let messageData = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        
        let data = Authenticator.HMAC(key: keyData, variant: HMAC.Variant.sha1).authenticate(messageData)
        var hmacBase64 = data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding76CharacterLineLength)
        
        return String(hmacBase64)
    }
}