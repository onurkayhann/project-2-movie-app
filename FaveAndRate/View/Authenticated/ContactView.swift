//
//  ContactView.swift
//  FaveAndRate
//
//  Created by Onur Kayhan on 2024-10-28.
//

import SwiftUI
import MapKit

struct ContactView: View {
    
    let locationManager = LocationManager()

    @State var nameInput = ""
    @State var phoneNumberInput = ""
    @State var errandInput = ""
    
    @State var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.309857850079666, longitude: 18.022240207022453), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    
    @State var office = Office(name: "Fave & Rate", location: Location(latitude: 59.309567930490935, longitude: 18.02159818846419))
    
    @State var selectedOffice: Office? = nil
    
    var body: some View {
        
        Form {
            TextField("Name", text: $nameInput)
            TextField("Phone", text: $phoneNumberInput)
            ZStack(alignment: .leading) {
                if errandInput.isEmpty {
                    Text("Errand").foregroundStyle(.gray)
                    }
                TextEditor(text: $errandInput)
            }
        }
        
        ZStack {
            
            Map(position: $position) {
                
                
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: office.location.latitude, longitude: office.location.longitude)) {
                                    
                                    Button(action: {
                                        print("\(office.name) pressed!")
                                        
                                        if self.selectedOffice?.id == office.id {
                                            self.selectedOffice = nil
                                        } else {
                                            self.selectedOffice = office
                                        }
                                    }) {
                                        VStack {
                                            Circle()
                                                .foregroundStyle(.red)
                                                .frame(width: 20, height: 20, alignment: .center)
                                            Text(office.name)
                                                .font(.system(size: 12))
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
            }.mapControls {
                MapUserLocationButton()
                MapPitchToggle()
            }
            

            
            VStack {
                
                Spacer()
                
                if let selectedOffice = selectedOffice {
                    
                    Button(action: {
                        
                    }, label: {
                        Text(selectedOffice.name).bold()
                            .padding()
                            .background(.black)
                            .foregroundStyle(.white)
                            .clipShape(.buttonBorder)
                    })
                }
                
                
                
            }
            
        }.frame(width: 250, height: 150, alignment: .center).clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ContactView()
}
