(defrule mover-mono
   (estado (mono-posicion ?pos1) (banana-obtenida FALSE))
   =>
   (retract 1)
   (assert (estado
      (mono-posicion centro)
      (caja-posicion ventana)
      (banana-posicion centro)
      (mono-sobre-caja FALSE)
      (banana-obtenida FALSE))))

(defrule empujar-caja
   (estado (mono-posicion centro) (caja-posicion ventana) (banana-obtenida FALSE))
   =>
   (retract 1)
   (assert (estado
      (mono-posicion centro)
      (caja-posicion centro)
      (banana-posicion centro)
      (mono-sobre-caja FALSE)
      (banana-obtenida FALSE))))

(defrule subir-caja
   (estado (mono-posicion centro) (caja-posicion centro) (mono-sobre-caja FALSE) (banana-obtenida FALSE))
   =>
   (retract 1)
   (assert (estado
      (mono-posicion caja)
      (caja-posicion centro)
      (banana-posicion centro)
      (mono-sobre-caja TRUE)
      (banana-obtenida FALSE))))

(defrule agarrar-banana
   (estado (mono-posicion caja) (caja-posicion centro) (banana-posicion centro) (mono-sobre-caja TRUE) (banana-obtenida FALSE))
   =>
   (retract 1)
   (assert (estado
      (mono-posicion caja)
      (caja-posicion centro)
      (banana-posicion centro)
      (mono-sobre-caja TRUE)
      (banana-obtenida TRUE)))
   (printout t "El mono ha conseguido la banana!" crlf))