class Actividad {

  const property idiomas=#{}

  method aniadirIdioma(unIdioma){idiomas.add(unIdioma)}
  method sacarIdioma(unIdioma){idiomas.remove(unIdioma)}
  method implicaEsfuerzo()
  method sirveParaBroncearse()
  method cuantosDiasLleva()

  method esInteresante(){return idiomas.size() > 1}
  method esRecomendada(unSocio){return (self.esInteresante() && unSocio.leAtrae(self) && !unSocio.actividades().find({a=> self}))}
}

class ViajeDePlaya inherits Actividad{

  var property largoDeLaPlaya = 0 

  override method implicaEsfuerzo() = largoDeLaPlaya > 1200
  override method sirveParaBroncearse() = true
  override method cuantosDiasLleva() = largoDeLaPlaya / 500
}

class ExcursionACiudad inherits Actividad{

  var property atracciones = 0

  override method implicaEsfuerzo() = atracciones.between(5, 8)
  override method sirveParaBroncearse() = false
  override method cuantosDiasLleva() = atracciones / 2

  override method esInteresante(){return (super() || atracciones == 5)}
}

class ExcursionACiudadTropical inherits ExcursionACiudad{

  override method cuantosDiasLleva() = super() + 1
  override method sirveParaBroncearse() = true
}

class SalidaDeTrekking inherits Actividad{

  var property kilometrosDeSendero = 0
  var property diasDeSolPorAnio = 0 

  override method implicaEsfuerzo() = kilometrosDeSendero > 80
  override method sirveParaBroncearse() = ((diasDeSolPorAnio > 200) || (diasDeSolPorAnio.between(100, 200) && kilometrosDeSendero > 120))
  override method cuantosDiasLleva() = kilometrosDeSendero / 50

  override method esInteresante(){return (super() && diasDeSolPorAnio > 140)}
}

class ClaseDeGimnasia inherits Actividad{

    method initialize() {
    idiomas.clear()
    idiomas.add("español")
  }
  method validador() {
    if(!idiomas==#{"español"}) {
      self.error("el unico idioma disponible es español")
    }
  }
  override method idiomas() = #{"español"} //copiado del profe :>

  override method implicaEsfuerzo() = true
  override method cuantosDiasLleva() = 1
  override method sirveParaBroncearse() = false

  override method esRecomendada(unSocio){return unSocio.edad().between(20, 30)}
}

class Socio{

  const actividades =#{}
  const limiteDeActividades = 0
  const property idiomas =#{}
  var property edad = 0

  method leAtrae(unaAtraccion)

  method registrarActividad(unaActividad){if (actividades.size() < limiteDeActividades)
      {
        actividades.add(unaActividad)
        }
      else{
        self.error("Se ha alcanzado el limite de actividades para este socio.")
      }
  }
  
  method esAdoradorDelSol() = actividades.all({a=> a.sirveParaBroncearse()})
  method actividadesEsforzadas() = actividades.filter({a=> a.implicaEsfuerzo()})
}

class SocioTranquilo inherits Socio{

  override method leAtrae(unaAtraccion){return unaAtraccion.cuantosDiasLleva() >= 4}
}

class SocioCoherente inherits Socio{

  override method leAtrae(unaAtraccion){
    if(self.esAdoradorDelSol()){
      return unaAtraccion.sirveParaBroncearse()
    }
    else{
      return unaAtraccion.implicaEsfuerzo()
    }
  }
}

class SocioRelajado inherits Socio{

  override method leAtrae(unaAtraccion){
    return idiomas.intersection(unaAtraccion.idiomas()).size() > 0
  }
}

class TallerLiterario inherits Actividad{
  const libros =#{}

  method aniadirLibro(unLibro){libros.add(unLibro)}
  override method idiomas() = libros.addAll({l=> l.idiomas()}) //checkear xd
  override method implicaEsfuerzo(){return ((libros.any({l=> l.hojas() > 500})) || ((libros.map({l => l.nombreDelAutor()}).asSet().size() == 1) && (libros.size() > 1)))} // anda a saber si esta bien xD
  override method sirveParaBroncearse() = false
  override method cuantosDiasLleva(){return libros.size() + 1}
  override method esRecomendada(unSocio){return unSocio.idiomas().size() > 1}
}

class Libro{
  const property idiomas =#{}
  const property hojas = 0
  const property autor =#{}

  method autor() = autor

}
