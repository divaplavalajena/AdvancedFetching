//
//  ViewController.swift
//  AdvancedFetching
//
//  Created by Fahir Mehovic on 5/29/15.
//  Copyright (c) 2015 Fahir Mehovic. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var students: [Student] = [];
    var context: NSManagedObjectContext!;
    var model: NSManagedObjectModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveStudent(name: String, age: Int) {
        let student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context) as! Student;
        
        student.name = name;
        student.age = age;
        
        try! context.save()
        
        students.append(student);
    }
    
    func search(name: String) {
        //using fetchRequest template so don't need either of these bits of code
        
        /* let num = NSNumber(int: 24)
            let predicate = NSPredicate(format: "age  > %@", num)
        */
        
        //get student with name that has characters in search request
        /*
        let predicate = NSPredicate(format: "name LIKE[c] '*\(name)*'")
        //let sort = NSSortDescriptor(key: "name", ascending: true)
        
        let request = NSFetchRequest(entityName: "Student")
        request.predicate = predicate
        */
        
        
        
        let request = model.fetchRequestTemplateForName("name")!
        
        let async = NSAsynchronousFetchRequest(fetchRequest: request) { (result: NSAsynchronousFetchResult) -> Void in
            self.students = result.finalResult as! [Student]
            
            for student in self.students {
                print("Student name: \(student.name!), Student Age \(student.age!)")
            }

            
        }
        
        try! context.executeRequest(async)
        
    }
    
    
    @IBAction func addStudent(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Student", message: "Add student name and age", preferredStyle: .Alert);
        
        let search = UIAlertAction(title: "Save", style: .Default) { (alertAction: UIAlertAction) -> Void in
            let textField = alert.textFields![0] ;
            
            let textFieldAge = alert.textFields![1] ;
            
            if let age = Int(textFieldAge.text!) {
                self.saveStudent(textField.text!, age: age);
            }
            
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (alertAction: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
        }
        
        alert.addAction(search);
        alert.addAction(cancel);
        
        presentViewController(alert, animated: true, completion: nil);
        
    }
    
    @IBAction func searchStudent(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Search For Student", message: "Enter Student Name", preferredStyle: .Alert);
        
        let save = UIAlertAction(title: "Search", style: .Default) { (alertAction: UIAlertAction) -> Void in
            
            let textField = alert.textFields![0]
            self.search(textField.text!);
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (alertAction: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
        }
        
        alert.addAction(save);
        alert.addAction(cancel);
        
        presentViewController(alert, animated: true, completion: nil);
        
    }


} // class














































