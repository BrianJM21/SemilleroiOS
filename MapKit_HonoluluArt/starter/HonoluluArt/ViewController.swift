/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
// importamos MapKit para poder trabajar con el framework de Maps
import MapKit

class ViewController: UIViewController {
  
  // Enlazamos el elemento visual del Mapa con el ViewController
  @IBOutlet private var mapView: MKMapView!
  
  // Un arreglo para retener el arreglo de anotaciones decodificadas el JSON
  private var artworks: [Artwork] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Inicializamos las coordenadas a las que se centrará el mapa
    let latitude: Double = 21.282778
    let longitud: Double = -157.829444
    let initialLocation = CLLocation(latitude: latitude, longitude: longitud)
    mapView.centerToLocation(initialLocation)
    
    // Agregamos unas restricciones de cámara para que el usuario no pueda moverse más allá
    // de los límites preestablecidos
    let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
    let region = MKCoordinateRegion(center: oahuCenter.coordinate, latitudinalMeters: 50000, longitudinalMeters: 60000)
    mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
    mapView.setCameraZoomRange(zoomRange, animated: true)
    
    // Creamos un objeto de nuestra clase Artwork y lo agregamos al mapa en forma de una
    // anotación en el mapa, dadas unas coordenadas
/*    let artwork = Artwork(title: "King David Kalakaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
    mapView.addAnnotation(artwork)*/
    
    // Indicamos que ViewController será el delegado del MapView
    mapView.delegate = self
    
    // Pintamos las anotaciones
    mapView.register(ArtworkMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    
    // Agregamos un array de anotaciones
    loadInitialData()
    mapView.addAnnotations(artworks)
  }
  

  private func loadInitialData() {
    
    // 1
    guard
      let fileName = Bundle.main.url(forResource: "PublicArt", withExtension: "geojson"),
      let artworkData = try? Data(contentsOf: fileName)
      else {
      
        return
    }

    do {
      
      // 2
      let features = try MKGeoJSONDecoder()
        .decode(artworkData)
        .compactMap { $0 as? MKGeoJSONFeature }
      
      // 3
      let validWorks = features.compactMap(Artwork.init)
      
      // 4
      artworks.append(contentsOf: validWorks)
    } catch {
      
      // 5
      print("Unexpected error: \(error).")
    }
  }

  // 1. To begin, you read PublicArt.geojson into a Data object.
  // 2. You use MKGeoJSONDecoder to obtain an array of GeoJSON objects but only keep instances of MKGeoJSONFeature using compactMap.
  // 3. You transform the MKGeoJSONFeature objects into Artwork objects using its failable initializer you added and compactMap again.
  // 4. ou append the resulting validWorks to the artworks array.
  // 5. Because MKGeoJSONDecoder‘s decode(_ :) method can throw an error, you catch it and print the error to the Xcode console.

}

private extension MKMapView {
  
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}


// Implementamos los métodos de Delegado para las anotaciones del Mapa, de esta manera podemos
// desplegar dichas anotaciones en forma visual
extension ViewController: MKMapViewDelegate {
/*
  // 1
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    // 2
    guard let annotation = annotation as? Artwork else { return nil }
    
    // 3
    let identifier = "artwork"
    var view: MKMarkerAnnotationView
    
    // 4
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
      
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      
      // 5
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    
    return view
  }
*/
  
  
  //1. mapView(_:viewFor:) gets called for every annotation you add to the map — like tableView(_:cellForRowAt:) when working with table views — to return the view for each annotation.
  //2. Your app might use other annotations, like user location, so check that this annotation is an Artwork object. If it isn’t, return nil to let the map view use its default annotation view.
  //3. You create each view as an MKMarkerAnnotationView. Later in this tutorial, you’ll create MKAnnotationView objects to display images instead of markers.
  //4. Also similarly to tableView(_:cellForRowAt:), a map view reuses annotation views that are no longer visible. So you check to see if a reusable annotation view is available before creating a new one. When you dequeue a reusable annotation, you give it an identifier.
  //  If you have multiple styles of annotations, be sure to have a unique identifier for each one. Again, it’s the same idea behind a cell identifier in tableView(_:cellForRowAt:).
  //5. Here you create a new MKMarkerAnnotationView object if an annotation view could not be dequeued. It uses the title and subtitle properties of your Artwork class to determine what to show in the callout.
 
  
  
  
  // Con esta implementación podemos controllar el callout cuando el usuario presiona el botón de más información
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
    guard let artwork = view.annotation as? Artwork else { return }

    let launchOptions = [
      MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
    ]
    
    artwork.mapItem?.openInMaps(launchOptions: launchOptions)
  }
}
