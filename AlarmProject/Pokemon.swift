
import SwiftUI
struct pokemonModel: Identifiable {
    var id: String
    
}
struct Pokemon: View {
    @State var pokemonList = [
        pokemonModel(id: "12:30"),
        
        
    ]
    @State var item:Int = 0
    var body: some View {
        
        NavigationView {


            List(pokemonList) { pokemon in
                VStack{
                    
                    if item != 0{
                        Text(pokemon.id)
                    }
                    
                    
                }
                
                
                
            }
            //.listStyle(PlainListStyle())
            //.navigationBarTitle("포켓몬")
            .navigationBarItems(trailing:
                                Button("추가") {
                                    addPokemon()
                                    self.item += 1
                                                }
            )
            
        
        }
        
    }
    func addPokemon() {
        if let randomPokemon = pokemonList.randomElement() {
            //let newid = pokemonList.count
            //randomPokemon.id = newid
            pokemonList.remove(at:0)
            pokemonList.append(randomPokemon)
            //pokemonList.append(randomPokemon)
            //Text(pokemon.id)

        }

    }
    
}
struct Pokemon_Previews: PreviewProvider {
    static var previews: some View {
        Pokemon()
        
    }
    
}


