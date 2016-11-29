//
//  LWNetWorkingTool.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/14.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
class LWNetWorkingTool<T:HandyJSON >: NSObject {
    
    /**
     获取服务器数据，并转化为模型（对AlamofireObjectMapper进一步封装）
     
     - parameter url:          url地址
     - parameter params:       请求参数
     - parameter keyPath:      需要转模型的数据字段
     - parameter successBlock: 成功回调
     - parameter errorBlock:   失败回调
     */
  class  func getDataFromeServiceRequest(url: String, params:[String: String]? = nil, successBlock: @escaping (_ result: T?) -> Void, errorBlock: @escaping (_ error: NSError) -> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseString  {
//        Alamofire.request(url).responseString {
            response in
            if let err = response.result.error {
                errorBlock(err as NSError)
            } else {
                let jsonString = response.result.value! as String
                let jsonModel = JSONDeserializer<T>.deserializeFrom(json: jsonString)
                successBlock(jsonModel)
            }
        }
    }
//    let url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/d8bb95982be8a11a2308e779bb9a9707ebe42ede/sample_json"
//    
//    LWNetWorkingTool<dayModel>.getDataFromeServiceRequest(url: url, successBlock: {  jsonModel in
//    let first = jsonModel?.three_day_forecast?.first;
//    let conditions = first?.conditions
//    print("first: \(conditions)")
//    
//    }) { (error) in
//    
//    }
    class func getDictinoary(model : HandyJSON) -> Dictionary<String, Any>?{
        guard let dict = JSONSerializer.serialize(model: model).toSimpleDictionary() else {
            return  Dictionary()
        }
        return dict
    }
    class func getModel(dict : Dictionary<String, Any>) -> T {
        guard let model = JSONDeserializer<T>.deserializeFrom(dict: dict as NSDictionary?) else {
            return T()
        }
        return model
    }
}
