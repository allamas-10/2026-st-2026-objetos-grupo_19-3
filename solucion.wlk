// Punto 1
class Guerrero{
    const potencialOfensivo
    var experiencia
    const energiaOriginal
    var property energia = energiaOriginal
    var property traje

    method potencialOfensivo(){
        return potencialOfensivo
    }

    method atacar(unGuerrero){

        if(self.estaMuerto()){
            throw new DomainException(message = "El guerrero está muerto y no puede atacar")
        }

        if(unGuerrero.estaMuerto()){
            throw new DomainException(message = "El guerrero atacado está muerto y no puede ser atacado")
        }

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

    method cantidadDePiezas(){
        return traje.cantidadDePiezas()
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

    method cantidadDePiezas(){
        return 1
    }

}

//Punto 4
class Pieza{
    const resistencia
    var desgaste = 0

    method desgastar(){
        desgaste += 5
    }

    method estaGastado(){
        return desgaste >= 20
    }

    method resistencia(){
        return resistencia
    }
}

class TrajeModularizado inherits Traje{
    const piezas = #{}

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

    override method cantidadDePiezas(){
        return piezas.size()
    }
}

//Punto 6

class Torneo{
    const modalidad

    method seleccionarJugadores(candidatos){
        return modalidad.seleccionar(candidatos)
    }
}

object powerIsBest{
    method seleccionar(candidatos){
        return candidatos.sortedBy({a, b => a.potencialOfensivo() > b.potencialOfensivo()}).take(16)
    }
}

object funny{
    method seleccionar(candidatos){
        return candidatos.sortedBy({a, b => a.cantidadDePiezas() > b.cantidadDePiezas()}).take(16)
    }
}

object surprise{
    method seleccionar(candidatos){
        return candidatos.randomized().take(16)
    }
}