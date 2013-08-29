n=0
proceso = []
nombreP = []

def clscr():
   import os
   os.system('cls')

   
class Nodo(object):
   def __init__(self, nombre, esperaA=[], esperadoPor=[] ):
      self.nombre = nombre
      self.esperaA = esperaA
      self.esperadoPor = esperadoPor
	  
   def __str__(self):
      return str(self.nombre)

   def comprobar(self, nom):
      if self.esperaA == []:
         print("Sin bloqueos")
         return 0
      for i in range(0,len(self.esperaA)):
         if nom == self.esperaA[i].nombre: 
            print("Bloqueo Mutuo:")
            return 1
         else:
            self.esperaA[i].comprobar(nom)
      

def opcion1():
   global n
   global proceso
   esperaA = []
   esperadoPor = []
   nombre = input("\nDame el nombre del nuevo proceso: ") 
   nombreP.append(nombre)
   proceso.append('')
   proceso[n] = Nodo(nombre, esperaA, esperadoPor)
   
   print("\nProceso <",nombre,"> creado\n")   
   if n!=0:
      pedir1()
      pedir2()
	  
   n = n + 1
   
def menu():
   global n
   global proceso
   global nombreP
   opcion=''   
   while opcion !='e':
      clscr()
      print("Elige que quieres hacer")
      print("a) Crear un nuevo proceso")
      print("b) Detectar bloqueos")
      print("c) Estado de todos los procesos")
      print("d) Reiniciar")
      print("e) Salir")
      opcion=input("\nMi opcion es:  ")
   
      if opcion == 'a':
         clscr()
         opcion1()
		 
      if opcion=='b':
         clscr()
         if n==0:
            print("No se ha creado ningun proceso")
            input("")
         else:
            for i in range(0,n):
               try:		 
                  proceso[i].comprobar(proceso[i].nombre)
               except:
                  print('Bloqueo Mutuo')
            input("")				  
      if opcion=='c':
         clscr()
         for i in range(0, n):
            print("\nEl proceso <",proceso[i].nombre,">")
            if len(proceso[i].esperaA)==0: print("No espera a ningun proceso")
            else:
               print("Espera a los procesos: ")
               for j in range(0, len(proceso[i].esperaA)):   
                  print("<",proceso[i].esperaA[j].nombre,">")
            if len(proceso[i].esperadoPor)==0: print("Y no es esperado por ningun proceso")
            else:   
               print("Y es esperado por los procesos:")
               for k in range(0, len(proceso[i].esperadoPor)):
                  print("<",proceso[i].esperadoPor[k].nombre,">")			   
         if n==0: print("No se ha creado ningun proceso todavia")
         input("")
         clscr()		 
      if opcion=='d':
         n=0
         proceso=[]
         nombreP=[]
		 
def pedir1():
      global proceso
      global nombreP
      resp = input("Este proceso espera a otro <s/n>:   ")
      while resp != 'n':
         if resp == 's':
            espera = input("\nA que proceso espera: ")				
            if not espera in nombreP:
               clscr()
               print("Proceso inexistente")
               resp = 's'
            else:
               esperaP = proceso[nombreP.index(espera)]
               proceso[n].esperaA.append(esperaP)
               proceso[nombreP.index(espera)].esperadoPor.append(proceso[n])
               resp = input("\nOtro <s/n>:   ")
      input("")		 

def pedir2():
      global proceso
      global nombreP
      resp = input("Este proceso es esperado por otro <s/n>:   ")
      while resp != 'n':
         if resp == 's':
            #clscr()
            espera = input("\nQue proceso lo espera:")				
            if not espera in nombreP:
               clscr()
               print("Proceso inexistente")
               resp = 's'
            else:
               esperaP = proceso[nombreP.index(espera)]
               proceso[n].esperadoPor.append(esperaP)
               proceso[nombreP.index(espera)].esperaA.append(proceso[n])
               resp = input("\nOtro <s/n>:   ")
      input("")		 

def main():
   menu()
	        
main()


