//
//  GalleryNetworkService.swift
//  ChallengeCats
//
//  Created by Jo on 10/3/22.
//

import Moya
import Foundation

enum GalleryAPI {
    case getTags
    case getAll(params: CatParams)
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
        case .getTags:
            return "/api/tags"
        case .getAll:
            return "/api/cats"
        }
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getAll(let params):
            return .requestParameters(parameters: ["tags" : params.tags, "skip" : params.skip, "limit" : params.limit], encoding: URLEncoding.default)
        case .getTags:
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
