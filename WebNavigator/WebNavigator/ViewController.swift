//
//  ViewController.swift
//  WebNavigator
//
//  Created by formation on 14/10/2014.
//  Copyright (c) 2014 aiconoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        webView.loadHTMLString("<h1>Welcome</h1><a href='http://www.aiconoa.com'>Aiconoa</a>", baseURL: NSURL(string: ""))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(sender: AnyObject) {
    }

    @IBAction func forwardButton(sender: AnyObject) {
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let url = NSURL(string: textField.text) { //checks if url is compliant with NSURL
            webView.loadRequest(NSURLRequest(URL: url))
        }
        
        textField.resignFirstResponder()
        return true;
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        searchField.enabled = false
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        searchField.enabled = true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        println(error)
        webView.loadHTMLString("<h1>404</h1>", baseURL: NSURL(string: ""))
        searchField.enabled = true
    }
    
    @IBAction func share(sender: UIBarButtonItem) {
        
        
        let msg = "voici l'url"
        let url = webView.request!.URL
        
        let activityViewController = UIActivityViewController(activityItems: [msg, url], applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true) {
            
        }
        
        
   
    }
}

