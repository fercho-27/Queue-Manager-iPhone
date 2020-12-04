//
//  DialogoSeleccionarBloqueController.swift
//  GestorColas
//
//  Created by RedMineSS on 08/11/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit

class DialogoSeleccionarBloqueController : UIViewController {
    
    var fila = ""
    var idFila = ""
    var horas: [String] = []
    var dias: [String] = []
    var idBloques: [String] = []
    
    let transitioner = CAVTransitioner()
    var mainViewController:VistaGestionarFilaController?
    
    @IBOutlet weak var etiquetaFila: UILabel!
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var botonConfirmar: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var altura: NSLayoutConstraint!
    
    var arregloSwitches: [UISwitch] = []
    
    @objc func eventoCambiar(_ sender: UISwitch){
        for boton in arregloSwitches{
            if boton != sender {
                boton.setOn(false, animated: true)
            }
        }
    }
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init(fila: String, idFila: String) {
        self.init(nibName:nil, bundle:nil)
        self.fila = fila
        self.idFila = idFila
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://*IP*/api/getBloques/\(self.idFila)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR DE URL")
            }
            else {
                if let content = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [NSDictionary]
                        print(json)
                        for fila in json {
                            let horaInicio = String(describing: fila["hora_inicio"]!).split(separator: ":")
                            let dia = String(describing: fila["dia"]!)
                            let id = String(describing: fila["id_bloque"]!)
                            self.idBloques.append(id)
                            self.horas.append(horaInicio[0]+":"+String(horaInicio[1]))
                            self.dias.append(dia)
                        }
                        OperationQueue.main.addOperation {
                            //OBTENER EL HORARIO
                            var y = 10
                            for i in 0...self.idBloques.count - 1{
                                //SWITCH HORA
                                let boton = UISwitch()
                                boton.frame = CGRect(x:20,y:y,width:49,height:31)
                                boton.addTarget(self, action: #selector(self.eventoCambiar), for: UIControlEvents.valueChanged)
                                //ETIQUETA HORA
                                let etiqueta = UILabel()
                                etiqueta.text = self.horas[i]+" - "+self.dias[i]
                                etiqueta.textAlignment = NSTextAlignment.left
                                etiqueta.textColor = UIColor.black
                                etiqueta.font = UIFont(name: "Arial", size: 12.0)
                                etiqueta.numberOfLines = 0
                                etiqueta.frame = CGRect(x:0,y:0,width:200,height:50)
                                etiqueta.center = CGPoint(x:180,y:y+17)
                                y+=40
                                //AGREGAR AL SCROLL
                                self.arregloSwitches.append(boton)
                                self.vistaScroll.addSubview(boton)
                                self.vistaScroll.addSubview(etiqueta)
                            }
                            //Ajustar el scroll
                            self.altura.constant = CGFloat(y+20)
                        }
                    }
                    catch {
                        
                    }
                }
            }
        }
        task.resume()
        /********************************/
        etiquetaFila.text? = "Fila: " + fila
        etiquetaFila.font = UIFont(name: "Arial", size: 14.0)
        
        botonConfirmar.addTarget(self, action: #selector(eventoConfirmar), for: UIControlEvents.touchUpInside)
        botonCancelar.addTarget(self, action: #selector(eventoCancelar), for: UIControlEvents.touchUpInside)
    }
    
    @objc func eventoConfirmar(){
        print("Boton confirmar")
        //mainViewController?.setDiaInicio(fecha: año)
        //AQUI VA EL FOR EACH PARA RECUPERAR LOS ESTADOS
        var idBloqueSeleccionado = ""
        for i in 0...arregloSwitches.count - 1 {
            if arregloSwitches[i].isOn {
                idBloqueSeleccionado = idBloques[i]
                break
            }
        }
        self.mainViewController?.idBloque = idBloqueSeleccionado
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoCancelar(){
        print("Boton cancelar")
        self.presentingViewController?.dismiss(animated: true)
    }
}
