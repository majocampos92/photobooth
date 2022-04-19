//
//  GalleryNetworkService.swift
//  ChallengeCats
//
//  Created by Jo on 10/3/22.
//

import Moya
import Foundation

enum GalleryAPI {
    case tags
    case cats(params: CatParams)
}

extension GalleryAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else {
            fatalError("baseURL could not be configurated.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .tags:
            return Endpoints.getTags
        case .cats:
            return Endpoints.getCats
        }
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .cats(let params):
            return .requestParameters(parameters: [Keys.tags : params.tags, Keys.skip : params.skip, Keys.limit : params.limit], encoding: URLEncoding.default)
        case .tags:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
