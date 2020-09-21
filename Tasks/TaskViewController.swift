//
//  TaskViewController.swift
//  Tasks
//
//  Created by Omer Mohamed Ali on 21.09.20.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var task: String?
    var index: Int?
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))

        // Do any additional setup after loading the view.
    }
    
    @objc func deleteTask() {
        guard var count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        guard let savedTask = UserDefaults().value(forKey: "task_\(index!)") as? String else {
            print("Didnt find task with index \(index!)")
            return
        }
        
        UserDefaults().removeObject(forKey: "task_\(index!)")
        
        var counter = 0
        for x in index! ..< count {
            guard let t = UserDefaults().value(forKey: "task_\(x+1)") as? String else {
                continue
            }
            
            let newKey = index! + counter
            UserDefaults().setValue(t, forKey: "task_\(newKey)")
            
            counter += 1
        }
        
        UserDefaults().setValue(count-1, forKey: "count")
        
        update?()
        
        navigationController?.popViewController(animated: true)
        
        
//        let newCount = count - 1
//
//        UserDefaults().setValue(newCount, forKey: "count")
//        UserDefaults().setValue(nil, forKey: "task_\(currentPosition)")
    }
    

}
