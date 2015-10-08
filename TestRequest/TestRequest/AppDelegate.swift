//
//  AppDelegate.swift
//  TestRequest
//
//  Created by Jabez on 10/4/15.
//  Copyright © 2015 John. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    post5()
    
    return true
  }
  
  /**
    */
  func post6() {
//    upload(.POST, "http://192.168.199.249/~jabez/test/exercise/01/fileUpload2.php", headers: ["Content-Type": contentType], multipartFormData: { (form) -> Void in
//      
//      }, encodingMemoryThreshold: Int.max) { (result) -> Void in
//        
//    }
  }
  
  /*
  post using alamofire
  good
*/
  func post5() {
    
    let first_name = "ha2h"
    let image_name = "ha2ha2.png"
    let imageData = uploadImageData()
    
    
    let boundary = "14737809831466499882746641449"
    let contentType = "multipart/form-data; boundary=\(boundary)"
    
    let body = NSMutableData()
    body.appendData(dataWith("\r\n--\(boundary)\r\n"))
    body.appendData(dataWith("Content-Disposition: form-data; name=\"nickname\"\r\n\r\n"))
    body.appendData(dataWith("\(first_name)"))
    
    body.appendData(dataWith("\r\n--\(boundary)\r\n"))
    body.appendData(dataWith("Content-Disposition: form-data; name=\"world2\"\r\n\r\n"))
    body.appendData(dataWith("good2"))
    
    
    body.appendData(dataWith("\r\n--\(boundary)\r\n"))
    
    body.appendData(dataWith("Content-Disposition: form-data; name=\"image\"; filename=\"\(image_name)\"\r\n"))
    body.appendData(dataWith("Content-Type: application/octet-stream\r\n\r\n"))
    body.appendData(imageData)
    body.appendData(dataWith("\r\n--\(boundary)--\r\n"))
    
    upload(.POST, "http://192.168.199.249/~jabez/test/exercise/01/fileUpload2.php", headers: ["Content-Type": contentType], stream: NSInputStream(data: body)).response { (request, response, data, error) -> Void in
      if error != nil {
        print("error: \(error)")
      } else {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("str: \(str)")
      }
    }
  }
  
  /**
  good
  
  see http://stackoverflow.com/questions/936855/file-upload-to-http-server-in-iphone-programming
  
  see https://github.com/jabez1314/Json-Sample/blob/master/Json%20Sample/ViewController.m
*/
  func post4() {
    let url: NSURL = NSURL(string: "http://192.168.199.249/~jabez/test/exercise/01/fileUpload2.php")!
    let first_name = "hah"
    let image_name = "ha2ha.png"
    let imageData = uploadImageData()
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    
    let boundary = "14737809831466499882746641449"
    let contentType = "multipart/form-data; boundary=\(boundary)"
    request.setValue(contentType, forHTTPHeaderField: "Content-Type")
    
    let body = NSMutableData()
    body.appendData(dataWith("\r\n--\(boundary)\r\n"))
    body.appendData(dataWith("Content-Disposition: form-data; name=\"nickname\"\r\n\r\n"))
    body.appendData(dataWith("\(first_name)"))
    
    body.appendData(dataWith("\r\n--\(boundary)\r\n"))
    body.appendData(dataWith("Content-Disposition: form-data; name=\"world\"\r\n\r\n"))
    body.appendData(dataWith("good"))
    
    
    body.appendData(dataWith("\r\n--\(boundary)\r\n"))
    
    body.appendData(dataWith("Content-Disposition: form-data; name=\"image\"; filename=\"\(image_name)\"\r\n"))
    body.appendData(dataWith("Content-Type: application/octet-stream\r\n\r\n"))
    body.appendData(imageData)
    body.appendData(dataWith("\r\n--\(boundary)--\r\n"))
    
    let useStream = true
    
    if useStream {
      request.HTTPBodyStream = NSInputStream(data: body)
    } else {
      request.HTTPBody = body
    }
    
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (Response, data, error) -> Void in
      if error != nil {
        print("error: \(error)")
      } else {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("str: \(str)")
      }

    }
    
  }
  
  
  
  func uploadFile(url: NSURL, data:NSData) {
    let topStr = topString("image/png", file: "hello.png")
    let bottomStr = bottomString()
    
    let data = NSMutableData()
//    data.appendData(dataWith("nickname=hello&"))
    data.appendData(dataWith(topStr))
    data.appendData(data)
    data.appendData(dataWith(bottomStr))
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPBody = data
    request.HTTPMethod = "POST"
    
    request.setValue("\(data.length)", forHTTPHeaderField: "Content-Length")

    let contentType = "multipart/form-data; boundary=\(randomIDStr)"
    request.setValue(contentType, forHTTPHeaderField: "Content-Type")
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
      if error != nil {
        print("error: \(error)")
      } else {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("str: \(str)")
      }
    }
  }
  
  
  
