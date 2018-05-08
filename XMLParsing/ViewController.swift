//
//  ViewController.swift
//  XMLParsing
//
//  Created by Theegala on 3/10/18.
//  Copyright © 2018 Theegala. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XMLParserDelegate,UITableViewDelegate,UITableViewDataSource
{

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return bollywoodArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text=tollywoodArr[indexPath.row]
        cell.detailTextLabel?.text = bollywoodArr[indexPath.row]
            return cell
       
        
    }
    
    @IBOutlet weak var tableview: UITableView!
    var parser = XMLParser()
    var xmlObject:XMLParser?
    var wood:String?
    var tollywoodArr=[String]()
    var bollywoodArr=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate=self
        self.tableview.dataSource=self
        // Do any additional setup after loading the view, typically from a nib.
        parser = XMLParser(contentsOf:(NSURL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss")! as URL))!
        parser.delegate = self
        parser.parse()
        
        tableview!.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "title" || elementName == "link"
        {
            self.wood=elementName
        }
        
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        
        let trimm = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimm.count>0
        {
            if wood == "title"
            {
                
                bollywoodArr.append(trimm)
            }
            if wood == "link"
            {
                tollywoodArr.append(trimm)
            }
            wood = ""
        }
        
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(bollywoodArr,tollywoodArr)
        self.tableview.reloadData()
    }
    
    }




