//
//  ViewController.swift
//  FeedNote
//
//  Created by Dona on 2018. 1. 25..
//  Copyright © 2018년 Dona. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    @IBOutlet weak var itemNum: UIBarButtonItem!
    @IBOutlet weak var editBarItem: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UI
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "길냥 수첩"
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.toolbar.barTintColor = UIColor.white
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // UI
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "길냥 수첩"
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.toolbar.barTintColor = UIColor.white
        editBarItem.title = "편집"
        
        // 테이블뷰의 제약 조건에 따라 셀높이 계산
        tableView.rowHeight = 110
        
        // toolbar item
        itemNum.title = "0 item"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItem.count
    }
    
    @available(iOS 2.0, *)
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemStore.allItem[indexPath.row]
        
        // Date
        let date = item.date
        let formatter = DateFormatter()
        formatter.dateFormat = "yy. MM. dd  a hh:mm"
        let dateString = formatter.string(from: date)
        
        // Cell
        cell.titleLable.text = item.title
        cell.locationLabel.text = item.location
        cell.dateLabel.text = dateString
        
        print("ViewController time: \(dateString)")
        
        // Cell 이미지 등록
        // 물품 사진의 키를 가져온다
        let key = item.itemKey
        
        // 물품과 연결된 이미지가 있으면
        // 이미지 뷰에 그 이미지를 표시한다.
        let imageToDisplay = imageStore.imageForKey(key: key)
        
        cell.imgView.image = imageToDisplay
        
        // 이미지가 없으면 constant가 20
        // 이미지가 있으면 텍스트가 잘 나오게
        if imageToDisplay == nil {
            cell.trailing.constant = 20
        } else {
            cell.trailing.constant = 120
        }
        
        itemNum.title = "\(itemStore.allItem.count) item"
        
        return cell
    }
    
    @IBAction func addNewItem(sender: AnyObject) {
        
        // 새로 생성
        let newItem = itemStore.createItem()
        
        if itemStore.allItem.index(of: newItem) != nil{
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func deleteToggleItem(sender: UIBarButtonItem) {
        if isEditing {
            editBarItem.title = "편집"
            setEditing(false, animated: true)
        } else {
            editBarItem.title = "완료"
            setEditing(true, animated: true)
        }
        
        print(tableView.isEditing)
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        navigationItem.rightBarButtonItem = editButtonItem
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItem[indexPath.row]
            
            let ac = UIAlertController(title: "삭제 하시겠습니까?", message: "중요한 수첩인지 체크해주세요 :)", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let delAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) -> Void in
                self.itemStore.removeItem(item: item)
                self.imageStore.deletImageForKey(key: item.itemKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.itemNum.title = "\(self.itemStore.allItem.count) item"
            })
            
            ac.addAction(cancelAction)
            ac.addAction(delAction)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            
            // 방금 어느 행이 눌렸는지 계산
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // 연결된 item 가져와서 전달
                let item = itemStore.allItem[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "2018.04"
    }

}












