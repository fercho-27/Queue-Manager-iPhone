//
//  VistaSacarFichaController.swift
//  GestorColas
//
//  Created by RedMineSS on 25/10/19.
//  Copyright © 2019 RedMineSS. All rights reserved.
//

import UIKit
import QuartzCore

class VistaSacarFichaController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        let dialogo = DialogoSacarFichaController(fila: self.myDataArray[indexPath.row])
        dialogo.mainViewController = self
        self.present(dialogo, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imagenFondo: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var vistaScroll: UIView!
    @IBOutlet weak var botonRegresar: UIButton!
    @IBOutlet weak var vistaTabla: UITableView!
    
    let myDataArray: [String] = [
        "Becas\n Lugar: Sala Raul Limon\n Dias: 22/09/2019 - 22/09/2019\n Horario: 10:00 - 15:00",
        "Credenciales\n Lugar: Sala Fermin Carillo\n Dias: 24/09/2019 - 27/09/2019\n Horario: 8:00 - 17:00",
        "Constancias\n Lugar: Sala Raul Limon\n Dias: 25/09/2019 - 30/09/2019\n Horario: 7:00 - 15:00"]
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vistaTabla.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        vistaTabla.delegate = self
        vistaTabla.dataSource = self
        
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
    
}


