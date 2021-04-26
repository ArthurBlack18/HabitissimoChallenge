
import UIKit

let REQUEST_URL = "api.habitissimo.es/category/list"
let LOCATION_REQUEST_URL = "https://api.habitissimo.es/location/list"
let CATEGORY_REQUEST_URL = "https://api.habitissimo.es/category/list"

var LOCATION_CONSTANT = [LocationModel]()

// Colours
let colorClear = UIColor.clear                                                          // Transparent
let color0 = UIColor.white                                                              // White
let color00 = UIColor.black                                                             // Black

let color1 = UIColor(red: 231/255.0, green: 141/255.0, blue: 57/255.0, alpha: 1.0)      // Orange Habitissimo
let color2 = UIColor(red: 29/255.0, green: 125/255.0, blue: 180/255.0, alpha: 1.0)      // Blue Habitissimo
let color3 = UIColor(red: 96/255.0, green: 98/255.0, blue: 100/255.0, alpha: 1.0)       // Gray Habitissimo

let color4 = UIColor(red: 74/255.0, green: 74/255.0, blue: 74/255.0, alpha: 1.0)        // Negro
let color5 = UIColor(red: 156/255.0, green: 153/255.0, blue: 152/255.0, alpha: 1.0)     // Gris
let color6 = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1.0)     // Casi blanco
let color7 = UIColor(red: 204/255.0, green: 67/255.0, blue: 18/255.0, alpha: 1.0)       // Rojo
let color8 = UIColor(red: 144/255.0, green: 64/255.0, blue: 36/255.0, alpha: 1.0)       // Marrón
let color9 = UIColor(red: 25/255.0, green: 107/255.0, blue: 33/255.0, alpha: 1.0)       // Verde todavía más oscuro
let color10 = UIColor(red: 206/255.0, green: 147/255.0, blue: 92/255.0, alpha: 0.5)      // Orange Habitissimo
let color11 = UIColor(red: 98/255.0, green: 122/255.0, blue: 173/255.0, alpha: 1.0)     // Azul
let color12 = UIColor(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1.0)    // Blanco más blanco que el blanco
let color13 = UIColor(red: 30/255.0, green: 122/255.0, blue: 39/255.0, alpha: 1.0)      // ¿Querías un verde más oscuro que el verde todavía más oscuro? ¡Aquí lo tienes!


// Fuentes
func fontBold(_ iphone: CGFloat) -> UIFont { return UIFont(name: "NotoSansKannada-Bold", size: size(iphone, ipad: iphone + 4))! }

func fontRegular(_ iphone: CGFloat) -> UIFont { return UIFont(name: "NotoSansKannada-Regular", size: size(iphone, ipad: iphone + 4))! }

func fontItalic(_ iphone: CGFloat) -> UIFont { return UIFont(name: "NotoSansKannada-Light", size: size(iphone, ipad: iphone + 4))! }
