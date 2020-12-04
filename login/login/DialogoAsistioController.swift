//
//  DialogoAsistioController.swift
//  GestorColas
//
//  Created by RedMineSS on 08/11/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoAsistioController : UIViewController {
    var fila = ""
    var asistio = ""
    var idFicha = ""
    
    let transitioner = CAVTransitioner()
    var mainViewController:VistaGestionarFilaController?
    
    @IBOutlet weak var etiquetaFila: UILabel!
    
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var botonNoAsistio: UIButton!
    @IBOutlet weak var botonAsistio: UIButton!
    
    
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
        botonNoAsistio.addTarget(self, action: #selector(eventoNoAsistio), for: UIControlEvents.touchUpInside)
        botonAsistio.addTarget(self, action: #selector(eventoAsistio), for: UIControlEvents.touchUpInside)
        
    }
    
    @objc func eventoNoAsistio(){
        print("Boton no asistio")
        self.marcar(idFicha: self.idFicha, atendido: "2")
    }
    
    @objc func eventoAsistio(){
        print("Boton asistio")
        self.marcar(idFicha: self.idFicha, atendido: "1")
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func marcar(idFicha: String, atendido: String){
        /*************************************************/
        let json: [String: String] =
            ["id_ficha":idFicha, "atendido":atendido]
        /**********************************************/
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        // create post request
        let url = URL(string: "http://*IP*/api/updateAtendido")!
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
                    self.mainViewController?.vistaTabla.isHidden = true
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            }
            else {
                print("ERROR DE ASISTIR")
            }
        }
        task.resume()
    }
    
}
