//
//  DetailViewController.swift
//  FeedNote
//
//  Created by Dona on 2018. 1. 27..
//  Copyright © 2018년 Dona. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsView: UITextView!
    @IBOutlet var imagesView: UIImageView!
    @IBOutlet var imagesStack: NSLayoutConstraint!
    
    var item: Item!
    var imageStore: ImageStore!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy. MM. dd  a hh:mm"
        let dateString = formatter.string(from: date)
        
        dateLabel.text = dateString
        contentsView.text = item.title
        
        // UI
        
        // navigation
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.setToolbarHidden(true, animated: true)
        navigationController?.toolbar.barTintColor = UIColor.white
        
        // right nav item
//        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(textViewShouldEndEditing))
        let addImg = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImgAction))
        
        navigationItem.rightBarButtonItems = [addImg]
        
        // 물품 사진의 키를 가져온다
        let key = item.itemKey
        
        // 물품과 연결된 이미지가 있으면
        // 이미지 뷰에 그 이미지를 표시한다.
        let imageToDisplay = imageStore.imageForKey(key: key)
        imagesView.image = imageToDisplay
        
        if imageToDisplay == nil {
            imagesStack.constant = 0
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 변경사항을 item에 저장한다
        item.title = contentsView.text ?? ""
    }
    
    @objc func addImgAction() {
        
        let imagePicker = UIImagePickerController()
        
        // 기기에 카메라가 있으면 사진을 찍는다.
        // 아니면 사진 라이브러리에서 사진을 고른다.
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        // 화면에 이미지피커 표시
        present(imagePicker, animated: true, completion: nil)
    }
    
    // imageView 이미지 넣기
    @available(iOS 2.0, *)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 딕셔너리에서 선택된 이미지 가져오기
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // 이미지를 item의 키로 ImageStore안에 저장한다.
        imageStore.setImage(image: image, forKey: item.itemKey)
        
        // 화면상의 이미지를 imageView에 넣는다
        imagesView.image = image
        
        // 사진이 등록 됐을때 stack 높이를 높여준다.
        imagesStack.constant = 269
        
        
        // 이미지 피커를 화면에서 사라지게 한다.
        // 반드시 이 dismiss 메서드를 호출해아함
        dismiss(animated: true, completion: nil)
        
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
