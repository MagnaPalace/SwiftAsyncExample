//
//  ApiManager.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/21.
//

import Foundation
//import _Concurrency

class ApiManager {
    
    /// 通常版
    func request(param: [String: Any]?, url: URL, completion: @escaping (_ success: Bool, _ result: Any?, _ error: NSError?) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        print("-----url-----\n\(url)")
        print("-----param-----\n\(String(describing: param))")
        
        guard let postBody = try? JSONSerialization.data(withJSONObject: param as Any, options: []) else { return }
        request.httpBody = postBody
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                
                print("-----result-----\n\(result)")
                completion(true, result, error as NSError?)
            } catch let error {
                print(error)
                completion(false, nil, error as NSError)
            }
        }
        task.resume()
    }
    
    /// Swift 5.5 Concurrency async/await
    func requestAsync(param: [String: Any]?, url: URL) async throws -> Any? {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            print("-----url-----\n\(url)")
            print("-----param-----\n\(String(describing: param))")
            let (data, urlResponse) = try await URLSession.shared.data(for: request, delegate: nil)
            
            guard let httpStatus = urlResponse as? HTTPURLResponse else {
                return nil
            }
            print("statusCode: \(httpStatus.statusCode)")
            guard httpStatus.statusCode == 200 else {
                return nil
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("-----result-----\n\(result)")
                return result
            } catch {
                print(error)
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
    
}
