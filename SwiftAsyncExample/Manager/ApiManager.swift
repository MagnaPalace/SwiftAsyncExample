//
//  ApiManager.swift
//  SwiftAsyncExample
//
//  Created by Takeshi Kayahashi on 2022/05/21.
//

import Foundation
//import _Concurrency

class ApiManager {
    
    // 通常版
    func request(param: [String: Any]?, url: URL, completion: @escaping (_ success: Bool, _ result: Any?, _ error: NSError?) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        print("-----url-----\n\(url)")
        print("-----param-----\n\(String(describing: param))")
        
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
    
}
