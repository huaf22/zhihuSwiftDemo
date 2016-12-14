//
//  HTTPManager.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 19/12/2016.
//  Copyright © 2016 helios. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import ObjectMapper
import AlamofireObjectMapper

class HTTPManager {
    public static func request<T : Mappable>( _ url: URLConvertible,
                                             method: HTTPMethod = .get,
                                         parameters: Parameters? = nil,
                                           encoding: ParameterEncoding = URLEncoding.default,
                                            headers: HTTPHeaders? = nil)
                                            -> Observable<T>
    {
       return Observable.create { observer -> Disposable in
        let dataRequest = SessionManager.default.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
        dataRequest.responseObject { (response: DataResponse<T>) in
            switch response.result {
                case .success:
                     if let data = response.result.value {
                        observer.onNext(data)
                }
                case .failure(let error):
                    observer.onError(error)
            }
        }
        
        
        return Disposables.create {
            dataRequest.cancel()
        }
            
        }
    }
    
}

