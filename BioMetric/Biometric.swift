//
//  Biometric.swift
//  BioMetric
//
//  Created by Muhammad Umar Farooq on 3/1/19.
//  Copyright © 2019 Umar Farooq. All rights reserved.
//

import Foundation
import LocalAuthentication

var biometricType: LABiometryType{
    let authContext = LAContext()
    if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
        return authContext.biometryType
        /*
        authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need your TouchID", reply: { (success, error) in
            if success {
                
            }else{
                
            }
        })*/
    }
    return .none
}
