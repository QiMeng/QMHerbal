//
//  ViewController.swift
//  QMHerbal
//
//  Created by QiMENG on 15/6/26.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var mainSearch: UISearchBar!
    
    @IBOutlet weak var mainCollection: UICollectionView!
    
    var data:Array<Model> = []
    
    var searchData:Array<Model> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        data = DBHelp.readPage(0) as! Array<Model>

        mainSearch.placeholder = "搜索(10026个)"
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        mainSearch.setShowsCancelButton(true, animated: true)
        return true
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.text = ""
        mainCollection.reloadData()
        
        mainSearch.setShowsCancelButton(false, animated: true)
        mainSearch.resignFirstResponder()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchData = DBHelp.search(searchBar.text)  as! Array<Model>
        
        mainCollection.reloadData()
        
        mainSearch.setShowsCancelButton(false, animated: true)
        mainSearch.resignFirstResponder()
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (mainSearch.text.isEmpty) {
//            println("allcount = \(data.count)")
            return data.count
        }
        return searchData.count
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell =  self.mainCollection.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell


        var titleLabel:UILabel? = cell.contentView.viewWithTag(100) as? UILabel
        if titleLabel == nil {
            //非复用，创建并添加到contentView里
//            println("label == nil\(indexPath.item)")
            titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            titleLabel!.tag = 100
            cell.contentView.addSubview(titleLabel!)
        }
        
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 3
        
        if (mainSearch.text.isEmpty) {
            let m = data[indexPath.row] as Model
            titleLabel!.text = m.title
        }else {
            let m = searchData[indexPath.row] as Model
            titleLabel!.text = m.title
        }
        
        
        if(data.count != 10026  && indexPath.row == data.count - 5)
        {
            let page = data.count/500 ;
            self.data += DBHelp.readPage(Int32(page)) as! Array<Model>
            
            dispatch_async(dispatch_get_main_queue(), {
                self.mainCollection.reloadData()
            })

        }

        
        return cell
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var m:Model!
        
        if (mainSearch.text.isEmpty) {
            m = data[indexPath.row] as Model

        }else {
            m = searchData[indexPath.row] as Model

        }
        
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let attributes = NSDictionary(object: UIFont.systemFontOfSize(20), forKey: NSFontAttributeName)
        
        let stringRect = m.title!.boundingRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max), options: option, attributes: attributes as [NSObject : AnyObject], context: nil)
        
        return stringRect.size
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var m:Model!
        
        if (mainSearch.text.isEmpty) {
            m = data[indexPath.row] as Model
            
        }else {
            m = searchData[indexPath.row] as Model
            
        }
        
        self.performSegueWithIdentifier("DetailsViewController", sender: m)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "DetailsViewController" {
            
            var ctrl = segue.destinationViewController as! DetailsViewController
            ctrl.infoModel = sender as? Model
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

