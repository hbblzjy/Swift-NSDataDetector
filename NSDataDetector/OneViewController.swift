//
//  OneViewController.swift
//  NSDataDetector
//
//  Created by JasonHao on 2017/7/12.
//  Copyright © 2017年 JasonHao. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white;
        
        //匹配字符串中所有的URL
        let str = "欢迎访问http://www.baidu.com，https://www.baidu.com\n以及ftp://www.baidu.com"
        print("swift.........测试字符串式：\n\(str)\n")
        
        print("swift.........匹配到的链接：")
        let urls = getUrls(str: str)
        for url in urls {
            print(url)
        }
        
        //验证URL格式是否正确
        print("swift..........验证URL格式是否正确：")
        let str1 = "欢迎访问http://www.baidu.com"
        print(str1)
        print(verifyUrl(str: str1))
        
        let str2 = "http://www.baidu.com"
        print(str2)
        print(verifyUrl(str: str2))
    }
    /**
     匹配字符串中所有的URL
     */
    private func getUrls(str:String) -> [String] {
        var urls = [String]()
        // 创建一个正则表达式对象
        do {
            let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            // 取出结果
            for checkingRes in res {
                urls.append((str as NSString).substring(with: checkingRes.range))
            }
        }
        catch {
            print(error)
        }
        return urls
    }
    
    /**
     验证URL格式是否正确
     */
    private func verifyUrl(str:String) -> Bool {
//        // 创建一个正则表达式对象
//        do {
//            let dataDetector = try NSDataDetector(types:
//                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
//            // 匹配字符串，返回结果集
//            let res = dataDetector .matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
//            // 判断结果(完全匹配)
//            if res.count == 1  && res[0].range.location == 0
//                && res[0].range.length == str.characters.count {
//                return true
//            }
//        }
//        catch {
//            print(error)
//        }
//        return false
        
        //注意：验证URL链接更简单的办法 我们还可以借助系统提供的 canOpenURL() 方法来检测一个链接的有效性
        //创建NSURL实例
        if let url = NSURL(string: str) {
            //检测应用是否能打开这个NSURL实例
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
