//
//  APIClient.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

protocol APIClientType {
    func request<T: Codable>(request: URLRequestConvertable) -> Single<T>
}

class APIClient: APIClientType {
    static let shared = APIClient()
    func request<T: Decodable>(request: URLRequestConvertable) -> Single<T> {
        return URLSession.shared.rx.data(request: request.urlRequest)
            .map { try? JSONDecoder().decode(T.self, from: $0) }
            .catchOnNil { Observable.error(NSError(domain: "",
                                                   code: 99,
                                                   userInfo: [NSLocalizedDescriptionKey: "Couldn't parse model!"])) }
            .asSingle()
    }
}

// Only for image data request
class ImageAPIClient {
    static let shared = ImageAPIClient()
    private let urlSeesion: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        self.urlSeesion = URLSession(configuration: configuration)
    }
    
    func requestImageData(fromUrl url: URL) -> Single<Data> {
        return urlSeesion.rx.data(request: URLRequest(url: url)).asSingle()
    }
}
