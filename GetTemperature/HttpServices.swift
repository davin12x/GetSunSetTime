//
//  HttpServices.swift
//  GetTemperature
//
//  Created by Lalit on 2016-03-22.
//  Copyright © 2016 Bagga. All rights reserved.
//

import Foundation

class HttpServices{
    
    
    func getTemp(tempAq:(temp:String,success:Bool)->Void) {
        
       let URL = NSURL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(URL!) { (data, response, error) in
            if error == nil && data != nil{
                do {
                     let weatherDirectory = try NSJSONSerialization.JSONObjectWithData(data!, options:.MutableContainers) as![String:AnyObject]
                    if let query = weatherDirectory["query"] as? [String:AnyObject] {
                        if let results = query["results"] as? [String:AnyObject]{
                            if let channel = results["channel"] as? [String:AnyObject]{
                                if let astronomy = channel["astronomy"] as? [String:AnyObject]{
                                    if let sunset = astronomy["sunset"]{
                                        tempAq(temp: sunset as! String, success: true)
                                    }
                                }
                            }
                        }
                    }
                }catch{
                    tempAq(temp: "Error", success:false)
                }
               
            }
        }.resume()
        
        
    }

}
