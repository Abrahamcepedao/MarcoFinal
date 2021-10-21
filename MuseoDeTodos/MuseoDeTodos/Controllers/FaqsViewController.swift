//
//  FaqsViewController.swift
//  MuseoDeTodos
//
//  Created by Ezequiel Lozano Guerrero on 10/5/21.
//

import UIKit

class FaqsViewController: UIViewController {

    @IBOutlet weak var faqsTV: UITableView!
    
    
    var questions: [Question] = [
        Question(question: "¿Qué día es gratis la entrada al Museo Marco?", answer: "¡Miércoles de entrada gratis con horario de 10 am a 8 pm!", show: false),
        Question(question: "¿Quién creó el Museo Marco?", answer: "Diego Sada Zambrano", show: false),
        Question(question: "¿Cuánto cuesta la entrada al Museo Marco?", answer: "Entrada general $90. Estudiantes, maestros, miembros del INAPAM con credencial vigentne y niños de 6 a 15 años $60. Niños menores a 5 años $30", show: false),
        Question(question: "¿Qué significa el acrónimo Marco?", answer: "Museo de Arte Contemporáneo de Monterrey (MARCO)", show: false),
        Question(question: "¿Qué actividades realiza el Museo Marco?", answer: "Exhibe más de 100 piezas de arte contemporáneo y organiza visitas guiadas, conciertos, talleres, subastas y eventos culturales. Ofrece catálogos y programas educativos para maestros. Cuenta con auditorio, restaurante, cafetería y tienda.", show: false),
        Question(question: "¿En qué consiste la campaña #SOSMARCO?", answer: "Su objetivo es apoyar a Marco en esta etapa cr´tiica derivada de la suspensión de proyectos, visitas, actividades, membresías, entre otros ingresos, como parte de las medidas de seguridad e higiene, atacadas desde el pasado 17 de marzo debido a la pandemia del Covid-19.", show: false),
        Question(question: "¿A quñe será destinado el monto recaudado?", answer: "Se destinará al mantenimiento de la institución que está en un punto delicado y a la reactivación de la operatividad normal del recinto cultural tan pronto concluya la contingencia.", show: false),
        Question(question: "¿Puedo aportar la cantidad que yo quiera?", answer: "A partir de los $30 la cantidad con la que gustes contribuir es a tu consideración", show: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    func setupTableView(){
        faqsTV.delegate = self
        faqsTV.dataSource = self
        let nib = UINib(nibName: "QuestionTableViewCell", bundle: nil)
        faqsTV.register(nib, forCellReuseIdentifier: "QuestionCell")
    }

}

extension FaqsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = faqsTV.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionTableViewCell
        
        cell.questionLbl.text = questions[indexPath.row].question
        cell.answerLbl.text = questions[indexPath.row].answer
        
        cell.showBtn.setImage(UIImage(systemName: questions[indexPath.row].show ? "minus.circle.fill" : "plus.circle.fill"), for: .normal)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        questions[indexPath.row].show = !questions[indexPath.row].show
        //faqsTV.reloadData()
        faqsTV.reloadRows(at: [indexPath], with: .right)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!questions[indexPath.row].show){
            return 50
        }
        return CGFloat(55 + (questions[indexPath.row].answer.count / 50 + 2) * 20)
    }
}


extension FaqsViewController: QuestionCellDelegate {
    func showBtnTapped(with question: String) {
        var index = 0
        for i in 0..<questions.count{
            if question == questions[i].question {
                index = i
            }
        }
        questions[index].show = !questions[index].show
        let indexPath = IndexPath(row: index, section: 0)
        faqsTV.reloadRows(at: [indexPath], with: .right)
    }
    
    
}
