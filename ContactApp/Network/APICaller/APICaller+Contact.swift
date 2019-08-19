//
//  APICaller+Contact.swift
//  Contacts
//
//  Created by Pawan Kumar  on 19/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation

extension APICaller {
    // Getting list of Contact from backend
    func callGetAllContactAPI(callBack: @escaping (_ success: Bool, _ message: String, _ list: [Contact]) -> ()) {
        self.helperJSON.callAPI(url: EndPoint.allContacts.url, params: [:], method: .GET, requestType: .Raw) { responseAny, error, _ in
            
            if let err = error {
                callBack(false, err.localizedDescription, [])
                return
            } else {
                guard let responseUnwrapped = responseAny as? [JsonDictionary] else {
                    callBack(false, PKNetworkingErrors.serverError.message, [])
                    return
                }
                
                var list: [Contact] = []
                list = Contact.getModels(json: responseUnwrapped)
                callBack(true, "", list)
            }
        }
    }
    
    // Getting Contact Detail
    
    func callGetContactDetailAPI(contactId: Int, callBack: @escaping (_ success: Bool, _ message: String, _ contact: Contact?) -> ()) {
        let endPoint = EndPoint.BASE_URL.url + "/contacts/\(contactId).json"
        self.helperJSON.callAPI(url: endPoint, params: [:], method: .GET, requestType: .Raw) { responseAny, error, _ in
            
            if let err = error {
                callBack(false, err.localizedDescription, nil)
                return
            } else {
                guard let responseUnwrapped = responseAny as? JsonDictionary else {
                    callBack(false, PKNetworkingErrors.serverError.message, nil)
                    return
                }
                
                printDebug(responseUnwrapped)
                
                callBack(true, "", Contact(json: responseUnwrapped))
            }
        }
    }
    
    func callAddContatAPI(params: JsonDictionary, callBack: @escaping (_ success: Bool, _ message: String, _ contact: Contact?) -> ()) {
        self.helperJSON.callAPI(url: EndPoint.BASE_URL.url + "/contacts.json", params: params, method: .POST) { responseAny, error, _ in
            
            if let err = error {
                callBack(false, err.localizedDescription, nil)
                return
            } else {
                guard let responseUnwrapped = responseAny as? JsonDictionary else {
                    callBack(false, PKNetworkingErrors.serverError.message, nil)
                    return
                }
                
                printDebug(responseUnwrapped)
                
                callBack(true, "", Contact(json: responseUnwrapped))
            }
        }
    }
    
    // Update Contact Detail API
    
    func callUpateContactDetailAPI(contactId: Int, params: JsonDictionary, callBack: @escaping (_ success: Bool, _ message: String, _ contact: Contact?) -> ()) {
        let endPoint = EndPoint.BASE_URL.url + "/contacts/\(contactId).json"
        self.helperJSON.callAPI(url: endPoint, params: params, method: .PUT, requestType: .Raw) { responseAny, error, _ in
            
            if let err = error {
                callBack(false, err.localizedDescription, nil)
                return
            } else {
                guard let responseUnwrapped = responseAny as? JsonDictionary else {
                    callBack(false, PKNetworkingErrors.serverError.message, nil)
                    return
                }
                
                printDebug(responseUnwrapped)
                
                callBack(true, "", Contact(json: responseUnwrapped))
            }
        }
    }
    
    //update the contact
    func deleteContactAPI(forId: Int,
                          callBack: @escaping(_ success: Bool, _ message: String)->()) {
        
        self.helperJSON.callAPI(url: "\(EndPoint.BASE_URL.rawValue)/contacts/\(forId).json", params: [:], method: .DELETE, requestType: .Raw) { (responseAny, error, headerResponse) in
            
            if responseAny == nil, error == nil {
                callBack(true, "Contact deleted successfully.")
            }
            else {
                callBack(false, "Contact already deleted.")
            }
        }
    }
}
