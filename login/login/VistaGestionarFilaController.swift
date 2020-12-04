//
//  VistaGestionarFilaController.swift
//  GestorColas
//
//  Created by RedMineSS on 24/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit
import QuartzCore

class VistaGestionarFilaController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var nombreFila = ""
    var id_fila = ""
    var idBloque = ""
    
    //Numero de filas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myDataArray.count
    }
    
    //Contenido de las celdas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Arial", size: 24.0)
        cell.textLabel?.text = self.myDataArray[indexPath.row]
        
        cell.backgroundColor? = UIColor.blue
        
        return cell
    }
    
    //Evento al oprimir una celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let dialogo = DialogoAsistioController(fila: self.myDataArray[indexPath.row])
        dialogo.mainViewController = self
        dialogo.asistio = self.bandAtendidos[indexPath.row]
        dialogo.idFicha = self.idFichas[indexPath.row]
        self.present(dialogo, animated: true, completion: nil)
    }
    
    var myDataArray: [String] = []
    var idFichas: [String] = []
    var bandAtendidos: [String] = []
    
    let cellReuseIdentifier = "cell"
    
    
    @IBOutlet weak var botonSeleccionar: UIButton!
    @IBOutlet var vista: UIView!
    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var vistaTabla: UITableView!
    @IBOutlet weak var botonRegresar: UIButton!
    @IBOutlet weak var botonBuscar: UIButton!
    var mainViewController:VistaAdminFilaController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vistaTabla.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        vistaTabla.delegate = self
        vistaTabla.dataSource = self
        
        print("Estoy en la vista de gestionar fila")
        print(self.nombreFila)
        
        //BOTON SELECCIONAR
        botonSeleccionar.layer.cornerRadius = 10.0
        botonSeleccionar.layer.borderWidth = 2
        botonSeleccionar.layer.borderColor = UIColor.yellow.cgColor
        botonSeleccionar.addTarget(self, action: #selector(eventoSeleccionar), for: UIControlEvents.touchUpInside)
        
        //BOTON BUSCAR
        botonBuscar.layer.cornerRadius = 10.0
        botonBuscar.layer.borderWidth = 2
        botonBuscar.layer.borderColor = UIColor.red.cgColor
        botonBuscar.addTarget(self, action: #selector(eventoBuscar), for: UIControlEvents.touchUpInside)
        
        //BOTON REGRESAR
        botonRegresar.layer.cornerRadius = 10.0
        botonRegresar.layer.borderWidth = 2
        botonRegresar.layer.borderColor = UIColor.red.cgColor
        botonRegresar.addTarget(self, action: #selector(eventoRegresar), for: UIControlEvents.touchUpInside)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func eventoSeleccionar(){
        print("Seleccionar")
        self.vistaTabla.isHidden = true
        let dialogo = DialogoSeleccionarBloqueController(fila: self.nombreFila, idFila: self.id_fila)
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
        //etiquetaHoraInicio.text! = "Hora de inicio" + ": 10:00"
    }
    
    @objc func eventoBuscar(){
        print("BUSCAR ALUMNOS")
        if self.idBloque == "" {
            //PONER MENSAJE DE NO SELECCIONAR BLOQUE
            self.showInputDialog(mensaje: "No has seleccionado un bloque")
            return
        }
        self.myDataArray.removeAll()
        self.bandAtendidos.removeAll()
        self.idFichas.removeAll()
        print(self.idBloque)
        //RECUPERAR FICHAS
        let url = URL(string: "http://*IP*/api/gestionarFichas/\(self.idBloque)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("ERROR DE URL")
            }
            else {
                if let content = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [NSDictionary]
                        print(json)
                        if json.isEmpty {
                            OperationQueue.main.addOperation {
                                if self.vistaTabla.isHidden == true {
                                    self.showInputDialog(mensaje: "No hay fichas en el Bloque")
                                }
                            }
                            return
                        }
                        var cont = 0
                        for fila in json {
                            let idFicha = String(describing: fila["id_ficha"]!)
                            let numControl = String(describing: fila["numero_control_estandar"]!)
                            let atendido = String(describing: fila["atendido"]!)
                            if atendido == "1" || atendido == "2" {
                                cont = cont + 1
                                if cont == json.count {
                                    OperationQueue.main.addOperation {
                                        if self.vistaTabla.isHidden == true {
                                            self.showInputDialog(mensaje: "Todas las fichas fueron atendidas")
                                        }
                                    }
                                }
                                continue
                            }
                            self.idFichas.append(idFicha)
                            self.bandAtendidos.append(atendido)
                            OperationQueue.main.addOperation {
                                //RECUPERAR USUARIO
                                let url2 = URL(string: "http://*IP*/api/getInformacion/\(numControl)")!
                                let task2 = URLSession.shared.dataTask(with: url2) { (data2, response2, error2) in
                                    if error2 != nil {
                                        print("ERROR DE URL")
                                    }
                                    else {
                                        if let content2 = data2 {
                                            do {
                                                let json2 = try JSONSerialization.jsonObject(with: content2, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                                                print(json2)
                                                    let nombre = String(describing: json2["nombre"]!)
                                                    let carreraNum = String(describing: json2["carrera"]!)
                                                    var carrera = ""
                                                    /*
                                                     1 Licenciatura en Administración
                                                     2 IngenierÌa Bioquímica
                                                     3 IngenierÌa Electrica
                                                     4 IngenierÌa Electronica
                                                     5 IngenierÌa Industrial
                                                     6 IngenierÌa Mecantronica
                                                     7 IngenierÌa Mecanica
                                                     8 IngenierÌa Quimica
                                                     9 IngenierÌa en Sistemas Computacionales
                                                     10 IngenierÌa en Energias Renovalbes
                                                     11 IngenierÌa en Gestion Empresarial
                                                     */
                                                    switch Int(carreraNum)! {
                                                    case 1 :
                                                        carrera = "Lic. Administración"
                                                        break
                                                    case 2 :
                                                        carrera = "Ing. Bioquímica"
                                                        break
                                                    case 3 :
                                                        carrera = "Ing. Eléctrica"
                                                        break
                                                    case 4 :
                                                        carrera = "Ing. Electrónica"
                                                        break
                                                    case 5 :
                                                        carrera = "Ing. Industrial"
                                                        break
                                                    case 6 :
                                                        carrera = "Ing. Mecatrónica"
                                                        break
                                                    case 7 :
                                                        carrera = "Ing. Mecanica"
                                                        break
                                                    case 8 :
                                                        carrera = "Ing. Química"
                                                        break
                                                    case 9 :
                                                        carrera = "Ing. Sistemas Computacionales"
                                                        break
                                                    case 10 :
                                                        carrera = "Ing. Energías Renovables"
                                                        break
                                                    case 11 :
                                                        carrera = "Ing. Gestión Empresarial"
                                                        break
                                                    default :
                                                        carrera = "Desconocido"
                                                    }
                                                    var semestre = String(describing: json2["semestre"]!)
                                                    if semestre == "16" {
                                                        semestre = "0"
                                                    }
                                                    self.myDataArray.append("\(numControl)\n\(nombre)\n\(carrera)\nSemestre: \(semestre)")
                                                OperationQueue.main.addOperation {
                                                    self.vistaTabla.dataSource = self
                                                    self.vistaTabla.delegate = self
                                                    self.vistaTabla.reloadData()
                                                    self.vistaTabla.isHidden = false
                                                }
                                            }
                                            catch {}
                                        }
                                    }
                                }
                                task2.resume()
                                /********************************/
                            }
                            
                        }
                    }
                    catch {}
                }
            }
        }
        task.resume()
        /********************************/
        
        //self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func eventoRegresar(){
        print("Operacion Regresar")
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Regresar", message: "¿Quieres salir?", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (_) in
            //regresar a la vista anterior
            self.presentingViewController?.dismiss(animated: true)
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showInputDialog(mensaje: String) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Advertencia", message: mensaje, preferredStyle: .alert)
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Confirmar", style: .cancel) { (_) in }
        
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
}
