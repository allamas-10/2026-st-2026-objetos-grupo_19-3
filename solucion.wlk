// Punto 1
class Guerrero{
    const potencialOfensivo
    var experiencia
    var energia
    const energiaOriginal
    var traje

    method atacar(unGuerrero){
        unGuerrero.recibirAtaque(potencialOfensivo)
    }

    method recibirAtaque(potencialAtacante){
        const danio = traje.danioARecibir(potencialAtacante)
        energia = 0.max(energia - danio)
        experiencia += traje.experienciaAOtorgar()

        traje.desgastar()
    }
    
    method comerSemillaDelErmitanio(){
        energia = energiaOriginal
    }

    method estaMuerto(){
        return energia == 0
    }
}

// Punto 2
object configuracionEntrenamiento{
    var property multiplicadorDeExperiencia = 2
}

class TrajeComun inherits Traje{
    const porcentajeDeProteccion

    method danioARecibir(potencialAtacante){

        const danioOriginal = potencialAtacante * 0.10

        if(self.estaGastado()){
            return danioOriginal
        }

        const danioReducido = potencialAtacante * porcentajeDeProteccion
        return danioOriginal - danioReducido
    }

    method experienciaAOtorgar(){
        return 1
    }

}

class TrajeDeEntrenamiento inherits Traje{
    method danioARecibir(potencialAtacante){
        return potencialAtacante * 0.10
    }

    method experienciaAOtorgar(){

        if(self.estaGastado()){
            return 1
        }

        return 1 * configuracionEntrenamiento.multiplicadorDeExperiencia()
    }
}

// Punto 3
class Traje{
    var desgaste = 0

    method desgastar(){
        desgaste = 100.min(desgaste + 5)
    }

    method estaGastado(){
        return desgaste == 100
    }

}

//Punto 4
class Pieza{
    var resistencia
    var desgaste = 0

    method desgastar(){
        desgaste += 5
    }

    method estaGastado(){
        return desgaste >= 20
    }
}

class TrajeModuralizado inherits Traje{
    const piezas = []

    override method desgastar(){
        piezas.forEach({ pieza => pieza.desgastar()})
    }

    override method estaGastado(){
        return piezas.all({ pieza => pieza.estaGastado()})
    }

    method piezasNoGastadas(){
        return piezas.filter({ pieza => !pieza.estaGastado()})
    }

    method danioARecibir(potencialAtacante){
        const danioOriginal = potencialAtacante * 0.10
        const reduccion = self.piezasNoGastadas().sum({ pieza => pieza.resistencia() })
        return danioOriginal - reduccion
    }

    method experienciaAOtorgar(){
        const piezasNoGastadas = self.piezasNoGastadas().size() / piezas.size()
        return 1 + piezasNoGastadas
    }
}