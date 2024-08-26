//
//  settings.swift
//  retailer-connect-first
//
//  Created by Spark M1 on 21/05/2024.
//

import Foundation
class settingsviewmodel{
    func addmenu(  completion: @escaping (Result< Viewproducts, Global.APIError>) -> Void) {
        let url = "https://api.retailer-connect.com/api/admin/add-menu?name&description"
        Global.shared.performRequest(url: url,  method: .post, responseType: Viewproducts.self, completion: completion)
        
    }
    func fetchmenu(  completion: @escaping (Result< Viewproducts, Global.APIError>) -> Void) {
        let url = "https://api.retailer-connect.com/api/admin/fetch-menu"
        Global.shared.performRequest(url: url,  method: .get, responseType: Viewproducts.self, completion: completion)
        
    }
    func fetchchangeStatus(  completion: @escaping (Result< SuccessUser, Global.APIError>) -> Void) {
        let url = "https://api.retailer-connect.com/api/admin/fetch-menu"
        Global.shared.performRequest(url: url,  method: .put, responseType: SuccessUser.self, completion: completion)
        
    }
    func editmenu(  completion: @escaping (Result< SuccessUser, Global.APIError>) -> Void) {
        let url = "https://api.retailer-connect.com/api/admin/fetch-menu"
        Global.shared.performRequest(url: url,  method: .put, responseType: SuccessUser.self, completion: completion)
        
    }
    
    func exportmenu(  completion: @escaping (Result< SuccessUser, Global.APIError>) -> Void) {
        let url = "https://api.retailer-connect.com/api/admin/fetch-menu"
        Global.shared.performRequest(url: url,  method: .put, responseType: SuccessUser.self, completion: completion)
        
    }
    
    
}
