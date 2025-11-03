(defrule mover-mono
   ?f <- (estado (mono-posicion ?pos1) (banana-obtenida FALSE))
   =>
   (retract ?f)
   (printout t "El mono se mueve al centro del cuarto." crlf)
   (assert (estado
      (mono-posicion centro)
      (caja-posicion ventana)
      (banana-posicion centro)
      (mono-sobre-caja FALSE)
      (banana-obtenida FALSE))))

(defrule empujar-caja
   ?f <- (estado (mono-posicion centro) (caja-posicion ventana) (banana-obtenida FALSE))
   =>
   (retract ?f)
   (printout t "El mono empuja la caja debajo de la banana." crlf)
   (assert (estado
      (mono-posicion centro)
      (caja-posicion centro)
      (banana-posicion centro)
      (mono-sobre-caja FALSE)
      (banana-obtenida FALSE))))

(defrule subir-caja
   ?f <- (estado (mono-posicion centro) (caja-posicion centro) (mono-sobre-caja FALSE) (banana-obtenida FALSE))
   =>
   (retract ?f)
   (printout t "El mono se sube a la caja." crlf)
   (assert (estado
      (mono-posicion caja)
      (caja-posicion centro)
      (banana-posicion centro)
      (mono-sobre-caja TRUE)
      (banana-obtenida FALSE))))

(defrule agarrar-banana
   ?f <- (estado (mono-posicion caja) (caja-posicion centro) (banana-posicion centro) (mono-sobre-caja TRUE) (banana-obtenida FALSE))
   =>
   (retract ?f)
   (printout t "El mono alcanza la banana y la agarra." crlf)
   (assert (estado
      (mono-posicion caja)
      (caja-posicion centro)
      (banana-posicion centro)
      (mono-sobre-caja TRUE)
      (banana-obtenida TRUE)))
   (printout t "El mono ha conseguido la banana!" crlf))