# Evaluación
#
# Tu programa tiene problemas fuertes con el manejo de la entrada, me
# costó bastante trabajo lograr que comprendiera mi entrada. Pego aquí
# una ejecución ejemplo para marcarte un par de comentarios al
# respecto, voy intercalando lineas para explicar lo que te muestro.
#
# $ python bloqueoMutuo1.py 
# sh: 1: cls: not found
#
# ¿Por qué llamar a 'cls' como programa externo? Sólo lo vas a
# encontrar en sistemas derivados de Windows, y como sea, incurre en
# un costo adicional grande por cada ejecución!
#
# Elige que quieres hacer
# a) Crear un nuevo proceso
# b) Detectar bloqueos
# c) Estado de todos los procesos
# d) Reiniciar
# e) Salir
# Mi opcion es: 'a'
#
# Tuve que "picotear" bastante hasta darme cuenta que todas las entradas
# que me pedías tenían que ser expresiones válidas de Python — Todas las
# letras tienen que ir entrecomilladas. Esto es especialmente molesto
# porque sencillamente ponerle "enter" cuando estoy esperando a que el
# programa haga algo muchas veces lo hacía abortar! Estoy consciente de
# que es una de esas cosas raras en Python: Deberías haber usado la
# función "raw_input(prompt)", ya que "input(prompt)" es equivalente a
# "eval(raw_input(prompt))".
#
# sh: 1: cls: not found
# Dame el nombre del nuevo proceso: 1
# ('\nProceso <', 1, '> creado\n')
#
# A diferencia de C, en Python puedes concatenar cadenas con el operador
# +. Puedes escribir «print "Mi nombre es " + nombre + "\n".
#
# sh: 1: cls: not found
# Elige que quieres hacer
# a) Crear un nuevo proceso
# b) Detectar bloqueos
# c) Estado de todos los procesos
# d) Reiniciar
# e) Salir
#
# Mi opcion es: 'a'
# sh: 1: cls: not found
#
# Dame el nombre del nuevo proceso: 2
# ('\nProceso <', 2, '> creado\n')
# Este proceso espera a otro <s/n>: 's'
#
# ...Y aquí tenemos por fin un problema fuerte :-( Los procesos no
# esperan a otros procesos. Los procesos esperan recursos. Y los
# estados en que pueden estar los recursos no es esperado, sino que
# asignado y solicitado. Vamos, de aquí en más, la ejecución del
# programa es correcta... Pero no resuelve el problema que te planteé,
# sino que uno similar.
#
# A que proceso espera: 1
#
# Otro <s/n>: 'n'
# 0
# Este proceso es esperado por otro <s/n>: 'n'
# 0
# sh: 1: cls: not found
# Elige que quieres hacer
# a) Crear un nuevo proceso
# b) Detectar bloqueos
# c) Estado de todos los procesos
# d) Reiniciar
# e) Salir
#
# Mi opcion es: 'a'
# sh: 1: cls: not found
#
# Dame el nombre del nuevo proceso: 3
# ('\nProceso <', 3, '> creado\n')
# Este proceso espera a otro <s/n>: 's'
#
# A que proceso espera: 2
#
# Otro <s/n>: 'n'
# 0
# Este proceso es esperado por otro <s/n>: 's'
#
# Que proceso lo espera:1
#
# Otro <s/n>: 'n'
# 0
# sh: 1: cls: not found
# Elige que quieres hacer
# a) Crear un nuevo proceso
# b) Detectar bloqueos
# c) Estado de todos los procesos
# d) Reiniciar
# e) Salir
#
# Mi opcion es: 'c'
# sh: 1: cls: not found
# ('\nEl proceso <', 1, '>')
# Espera a los procesos: 
# ('<', 3, '>')
# Y es esperado por los procesos:
# ('<', 2, '>')
# ('\nEl proceso <', 2, '>')
# Espera a los procesos: 
# ('<', 1, '>')
# Y es esperado por los procesos:
# ('<', 3, '>')
# ('\nEl proceso <', 3, '>')
# Espera a los procesos: 
# ('<', 2, '>')
# Y es esperado por los procesos:
# ('<', 1, '>')
# 0
# sh: 1: cls: not found
# sh: 1: cls: not found
# Elige que quieres hacer
# a) Crear un nuevo proceso
# b) Detectar bloqueos
# c) Estado de todos los procesos
# d) Reiniciar
# e) Salir
#
# Mi opcion es: 'b'
# sh: 1: cls: not found
#
# Aquí generé un bloqueo entre los cuatro procesos, siguiendo tu
# lógica, y lo detectó correctamente. ¡Bien! Habría estado
# perfecto... si es que fuera entre procesos y recursos.
#
# Bloqueo Mutuo:
# Bloqueo Mutuo:
# Bloqueo Mutuo:
# '0'
# sh: 1: cls: not found
# Elige que quieres hacer
# a) Crear un nuevo proceso
# b) Detectar bloqueos
# c) Estado de todos los procesos
