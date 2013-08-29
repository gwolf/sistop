#!/usr/bin/python
# -*- coding: utf-8 -*-

# Declaramos una variable tipo lista que contendrá el listado de recursos del equipo
recursos = ["disco", "cinta magnética", "impresora", "disco duro", "puerto RS232", "puerto COM1", "puerto COM2"]

# También una variable que contendrá el listado de asignaciones
# Formato proceso:(lista de recursos)
asignaciones = {1532:(0,), 1533:(1,2,), 1534:(3,)}

# Y finalmente una para las peticiones de los procesos
# Formato recurso:(lista de procesos)
peticiones = {4:(1532,1533,), 5:(1531,), 0:(1533,), 1:(1532,)}

# OJO
# en la linea superior está el bloqueo "0:(1533,), 1:(1532,)"

# Definimos un par de funciones que serán recursivas entre sí, es decir, se invocarán una a la otra con la finalidad
# de analizar todo el listado de procesos y buscar un posible bloqueo. El llamado de una a otra finalizará cuando no encuentre 
# ninguna anomalía

""" Función que revisa a través de recursión la convergencia de un proceso consigo mismo """

def revisa_asignaciones (it, proceso_inicial, proceso_revision):
    if proceso_inicial == proceso_revision : return True
    proceso_estudio = proceso_inicial if proceso_revision == None else proceso_revision
    if not asignaciones.has_key(proceso_estudio) : return False
    for recurso in asignaciones[proceso_estudio] :
        print "\t"*it, "El proceso ", proceso_estudio, " posee el recurso: ", recurso
        if revisa_peticiones (it+1, proceso_inicial, recurso) : return True
    return False

""" Función que revisa los procesos que solicitaron un cierto recurso """

def revisa_peticiones (it, proceso_inicial, recurso_revision):
    if not peticiones.has_key(recurso_revision) : return False
    for proceso in peticiones[recurso_revision] :
        print "\t"*it, "El recurso ", recurso_revision, " ha sido solicitado por el proceso", proceso
        if revisa_asignaciones (it+1, proceso_inicial, proceso) : return True
    return False

""" Función que agrega una asignación """

def agregar_asignacion ():
    pid = int(raw_input("Introduzca el PID: "))
    ix = 0
    print "\nSeleccione el recurso que desea asignar "
    for recurso in recursos :
        print str(ix) + ". ", recurso
        ix += 1
        
    recurso = int(raw_input("\nSu opción: "))
        
    if (peticiones.has_key(recurso)) :
        if pid in peticiones[recurso] :
            peticiones[recurso] = list(peticiones[recurso]).remove(pid)
    

""" Función que agrega una solicitud """

def agregar_peticion ():
    pass


while (True) :
    #opcion = int(raw_input("Selecciona una opción:\n1. Adquirir recurso\n2. Solicitar recurso\n3. Salir\n\nSu opción: "))
    
    #if opcion == 1 :
    #    agregar_asignacion()
    #if opcion == 2 :
    #    agregar_peticion()
    #if opcion == 3 :
    #    print "Gracias, regrese pronto"
    #    quit ()
    
    bloqueo = False
    
    for proceso in asignaciones.keys() :
        print "Revisando al proceso con PID ", proceso
        if revisa_asignaciones (0, proceso, None) :
            bloqueo = True
            print "\n\nEs un hecho, sí hay bloqueo, #FAIL"
            quit ()
        
    if not bloqueo :
        print "\n\nExcelente, no hay bloqueos"
        
    quit ()
        
# Fin del programa


# Evaluación
#
# Muy bien. El programa tiene bastante lógica nunca empleada (desde la
# declaración del nombre de los recursos hasta funciones como
# agregar_asignacion() y agregar_peticion() ), pero lo comprendo por
# lo que discutimos en clase. Pero el proceso, tal como lo presentas,
# funciona correctamente y está suficientemente documentado para
# comprender la lógica.
#
# Podría estar más "limpio", siendo el punto que más se argumenta a
# favor de Python; se ve que te gusta mucho hacer
# asignaciones/evaluaciones condicionales en línea. Es un recurso que
# también yo uso mucho, pero disminuye la legibilidad del código.
