//
//  NoteManager.swift
//  Notes
//
//  Created by Porfirio Diaz on 25/09/23.
//

import Foundation

//el manager va a ser nuestro manejador de las notas
//Aqui se van a definir las funciones para crear, leer, actualizar, borrar, etc

class NoteManager{
    private var notes : [Note] = []
    
    //Esta función va a recibir una nota del tipo Note
    func createNote (note : Note) {
        notes.append(note)
    }
    
    func deleteNote(at index : Int){
        notes.remove(at: index)
    }
    
    func deleteFile(){
        //obtenemos la referencia al directorio en el que se encuentra el archivo a borrar
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        //Construimos la URL completa del archivo a borrar
        let archivoAEliminar = documentDirectory.appendingPathComponent("notes.json")
        if fileManager.fileExists(atPath: archivoAEliminar.path){
            //Si el archivo existe, proceder a borrarlo
            do{
                try fileManager.removeItem(at: archivoAEliminar)
                print("Archivo eliminado correctamente")
            }catch{
                print("Error al eliminar el archivo")
            }
        } else{
            //El archivo no existe
            print("El archivo no existe")
        }
    }
    
    func countNotes() -> Int {
        return notes.count
    }
    
    func getNote(at index : Int) -> Note{
        return notes[index]
    }
    
    func getNotes() -> [Note]{
        return notes
    }
    
    func getFilePath() -> URL{
        //obtenemos la referencia al directorio en el que se encuentra el archivo o item
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        //Construimos la URL completa del archivo o item
        let noteUrlPath = documentDirectory.appendingPathComponent("notes.json")
        return URL(string: noteUrlPath.absoluteString)!
    }
    
    //LoadNotes va a recuperar las notas de donde esten almacenadas (archivo)
    func loadNotes(){
        let notesPath = getFilePath()
        let fileManager = FileManager.default
        //let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        //let notesPath = documentDirectory.appendingPathComponent("notes.json")
        //print(notesPath)
        
        //Revisar si el archivo existe
        if (fileManager.fileExists(atPath: notesPath.path)){
        
            do{
                let jsonData = fileManager.contents(atPath: notesPath.path)
                print("json",jsonData as Any)
                notes = try JSONDecoder().decode([Note].self,from: jsonData!)
                print("Notes : ", notes)
            }catch let error {
                print("error ...: ", error)
            }
            
        }else{
            print("Mensaje: Files does not exists")
        }
        
        
    }
    
    //saveNotes guarda las notas en un archivo
    func saveNotes(){
        //set directory for save json file
        let notesPath = getFilePath()
        let fileManager = FileManager.default
        //let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        //let notesPath = documentDirectory.appendingPathComponent("notes.json")
        print(notesPath)
        
        //add note to json file
        do{
            let jsonData = try JSONEncoder().encode(notes)
            //print("path",notesPath.path)
            fileManager.createFile(atPath: getFilePath().path, contents: jsonData)
        }catch let error {
            print(error)
        }
        
    }
    
    func updateNote(note: Note, at index: Int){
        notes[index] = note
    }
    
    //actualiza una nota específica
    func updateSpecificNotes(note : Note, at index : Int){
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        do{
            let directoryContents = try fileManager.contentsOfDirectory(atPath: documentDirectory.path)
            for (index, element) in directoryContents.enumerated(){
                print("Element \(index): \(element)")
            }
            //seleccionamos el indice del elemento a eliminar
            let indexToDelete = 0   //el "0" lo sustituimos por el indice del elemento que queremos eliminar
            if indexToDelete >= 0 && indexToDelete < directoryContents.count{
                let elementToDelete = directoryContents[indexToDelete]
                
                //Construimos la Url completa del elemento a eliminar
                let elementURL = documentDirectory.appendingPathComponent(elementToDelete)
                
                //Verificamos si el elemento existe antes de intentar eliminarlo
                if fileManager.fileExists(atPath: elementURL.path){
                    do{
                        try fileManager.removeItem(at: elementURL)
                        print("Elemento eliminado correctamente")
                    }catch{
                        print("Error al eliminar el elemento")
                    }
                }else{
                    print("El elemento no existe")
                }
            }else{
                print("El elemento está fuera de rango")
            }
        }catch{
            print("Error al obtener la lista de elementos")
        }
    }
    
}
