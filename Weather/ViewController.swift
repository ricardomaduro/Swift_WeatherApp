//
//  ViewController.swift
//  Weather
//
//  Created by Ricardo Maduro on 12/10/16.
//  Copyright © 2016 Ricardo Maduro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBAction func buttonGetWeather(sender: AnyObject) {
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + city.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if url != nil {
            let task = NSURLSession.sharedSession().dataTaskWithURL(
                url!, completionHandler: {
                    (data, response, error) -> Void in
                    
                    var urlError = false
                    
                    var weather = ""
                    
                    if error == nil {
                        
                        var urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                        
                        var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                        
                        if urlContentArray.count > 0 {
                            
                            var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                            
                            weather = weatherArray[0] as! String
                            
                            weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                        } else {
                            
                            urlError = true
                            
                        }
                        
                        
                        
                    } else {
                        
                        urlError = true
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        if urlError == true {
                            
                            self.result.text = "Error!"
                            
                        } else {
                            
                            self.result.text = weather
                            
                        }
                    }
                }
            )
            task.resume()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

