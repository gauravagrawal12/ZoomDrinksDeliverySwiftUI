//
//  ApplicationSessionManager.swift
//  MVVM_Template
//
//  Created by Gaurav Agrawal on 17/01/23.
//

import Foundation

class ApplicationSessionManager {
    
    public static let installedStatus = "Not_First_Installed"
    public static let installedLoginStatus = "Not_First_LoggedIn"
    
    public static func startManageSession(_ sessionkey:String) { LocalStorage.set(sessionkey, forKey: key_session_manage) }
    
    public static func checkSessionStatus() -> Bool{
        
        if let session_status = LocalStorage.value(forKey: key_session_manage) as? String {
            if session_status == key_session_login { return true }
            else { return false }
        }
        else { return false }
    }
    
    public static func getSessionStatus() -> String {
        return (LocalStorage.value(forKey: key_session_manage) as? String) ?? key_session_logout
    }
    
    public static func storeUserDetailsInLocal<T:Codable>(_ user_info:T) {
        
        if let encoded = try? JSONEncoder().encode(user_info) {
            
            LocalStorage.set(encoded, forKey: key_user_info)
            ApplicationSessionManager.startManageSession(key_session_login)
        }
    }
    
    public static func storeUserIDInLocal(userID : String) {
        LocalStorage.set(userID, forKey: key_user_id)
    }
    
    
    public static func getCurrentUserID() -> String? {
        return (LocalStorage.value(forKey: key_user_id) as? String) ?? ""
    }
    
    public static func getUserDetailsFromLocal() -> OTPModuleResponseRequest?
    {
        var user_info: OTPModuleResponseRequest?
        if let userData = LocalStorage.value(forKey: key_user_info) as? Data
        {
            user_info = try? JSONDecoder().decode(OTPModuleResponseRequest.self, from: userData)
        }
        return user_info
    }
    
    public static func removeUserDetailsFromLocal() {
        
        LocalStorage.remove(key_user_id)
        LocalStorage.remove(key_user_info)
        ApplicationSessionManager.startManageSession(key_session_logout)
        KeychainHelper.shared.remove(.userToken)
        LocalStorage.remove(key_user_allow_age)
    }

    public static func setUserToken(_ token: String) {
        _ = KeychainHelper.shared.set(token, for: .userToken)
    }

    public static func getUserToken() -> String {
        if let token = KeychainHelper.shared.string(for: .userToken), !token.isEmpty {
            return token
        }

        return ""
    }
}
enum LocalStorage {
    static func set(_ value: Any?, forKey key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }

    static func remove(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    static func value(forKey key: String) -> Any? {
        UserDefaults.standard.object(forKey: key)
    }
}
