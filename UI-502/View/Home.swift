//
//  Home.swift
//  UI-502
//
//  Created by nyannyan0328 on 2022/03/11.
//

import SwiftUI

struct Home: View {
    
    @State var posts : [Post] = []
    @State var currentImage : String = ""
    @State var fullPreView : Bool = false
    var body: some View {
        
        
        TabView(selection: $currentImage) {
            
            
            ForEach(posts){post in
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(1)
                
                }
                .id(post.id)
                
                .ignoresSafeArea()//
            }
          
        }
        .ignoresSafeArea()//
        .background(.black)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onTapGesture {
            
            withAnimation(.easeInOut){fullPreView.toggle()}
        }
        .overlay(alignment: .top, content: {
            
            HStack{
                
                Text("Scenarion Picks")
                    .font(.title)
                 
                
                Spacer()
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "folder.fill")
                        .font(.system(size: 20, weight: .black))
                    
                    
                }

                
            }
            .padding()
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
            .offset(y: fullPreView ? -200 : 0)
            
            
        })
        
        .overlay(alignment: .bottom, content: {
            
            ScrollViewReader{proxy in
            
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    
                    HStack(spacing:15){
                        
                        
                        ForEach(posts){post in
                            
                            Image(post.postImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .cornerRadius(2)
                                .padding(5)
                                .background(
                                
                                
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .strokeBorder(.white)
                                        .opacity(currentImage == post.id ? 1 : 0)
                                        
                                
                                )
                                .id(post.id)
                                .onTapGesture {
                                    
                                    currentImage = post.id
                                }
                                
                                
                        }
                    }
                    .padding()
                    
                }
                .frame(height:100)
                .background(.ultraThinMaterial)
                .onChange(of: currentImage, perform: { _ in
                    
                    
                    withAnimation{
                        
                        
                        proxy.scrollTo(currentImage, anchor: .bottom)
                    }
                    
                    
                    
                    
                })
                .offset(y:fullPreView ? 200 : 0)
                
            
            }
            
            
        })
        
        .onAppear {
           
            
            for index in 1...12{
                
                posts.append(Post(postImage: "p\(index)"))
                
                
            }
            
            currentImage = posts.first?.id ?? ""
        }
        
        
        
     
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
