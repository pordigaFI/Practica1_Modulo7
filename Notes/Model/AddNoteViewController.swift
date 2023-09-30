//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Porfirio Diaz on 25/09/23.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTitle: UITextView!
    
    @IBOutlet weak var noteContent: UITextView!
    var newNote : Note?
    var newNoteFlag : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if newNoteFlag{
            newNote = Note(title: "", content: "", date: Date())
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isModal = self.presentingViewController is UINavigationController
        if isModal{
            self.dismiss(animated: true)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        newNote = Note(title: noteTitle.text, content: noteContent.text, date: Date())
        // Añadir validadacion (ver que tenga algo el titulo y el content)
        let destination = segue.destination as! NotesTableViewController
        destination.note = newNote
        
    }
    
    // Añadir validadacion (ver que tenga algo el titulo y el content)
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !validateNote(){
            print("Nota invalida")
            return false
        }
        return true
    }
    
    private func validateNote() -> Bool{
        if noteTitle.text.isEmpty{
            noteTitle.borderColor = .blue
        }
        if noteContent.text.isEmpty{
            noteContent.borderColor = .blue
        }
        return !noteTitle.text.isEmpty && !noteContent.text.isEmpty
        }
    

}
