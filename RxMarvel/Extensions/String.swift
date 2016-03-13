//
//  String.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Foundation

extension String {
    
    var md5: String {
        
        let string = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let stringLength = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLength)
        
        CC_MD5(string!, stringLength, result)
        
        var hash = String()
        
        for i in 0 ..< digestLength {
            hash += String(format: "%02x", result[i])
        }
        
        result.destroy()
        
        return hash
    }
    
}
