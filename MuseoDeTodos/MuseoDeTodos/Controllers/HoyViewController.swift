//
//  HoyViewController.swift
//  MuseoDeTodos
//
//  Created by Abraham Cepeda Oseguera on 13/10/21.
//

import UIKit

var selectedDate = Date()

class HoyViewController: UIViewController {
    
//    @IBOutlet weak var dateLbl: UILabel!
//    @IBOutlet weak var calendarCV: UICollectionView!
//    @IBOutlet weak var eventTV: UITableView!
  
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var calendarCV: UICollectionView!
    @IBOutlet weak var eventTV: UITableView!
    
    
    
    var days = [Date]()
    
    var  events: [EventoElement] = []
    
    
    var currentEvents: [String] = ["No se han encontrado eventos"]
    
    var dates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Setup collection view
        //setupDates()
        setupCollectionView()
        setCellsView()
        setWeekView()
        
        //setup Events table view
        setupTableView()
        
        //fetchData
        fetchData()
    }
    
    
    //<----fetch data----->
    func fetchData(){
        NetworkManager.getExternalData(fileLocation: "https://pacific-inlet-83178.herokuapp.com/events", method:  .get, parameters: nil, stringParameters: nil) { (event: Eventos?, error) in
            if error != nil {
                print(error!)
            } else{
                if let eventsRequest = event {
                    for eventItem in eventsRequest {
                        let item = EventoElement(id: eventItem.id, events: eventItem.events, date: eventItem.date)
                        self.events.append(item)
                        self.calendarCV.reloadData()
                        self.eventTV.reloadData()
                    }
                    self.setupDates()
                }
            }
        }
    }
    
    //<----collection view functions----->
    func setupDates(){
        for event in events {
            let date = event.date
            let index = date.index(date.startIndex, offsetBy: 10)
            let newDate = date[..<index]
            dates.append(String(newDate))
        }
    }
    
    func setupCollectionView(){
        calendarCV.delegate = self
        calendarCV.dataSource = self
        let nib = UINib(nibName: "CalendarCollectionViewCell", bundle: nil)
        calendarCV.register(nib, forCellWithReuseIdentifier: "CalendarCell")
    }

    func setCellsView(){
        let width = (calendarCV.frame.size.width - 2) / 8
        let height = (calendarCV.frame.size.height - 2)
        
        let flowLayout = calendarCV.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }

    
    func setWeekView(){
        days.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday){
            days.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        dateLbl.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        calendarCV.reloadData()
        //tableView.reloadData()
    }
    
    //<----table view functions----->
    func setupTableView(){
        eventTV.delegate = self
        eventTV.dataSource = self
        let nib = UINib(nibName: "EventoTableViewCell", bundle: nil)
        eventTV.register(nib, forCellReuseIdentifier: "EventoCell")
    }
    
    
    //prev btn
    @IBAction func previewsWeek(_ sender: UIButton) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    
    //next btn
    @IBAction func nextWeek(_ sender: UIButton) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
}

//<----collection view methods----->
extension  HoyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendarCV.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCollectionViewCell
        let date = days[indexPath.row]
        
        let year = CalendarHelper().yearString(date: date)
        let month = CalendarHelper().month(date: date)
        let day = CalendarHelper().dayOfMonth(date: date)
        let stringDate = year + "-" + month + "-" + String(day)
        
        //selected
        if(date == selectedDate){
            cell.dayView.layer.backgroundColor = #colorLiteral(red: 0.8954718709, green: 0.1038885489, blue: 0.6602074504, alpha: 1)
            cell.dayLbl.textColor = UIColor.white
        } else {
            cell.dayView.layer.backgroundColor = UIColor(white: 1, alpha: 0).cgColor
            cell.dayLbl.textColor = UIColor.black
        }
        
        //has events
        if(dates.contains(stringDate)){
            let index = dates.firstIndex(of: stringDate)!
            cell.numEventsLbl.text = String(events[index].events.count)
            cell.numEventsView.isHidden = false
            
            //has events and is selected
            if(date == selectedDate){
                currentEvents.removeAll()
                for event in events[index].events {
                    currentEvents.append(event)
                }
                eventTV.reloadData()
            }
        } else {
            cell.numEventsView.isHidden = true
        }
        
        
        
        
        cell.dayLbl.text = String(CalendarHelper().dayOfMonth(date: date))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = days[indexPath.item]
        currentEvents.removeAll()
        currentEvents.append("No se han encontrado eventos")
        calendarCV.reloadData()
        eventTV.reloadData()
    }
    
    
}


//<----table view methods----->
extension HoyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTV.dequeueReusableCell(withIdentifier: "EventoCell", for: indexPath) as! EventoTableViewCell
        cell.titleLbl.text = currentEvents[indexPath.row]
        return cell
    }


}
