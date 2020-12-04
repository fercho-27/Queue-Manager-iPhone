//
//  DialogoEditarFilaController.swift
//  GestorColas
//
//  Created by RedMineSS on 24/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoEditarFilaController : UIViewController {
    var fila = ""
    var nombreFila = ""
    var idFila = ""
    
    let transitioner = CAVTransitioner()
    var mainViewController:VistaAdminFilaController?
    
    @IBOutlet weak var etiquetaFila: UILabel!
    @IBOutlet weak var botonGestionar: UIButton!
    @IBOutlet weak var botonEditar: UIButton!
    @IBOutlet weak var botonVaciar: UIButton!
    @IBOutlet weak var botonBorrar: UIButton!
    @IBOutlet weak var botonCancelar: UIButton!

    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init(fila: String) {
        self.init(nibName:nil, bundle:nil)
        self.fila = fila
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        etiquetaFila.text? = "Fila: " + fila
        etiquetaFila.font = UIFont(name: "Arial", size: 14.0)
        
        botonCancelar.addTarget(self, action: #selector(eventoCancelar), for: UIControlEvents.touchUpInside)
        
        botonEditar.layer.cornerRadius = 10.0
        botonEditar.layer.borderWidth = 2
        botonEditar.layer.borderColor = UIColor.yellow.cgColor
        botonEditar.addTarget(self, action: #selector(eventoEditar), for: UIControlEvents.touchUpInside)
        
        botonGestionar.layer.cornerRadius = 10.0
        botonGestionar.layer.borderWidth = 2
        botonGestionar.layer.borderColor = UIColor.yellow.cgColor
        botonGestionar.addTarget(self, action: #selector(eventoGestionar), for: UIControlEvents.touchUpInside)
        
        botonVaciar.layer.cornerRadius = 10.0
        botonVaciar.layer.borderWidth = 2
        botonVaciar.layer.borderColor = UIColor.red.cgColor
        botonVaciar.addTarget(self, action: #selector(eventoVaciar), for: UIControlEvents.touchUpInside)
        
        botonBorrar.layer.cornerRadius = 10.0
        botonBorrar.layer.borderWidth = 2
        botonBorrar.layer.borderColor = UIColor.red.cgColor
        botonBorrar.addTarget(self, action: #selector(eventoBorrar), for: UIControlEvents.touchUpInside)
    }
    
    @objc func eventoEditar(){
        print("Boton Editar")
        //self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoGestionar(){
        print("Boton Gestionar")
        self.presentingViewController?.dismiss(animated: true)
        self.mainViewController?.gestionar(fila: self.nombreFila, id_fila: self.idFila)
    }
    
    @objc func eventoVaciar(){
        print("Boton Vaciar")
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Confirmacion", message: "¿Quieres vaciar las fichas de esta fila?", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (_) in
            /*************************************************/
            let json: [String: String] =
                ["id_fila":self.idFila]
            /**********************************************/
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            // create post request
            let url = URL(string: "http://*IP*/api/vaciarFila")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData!
        
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    //regresar a la vista anterior
                    OperationQueue.main.addOperation {
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                    }
                }
                else {
                    print("ERROR DE VACIO DE FILAS")
                }
            }
            task.resume()
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func eventoBorrar(){
        print("Boton Borrar")
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Confirmacion", message: "¿Quieres borrar esta fila?", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (_) in
            /*************************************************/
            let json: [String: String] =
                ["id_fila":self.idFila]
            /**********************************************/
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            // create post request
            let url = URL(string: "http://*IP*/api/borrarFila")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData!
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    //regresar a la vista anterior
                    OperationQueue.main.addOperation {
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                        self.mainViewController?.dismiss(animated: true, completion: nil)
                    }
                }
                else {
                    print("ERROR DE BORRADO DE FILAS")
                }
            }
            task.resume()
        }
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in }
    
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
    
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
