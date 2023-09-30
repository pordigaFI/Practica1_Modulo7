//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Porfirio Diaz on 25/09/23.
//

import UIKit
import Foundation

class NotesTableViewController: UITableViewController {
    
    @IBOutlet var emptyNotesView: UIView!
    
    @IBOutlet var tableViewNotes: UITableView!
    //asociamos la clase NoteManager y la estructura Note
    let noteManager = NoteManager()
    var note : Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNotes.isEditing = true
        if noteManager.countNotes() == 0 {
            emptyNotesView.isHidden = false
            tableViewNotes.backgroundView = emptyNotesView
        }else{
            emptyNotesView.isHidden = true
        }
        
    }
    
    

    // MARK: - Table view data source

    //Esta función nos va a decir cuantas secciones va a tener nuestro Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //Esta función nos va a decir cuantos elementos tendremos por sección
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteManager.countNotes()
    }
    
    
    //Nos servira para regresar en tiempo de ejecución a nuestro tableView la celda actual
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        //dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss.SSSZZZZZ"
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell

        let actualNote = noteManager.getNote(at: indexPath.row)
        // Configure the cell...
        cell.titleNote.text = actualNote.title
        
        
        cell.dateNote.text = dateFormatter.string(from: actualNote.date)
        
        
        return cell
    }
  
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete {
            // Delete the row from the data source
            
            noteManager.deleteNote(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectedRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "showNoteSegue", sender: self)
    }
*/
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNoteSegue"{
            let destination = segue.destination as! AddNoteViewController
            destination.newNote = noteManager.getNote(at: self.tableView.indexPathForSelectedRow!.row)
            
            destination.newNoteFlag = false
            
        }
        
    }
    
    @IBAction func unWindFromAddNoteViewController(segue: UIStoryboardSegue) {
        print("Unwind Segue!")
        
        let source = segue.source as! AddNoteViewController
        note = source.newNote
        
        noteManager.createNote(note: note!)
        print("numero de notas", noteManager.countNotes())
        print("notes: ", noteManager.getNotes())
        noteManager.saveNotes()
        tableViewNotes.reloadData()
    }
    

}