// MARK: - Network
  
  
  func post3() { //faile
//     let url = NSURL(string: "http://jabez.local/~jabez/test/exercise/01/fileUpload2.php") // http://104.236.224.67/test/php/fileUpload.php
     let url = NSURL(string: "http://192.168.199.249/~jabez/test/exercise/01/fileUpload2.php") // http://104.236.224.67/test/php/fileUpload.php
    uploadFile(url!, data: uploadImageData())
  }
  
  
  func post2() { // fail
    let url = NSURL(string: "http://192.168.199.249/~jabez/test/exercise/01/fileUpload2.php") // http://104.236.224.67/test/php/fileUpload.php
    
    let param = ["nickname": "Job", "image": uploadImageData()]
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "POST"
    request.HTTPBody = generateFormData(param)
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
      if error != nil {
        print("error: \(error)")
      } else {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("str: \(str)")
      }
    }
  }
  
  func post() { // ok
    let url = NSURL(string: "http://104.236.224.67/test/php/upload.php")
    let param = "a=wwww&b=ccc"
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "POST"
    request.HTTPBody = param.dataUsingEncoding(NSUTF8StringEncoding)
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
      if error != nil {
        print("error: \(error)")
      } else {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("str: \(str)")
      }
    }
    
    
  }
  
  
  func uploadFile() { // fale
    
    let image = UIImage(named: "bg")
    let imageData = UIImageJPEGRepresentation(image!, 0.8)
    
    let url: NSURL = NSURL(string: "http://211.162.119.123:8080/TapTip/avatar.do?method=updateAvatar")!
    let dict = ["email": "12345@126.com", "avatar": imageData!]
    
    
    var data:NSData? = nil
    
    do {
      data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
    } catch {
      print("json serialization failed")
      return;
    }
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.HTTPBody = data!
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
      print("response: \(response)")
      if data != nil {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("str: \(str)")
      }
      
    }

  }
  
  func request2() { // ok
    request(.POST, "http://211.162.119.123:8080/TapTip/getUserByEmail", parameters: ["email": "1235@163.com", "hello": "222"], encoding: .JSON, headers: ["Content-Type": "application/json"]).response { (request, response, data, type) -> Void in
     
      
      var dict:NSDictionary? = nil
      var status = false
      
      //      defer {
      //        completionHandler(self.request, self.response, self.delegate.error, statusOK: status, jsonData: dict)
      //      }
//      if error != nil {
//       
//        return
//      }
      
      if !(data != nil && data!.isKindOfClass(NSData)) {
        print("data is error!", terminator: "");
       
        return;
      }
      
      
      dict = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)) as? NSDictionary
      
      if dict == nil {
        print("data is errr \(NSString(data: data!, encoding: NSUTF8StringEncoding))", terminator: "");
        status = false
        
        return;
      }
      
      print("response: \(dict)", terminator: "")
      
      status = true
      
      var success:Int = 1
      var errorMessage: String? = nil
      
      
      if dict!.objectForKey("success") != nil { // 兼容旧接口
        if dict?.objectForKey("success") != nil {
          success = dict!.objectForKey("success") as! Int
          status = success == 1
          
          if let message = dict!.objectForKey("errorMessage") as? String {
            if !(message as String).isEmpty {
              errorMessage = message as String
              status = false
            }
            
          }
        }
      } else {
        if dict!.objectForKey("code")?.intValue == 1 {
          status = true
        } else {
          status = false
        }
        
        if let message = dict!.objectForKey("msg") as? String {
          if !message.isEmpty && !status {
            errorMessage = message
          }
        }
        
      }

      
      
      
    }
  }
  
  func request1() { // ok
    let url: NSURL = NSURL(string: "http://211.162.119.123:8080/TapTip/getUserByEmail")!
    let dict = ["email": "1235@163.com"]
    
    
    var data:NSData? = nil
    
    do {
      data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
    } catch {
      
    }
    
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.HTTPBody = data!
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
      print("response: \(response)")
      if data != nil {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("str: \(str)")
      }
      
    }
    
  }

  
  // MARK: - Utils
  func uploadImageData() -> NSData {
    
    let image = UIImage(named: "bg")
    let imageData = UIImageJPEGRepresentation(image!, 0.8)
    return imageData!
  }
  
  func dataWith(string: String) -> NSData {
    return string.dataUsingEncoding(NSUTF8StringEncoding)!
  }
  
  func imageContent(name: String, filename: String = "image1.png", contentType:String = "image/png") -> String {
    return "Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\nContent-Type: \(contentType)\r\n\r\n"
  }
  
  func stringContent(name: String) -> String {
    return "Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n"
  }
  
  let MULTIPART = "multipart/form-data; boundary=------------0x0x0x0x0x0x0x0x"
  
  func generateFormData(dict: NSDictionary) -> NSData {
    let boundary = "------------0x0x0x0x0x0x0x0x"
    let keys = dict.allKeys
    let result = NSMutableData()
    
    for var i = 0; i < keys.count; i++ {
      
      let value = dict[keys[i] as! String]
      result.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
      
      if value!.isKindOfClass(NSData) {
        let formString = imageContent(keys[i] as! String)
        result.appendData(dataWith(formString))
        result.appendData(value as! NSData)
      } else {
        let formString = stringContent(keys[i] as! String)
        result.appendData(dataWith(formString))
        result.appendData(dataWith("\(value!)"))
      }
      
      result.appendData(dataWith("\r\n"))
    }
    
    result.appendData(dataWith("--\(boundary)--\r\n"))
    
    return result
  }
  
  ///////////
  let boundaryString = "--"
  let randomIDStr = "hell2o"
  let uploadID = "image"
  
  func topString(mimeType: String, file:String) -> String {
    let str1 = "\(boundaryString)\(randomIDStr)\n"
    let str2 = "Content-Disposition: form-data; name=\"\(uploadID)\"; filename=\"\(file)\"\n"
    let str3 = "Content-Type: \(mimeType)\n\n"
    return (str1 + str2 + str3)
  }
  
  func bottomString() -> String {
    let str1 = "\(boundaryString)\(randomIDStr)"
    let str2 = "Content-Disposition: form-data; name=\"submit\"\n\n"
    let str3 = "Submit\n"
    
    let str31 = "" // "Content-Disposition: form-data; name=\"nickname\"\n\n"
    let str32 = "" // "Submit\n"
    
    let str4 = "\(boundaryString)\(randomIDStr)--\n"
    return (str1 + str2 + str3 + str31 + str32 + str4)
    
//    return "";
  }
  


  

}

