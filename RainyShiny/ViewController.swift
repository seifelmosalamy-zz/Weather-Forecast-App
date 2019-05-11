//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by Seif Elmosalamy on 5/7/19.
//  Copyright © 2019 Seif Elmosalamy. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {


    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!


    var currentWeather: CurrentWeather!
    var foreCast:Forecast!
    var foreCasts = [Forecast]()


    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
 }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }

    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{

                currentLocation = locationManager.location
                location.sharedInstance.latitude = currentLocation.coordinate.latitude
                location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                //Setup to download
                self.downloadForeCastData{
                    self.updateMainUI()
                }
            }
            



        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
        
    }

    func downloadForeCastData(completed:@escaping DownloadComplete)  {

        //Downloading forecast weather data for table view

        AF.request(FORECAST_URL).responseJSON {

            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String , AnyObject>{

                if let list = dict["list"] as? [Dictionary<String , AnyObject>] {

                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.foreCasts.append(forecast)
                     

                    }
                    self.foreCasts.remove(at: 0)
                    self.tableView.reloadData()
                }
                
            }; completed()
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell{
            let forecast = foreCasts[indexPath.row]
            cell.configureCell(forecast: forecast)
             return cell

        }

        else {
            return WeatherCell()
        }
    }

    func updateMainUI(){
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        placeLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)


    }


}

