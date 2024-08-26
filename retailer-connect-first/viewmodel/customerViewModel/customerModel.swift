//
//  customerModel.swift
//  retailer-connect-first
//
//  Created by Spark on 26/02/2024.
//

import Foundation
import Alamofire
enum NetworkError: Error {
    case unexpected

    case apiError(statusCode: Int)
    case noRecordFound(message: String)
}
class addcustomerviewModel{
    
    
    func addingCustomer(Customer:String!, phoneNumber:Int!, address:String,Balence:Int ,whenFinish: @escaping  (Result<AddingCustumer, AddingCustumerErrormodel>) -> Void) {
        
        let header: HTTPHeaders = [
            .authorization(bearerToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTAzMjBkNzllNzY2YzdmZTNkNjhjMDFlZTQwYjVjMTdmMjhlYzA2NmExNzlmN2Q1ZTM5NGY1YWNhYTI1Y2RjOGZjNzFjZDJhNDM3MWZkMmMiLCJpYXQiOjE3MDk4MTAxOTIuMzExMDQsIm5iZiI6MTcwOTgxMDE5Mi4zMTEwNDIsImV4cCI6MTcwOTg5NjU5Mi4zMDc3NjMsInN1YiI6IjMiLCJzY29wZXMiOltdfQ.YJU5T_bu4jDsF1-qciZPPZMNKbkk5D78H8B8ejzkdpAmCaX1ybn6-vTnZlutZS_EYEL6TFrbidl9D9OH2ra7OD8IFVV6OmJ43euUf6XQgazUD1qNo7Fy2SFEzUqzjeP8-gfHnWMxCmtEyp5LQnrZ7-Jfwk7aO1L2jmZZUGBtlMhGwEomR3_mDP2wCBZMdBy1RRaAh-n8hX_xpTa9bXs_60hMg78ZF796i8rXLdOfcWNTnHZ5m5nfAZRFI5bGfljck-PyP6q8DmvvjBRjOe7rI7FBX6K7OaSLphh8WiRUHZ-eTlpUR2-VvizqORcIfKWGQTk7lZtqrBd8AdnuAelb8JG-kqtkdg0oHJNFDZkxQRes-xT-jgbMni7KaP_f4qiiklLbATCVBbrSlTGBCHFki1NJUi5A3D5px4lSf-S-nJVnSMgY7h5umXtSr0RAC0OwvSgfRXLSZJnaM9v1z5rcbeK09QUSSV6AlnNjnigmPOJEl8IaJ1mDG3quSJQ9xW4XckL4XaGDYZCGwRdy09lT2fTpy5vKwvpgogHTN89FXATVCAIrULlUEPByTHJ0nOlSjYnXTDyPB-b1cF9jCm1tR8m_WpNFmGiIOhWAldhUl34iNKaOFNonod0VBsk5pSmHDyBXGeWpKkewxx3tENFcxlV6D3j7OthldUwCrodDXIU"),
        ]
        let parameters: [String: Any] = [
            "name" : Customer!,
            "phone" : phoneNumber!,
            "address" : address,
            "balence" : Balence,
            
        ]
        for ar in parameters
        {
            print(ar)
        }
        AF.request("https://api.retailer-connect.com/api/customers/add-customer", method: .post, parameters: parameters, headers: header)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let employeeModel = try decoder.decode(AddingCustumer.self, from: data)
                        whenFinish(.success(employeeModel))
                    } catch {
                 
                        do {
                           
                            let decoder = JSONDecoder()
                            
                            print("enter")
                            let employeeModelError = try decoder.decode(AddingCustumerErrormodel.self, from: data)
                            print(employeeModelError)
                            
                            
                           whenFinish(.failure(employeeModelError))
                        } catch {
                            print("Error decoding error JSON: \(error)")
                            //    whenFinish(.failure(AddingCustumerErrormodel(success: false, message: "Unknown error", data: nil)))
                        }
                    }
                case .failure(let error):
                    // Handle network request failure
                    print("Network request failed with error: \(error)")
                    if let statusCode = response.response?.statusCode {
                        //  whenFinish(.failure(AddingCustumerErrormodel(success: false, message: "API error", data: nil)))
                    } else {
                        //  whenFinish(.failure(AddingCustumerErrormodel(success: false, message: "Unknown error", data: nil)))
                    }
                }
                
                
            }
    }
                func FetchingCusomter(whenFinish: @escaping (Result<fetchCustumerModel, NetworkError>) -> Void) {
                    
                    let header: HTTPHeaders = [
                        .authorization(bearerToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTAzMjBkNzllNzY2YzdmZTNkNjhjMDFlZTQwYjVjMTdmMjhlYzA2NmExNzlmN2Q1ZTM5NGY1YWNhYTI1Y2RjOGZjNzFjZDJhNDM3MWZkMmMiLCJpYXQiOjE3MDk4MTAxOTIuMzExMDQsIm5iZiI6MTcwOTgxMDE5Mi4zMTEwNDIsImV4cCI6MTcwOTg5NjU5Mi4zMDc3NjMsInN1YiI6IjMiLCJzY29wZXMiOltdfQ.YJU5T_bu4jDsF1-qciZPPZMNKbkk5D78H8B8ejzkdpAmCaX1ybn6-vTnZlutZS_EYEL6TFrbidl9D9OH2ra7OD8IFVV6OmJ43euUf6XQgazUD1qNo7Fy2SFEzUqzjeP8-gfHnWMxCmtEyp5LQnrZ7-Jfwk7aO1L2jmZZUGBtlMhGwEomR3_mDP2wCBZMdBy1RRaAh-n8hX_xpTa9bXs_60hMg78ZF796i8rXLdOfcWNTnHZ5m5nfAZRFI5bGfljck-PyP6q8DmvvjBRjOe7rI7FBX6K7OaSLphh8WiRUHZ-eTlpUR2-VvizqORcIfKWGQTk7lZtqrBd8AdnuAelb8JG-kqtkdg0oHJNFDZkxQRes-xT-jgbMni7KaP_f4qiiklLbATCVBbrSlTGBCHFki1NJUi5A3D5px4lSf-S-nJVnSMgY7h5umXtSr0RAC0OwvSgfRXLSZJnaM9v1z5rcbeK09QUSSV6AlnNjnigmPOJEl8IaJ1mDG3quSJQ9xW4XckL4XaGDYZCGwRdy09lT2fTpy5vKwvpgogHTN89FXATVCAIrULlUEPByTHJ0nOlSjYnXTDyPB-b1cF9jCm1tR8m_WpNFmGiIOhWAldhUl34iNKaOFNonod0VBsk5pSmHDyBXGeWpKkewxx3tENFcxlV6D3j7OthldUwCrodDXIU"),
                    ]
                    
                    AF.request("https://api.retailer-connect.com/api/customers/fetch-customer", method: .get,  headers: header)
                        .responseData { [self] response in
                            switch response.result {
                            case .success(let data):
                                do {
                                    
                                    let decoder = JSONDecoder()
                                    let employeeModel = try decoder.decode(fetchCustumerModel.self, from: data)
                                    
                                    whenFinish(.success(employeeModel))
                                } catch {
                                    whenFinish(.failure(NetworkError.noRecordFound(message: "Unknown error")))
                                    // Handle decoding error
                                    print("Error decoding JSON: \(error)")
                                }
                            case .failure(let error):
                                // Handle network request failure
                                print("Network request failed with error: \(error)")
                                if let statusCode = response.response?.statusCode {
                                    whenFinish(.failure(NetworkError.apiError(statusCode: statusCode)))
                                } else {
                                    whenFinish(.failure(.unexpected))
                                }
                            }
                        }
                }
                
                
                func updateCustumer(
                    id:Int!,
                    phone:String!,
                    address:String!,
                    name:String! , whenFinish: @escaping (Result<updateCustomer, NetworkError>) -> Void) {
                        
                        let header: HTTPHeaders = [
                            .authorization(bearerToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTAzMjBkNzllNzY2YzdmZTNkNjhjMDFlZTQwYjVjMTdmMjhlYzA2NmExNzlmN2Q1ZTM5NGY1YWNhYTI1Y2RjOGZjNzFjZDJhNDM3MWZkMmMiLCJpYXQiOjE3MDk4MTAxOTIuMzExMDQsIm5iZiI6MTcwOTgxMDE5Mi4zMTEwNDIsImV4cCI6MTcwOTg5NjU5Mi4zMDc3NjMsInN1YiI6IjMiLCJzY29wZXMiOltdfQ.YJU5T_bu4jDsF1-qciZPPZMNKbkk5D78H8B8ejzkdpAmCaX1ybn6-vTnZlutZS_EYEL6TFrbidl9D9OH2ra7OD8IFVV6OmJ43euUf6XQgazUD1qNo7Fy2SFEzUqzjeP8-gfHnWMxCmtEyp5LQnrZ7-Jfwk7aO1L2jmZZUGBtlMhGwEomR3_mDP2wCBZMdBy1RRaAh-n8hX_xpTa9bXs_60hMg78ZF796i8rXLdOfcWNTnHZ5m5nfAZRFI5bGfljck-PyP6q8DmvvjBRjOe7rI7FBX6K7OaSLphh8WiRUHZ-eTlpUR2-VvizqORcIfKWGQTk7lZtqrBd8AdnuAelb8JG-kqtkdg0oHJNFDZkxQRes-xT-jgbMni7KaP_f4qiiklLbATCVBbrSlTGBCHFki1NJUi5A3D5px4lSf-S-nJVnSMgY7h5umXtSr0RAC0OwvSgfRXLSZJnaM9v1z5rcbeK09QUSSV6AlnNjnigmPOJEl8IaJ1mDG3quSJQ9xW4XckL4XaGDYZCGwRdy09lT2fTpy5vKwvpgogHTN89FXATVCAIrULlUEPByTHJ0nOlSjYnXTDyPB-b1cF9jCm1tR8m_WpNFmGiIOhWAldhUl34iNKaOFNonod0VBsk5pSmHDyBXGeWpKkewxx3tENFcxlV6D3j7OthldUwCrodDXIU"),
                        ]
                        var parameters: [String: Any] = [
                            "name":name!,
                            "id":id!,
                            "address":address!,
                            "phone":Int(phone!)!,
                        ]
                        
                        for ar  in parameters{
                            print("update",ar)
                        }
                    
                        AF.request("https://api.retailer-connect.com/api/customers/edit-customer?id=\(id!)&name=\(name!)&address=\(address!)&phone=\(phone!)", method: .put,   headers: header)
                            .responseData {  response in
                                switch response.result {
                                case .success(let data):
                                    do {
                                        let decoder = JSONDecoder()
                                        let employeeModel = try decoder.decode(updateCustomer.self, from: data)
                                        
                                        whenFinish(.success(employeeModel))
                                    } catch {
                                        whenFinish(.failure(NetworkError.noRecordFound(message: "Unknown error")))
                                        // Handle decoding error
                                        print("Error decoding JSON: \(error)")
                                    }
                                case .failure(let error):
                                    // Handle network request failure
                                    print("Network request failed with error: \(error)")
                                    if let statusCode = response.response?.statusCode {
                                        whenFinish(.failure(NetworkError.apiError(statusCode: statusCode)))
                                    } else {
                                        whenFinish(.failure(.unexpected))
                                    }
                                }
                            }
                    }

    func deleteCustomer(
        id:Int!,
 
        whenFinish: @escaping (Result<updateCustomer, NetworkError>) -> Void) {
            
            let header: HTTPHeaders = [
                .authorization(bearerToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTAzMjBkNzllNzY2YzdmZTNkNjhjMDFlZTQwYjVjMTdmMjhlYzA2NmExNzlmN2Q1ZTM5NGY1YWNhYTI1Y2RjOGZjNzFjZDJhNDM3MWZkMmMiLCJpYXQiOjE3MDk4MTAxOTIuMzExMDQsIm5iZiI6MTcwOTgxMDE5Mi4zMTEwNDIsImV4cCI6MTcwOTg5NjU5Mi4zMDc3NjMsInN1YiI6IjMiLCJzY29wZXMiOltdfQ.YJU5T_bu4jDsF1-qciZPPZMNKbkk5D78H8B8ejzkdpAmCaX1ybn6-vTnZlutZS_EYEL6TFrbidl9D9OH2ra7OD8IFVV6OmJ43euUf6XQgazUD1qNo7Fy2SFEzUqzjeP8-gfHnWMxCmtEyp5LQnrZ7-Jfwk7aO1L2jmZZUGBtlMhGwEomR3_mDP2wCBZMdBy1RRaAh-n8hX_xpTa9bXs_60hMg78ZF796i8rXLdOfcWNTnHZ5m5nfAZRFI5bGfljck-PyP6q8DmvvjBRjOe7rI7FBX6K7OaSLphh8WiRUHZ-eTlpUR2-VvizqORcIfKWGQTk7lZtqrBd8AdnuAelb8JG-kqtkdg0oHJNFDZkxQRes-xT-jgbMni7KaP_f4qiiklLbATCVBbrSlTGBCHFki1NJUi5A3D5px4lSf-S-nJVnSMgY7h5umXtSr0RAC0OwvSgfRXLSZJnaM9v1z5rcbeK09QUSSV6AlnNjnigmPOJEl8IaJ1mDG3quSJQ9xW4XckL4XaGDYZCGwRdy09lT2fTpy5vKwvpgogHTN89FXATVCAIrULlUEPByTHJ0nOlSjYnXTDyPB-b1cF9jCm1tR8m_WpNFmGiIOhWAldhUl34iNKaOFNonod0VBsk5pSmHDyBXGeWpKkewxx3tENFcxlV6D3j7OthldUwCrodDXIU"),
            ]
            var parameters: [String: Any] = [
               
                "id": id!,
                "status":"deleted"
            ]
            for ar  in parameters{
                print(ar)
            }
            AF.request("https://api.retailer-connect.com/api/customers/change-status?status=deleted&id=\(id!)", method: .put,   headers: header)
                .responseData {  response in
                    switch response.result {
                    case .success(let data):
                        
                        do {
                            
                            let decoder = JSONDecoder()
                            let employeeModel = try decoder.decode(updateCustomer.self, from: data)
                            
                            whenFinish(.success(employeeModel))
                        } catch {
                            whenFinish(.failure(NetworkError.noRecordFound(message: "Unknown error")))
                            // Handle decoding error
                            print("Error decoding JSON: \(error)")
                        }
                    case .failure(let error):
                        // Handle network request failure
                        print("Network request failed with error: \(error)")
                        if let statusCode = response.response?.statusCode {
                            whenFinish(.failure(NetworkError.apiError(statusCode: statusCode)))
                        } else {
                            whenFinish(.failure(.unexpected))
                        }
                    }
                }
        }
    
            }
    

