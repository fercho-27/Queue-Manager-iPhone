//
//  VistaAdminFilaController.swift
//  GestorColas
//
//  Created by RedMineSS on 21/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit
import QuartzCore

class VistaAdminFilaController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        let dialogo = DialogoEditarFilaController(fila: self.myDataArray[indexPath.row])
        dialogo.mainViewController = self
        dialogo.nombreFila = self.nombreFilas[indexPath.row]
        dialogo.idFila = self.idFilas[indexPath.row]
        self.present(dialogo, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var botonRegresar: UIButton!
    @IBOutlet weak var vistaTabla: UITableView!
    
    var numControlAdmin = ""
    
    var myDataArray: [String] = []
    var nombreFilas: [String] = []
    var idFilas: [String] = []
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://*IP*/api/getFilas/\(self.numControlAdmin)")!
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
                            self.nombreFilas.append("\(fila["nombre_fila"]!)")
                            self.idFilas.append("\(fila["id_fila"]!)")
                            print(fila["nombre_fila"]!)
                            print(fila["carreras"]!)
                            print("****************")
                            let horaInicio = String(describing: fila["hora_inicio"]!).split(separator: ":")
                            let horaFinal = String(describing: fila["hora_final"]!).split(separator: ":")
                            self.myDataArray.append("\(fila["nombre_fila"]!)\n Lugar: \(fila["lugar"]!)\n Días: \(fila["dia_inicio"]!) - \(fila["dia_final"]!)\n Horario: \(horaInicio[0]):\(horaInicio[1]) - \(horaFinal[0]):\(horaFinal[1])")
                        }
                        OperationQueue.main.addOperation {
                            self.vistaTabla.register(UITableViewCell.self, forCellReuseIdentifier: self.cellReuseIdentifier)
                            
                            self.vistaTabla.dataSource = self
                            self.vistaTabla.delegate = self
                            self.vistaTabla.reloadData()
                        }
                    }
                    catch {
                        
                    }
                }
            }
        }
        task.resume()
        /********************************/
        
        print("Estoy en la otra vista DE ADMINISTRAR filas")
        
        //BOTON REGRESAR
        botonRegresar.layer.cornerRadius = 10.0
        botonRegresar.layer.borderWidth = 2
        botonRegresar.layer.borderColor = UIColor.yellow.cgColor
        botonRegresar.addTarget(self, action: #selector(eventoRegresar), for: UIControlEvents.touchUpInside)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func eventoRegresar(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func gestionar(fila: String, id_fila: String){
        let viewController:VistaGestionarFilaController = UIStoryboard(name: "VistaGestionarFila", bundle: nil).instantiateViewController(withIdentifier: "VistaGestionarFila") as! VistaGestionarFilaController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        viewController.nombreFila = fila
        viewController.id_fila = id_fila
        self.present(viewController, animated: false, completion: nil)
        
    }
    
}

