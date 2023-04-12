//
//  ApiService.swift
//  MealMonkey
//
//  Created by MacBook Pro on 31/03/23.
//

import Foundation
import Alamofire

class ApiService {
  static let shared: ApiService = ApiService()
  private init() { }

  let BASE_URL = "https://api.escuelajs.co/api/v1"

  func signUp(user: User, completion: @escaping (Error?) -> Void) {
    let url = "\(BASE_URL)/users/"
    AF.request(url, method: .post, parameters: user)
      .validate()
      .responseDecodable(of: User.self) { response in
        switch response.result {
        case .success:
          completion(nil)
        case.failure(let error):
          completion(error)
        }
      }
  }

  func login(email: String, password: String, completion: @escaping( Result<AccessToken, Error>) -> Void){

    let url = "\(BASE_URL)/auth/login"
    AF.request(url, method: .post, parameters: ["email": email, "password": password])
      .validate()
      .responseDecodable(of: AccessToken.self) { response in
        switch response.result {
        case .success(let accessToken):
          completion(.success(accessToken))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }

  func getProfile(accessToken: String, completion: @escaping (Result<User, Error>) -> Void) {
    let url = "\(BASE_URL)/auth/profile"
    AF.request(url, method: .get, headers: ["Authorization": " Bearer \(accessToken)"])
      .validate()
      .responseDecodable(of: User.self) { response in
        switch response.result {
        case .success(let user):
          completion(.success(user))
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }

  func loadPopularRestos(completion: @escaping ([Restaurant]) -> Void) {
    let url = "https://x8ki-letl-twmt.n7.xano.io/api:KJs76dnG/restaurant/popular"
    AF.request(url)
      .validate()
      .responseDecodable(of: [Restaurant].self) { response in
        switch response.result {
        case .success(let restos):
          completion(restos)
        case .failure:
          completion([])
        }
      }
  }
}
