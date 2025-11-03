
;; iPhone16 + Banamex → 24 meses sin intereses
(defrule iphone16-banamex-24msi
  (orden (orden-id ?oid) (part-number ?pnum) (tarjeta-id ?tid))
  (smartphone (part-number ?pnum) (marca apple) (modelo "iPhone16"))
  (tarjeta (tarjeta-id ?tid) (banco banamex) (grupo oro))
  =>
  (assert (oferta (descripcion "iPhone16 con Banamex: 24 meses sin intereses")))
)

;; Note21 + Liverpool VISA → 12 meses sin intereses
(defrule note21-liverpool-12msi
  (orden (orden-id ?oid) (part-number ?pnum) (tarjeta-id ?tid))
  (smartphone (part-number ?pnum) (marca samsung) (modelo "Note21"))
  (tarjeta (tarjeta-id ?tid) (banco liverpool) (grupo visa))
  =>
  (assert (oferta (descripcion "Samsung Note21 con Liverpool VISA: 12 meses sin intereses")))
)

;; MacBookAir + iPhone16 al contado → vales por cada $1000
(defrule combo-macbookair-iphone16-vales
  (orden (orden-id ?oid1) (customer-id ?cid) (part-number ?p1) (pago contado))
  (orden (orden-id ?oid2) (customer-id ?cid) (part-number ?p2) (pago contado))
  (smartphone (part-number ?p1) (marca apple) (modelo "iPhone16"))
  (compu (part-number ?p2) (marca apple) (modelo "MacBookAir"))
  =>
  (bind ?total (+ 27000 30000)) ;; precios fijos
  (bind ?vales (* (div ?total 1000) 100))
  (assert (vale (customer-id ?cid) (monto ?vales)))
)

;; Compra de smartphone → descuento en funda y mica
(defrule accesorios-descuento-smartphone
  (orden (orden-id ?oid) (customer-id ?cid) (part-number ?pnum))
  (smartphone (part-number ?pnum))
  =>
  (assert (descuento (descripcion "15% en funda y mica por compra de smartphone")))
)

;; Mostrar ofertas
(defrule mostrar-ofertas
  ?o <- (oferta (descripcion ?d))
  =>
  (printout t "-> Oferta aplicada: " ?d crlf)
  (retract ?o)
)

;; Mostrar descuentos
(defrule mostrar-descuentos
  ?d <- (descuento (descripcion ?desc))
  =>
  (printout t "-> Descuento aplicado: " ?desc crlf)
  (retract ?d)
)

;; Mostrar vales
(defrule mostrar-vales
  ?v <- (vale (customer-id ?cid) (monto ?m))
  =>
  (printout t "-> Cliente " ?cid " recibe $" ?m " en vales de regalo." crlf)
  (retract ?v)
)

;; Clasificación por cantidad
(defrule clasificar-mayorista
  (orden (orden-id ?oid) (customer-id ?cid) (qty ?q&:(> ?q 10)))
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Cliente mayorista")
                         (reason "Accede a beneficios por volumen de compra.")))
)

(defrule clasificar-menudista
  (orden (orden-id ?oid) (customer-id ?cid) (qty ?q&:(<= ?q 10)))
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Cliente menudista")
                         (reason "Consulta promociones para compras individuales.")))
)

;; Actualizar stock
(defrule actualizar-stock-smartphone
  (orden (part-number ?pnum) (qty ?q))
  ?s <- (smartphone (part-number ?pnum) (marca ?m) (modelo ?mod) (precio ?p))
  =>
  ;; Simulación: no hay slot stock, así que solo imprimimos
  (printout t "-> Stock actualizado para " ?mod ": se descontaron " ?q " unidades." crlf)
)

;; Mostrar recomendaciones
(defrule mostrar-recomendaciones
  ?rec <- (recomendacion (customer-id ?cid) (product-name ?pname) (reason ?razon))
  =>
  (printout t "-> Recomendacion para Cliente " ?cid ": " ?pname crlf)
  (printout t "   Motivo: " ?razon crlf crlf)
  (retract ?rec)
)
;;Recomendacion por tarjeta vencida
(defrule tarjeta-vencida
  (tarjeta (tarjeta-id ?tid) (banco ?banco) (grupo ?grupo) (exp-date ?fecha))
  (test (eq ?fecha "01-12-23"))
  (orden (tarjeta-id ?tid) (customer-id ?cid))
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Actualización de tarjeta")
                         (reason (str-cat "Tu tarjeta " ?banco " " ?grupo " está vencida. Actualízala para seguir disfrutando de promociones."))))
)

;;Recomendacion por cliente inactivo
(defrule cliente-inactivo
  (customer (customer-id ?cid) (name ?name))
  (not (orden (customer-id ?cid)))
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Oferta de bienvenida")
                         (reason (str-cat "Hola " ?name ", tenemos un descuento especial en tu primera compra."))))
)

;;Recomendacion de accesorio si no lo ha comprado
(defrule sugerir-accesorio
  (orden (customer-id ?cid) (part-number ?pnum))
  (smartphone (part-number ?pnum) (modelo ?modelo))
  (not (orden (customer-id ?cid) (part-number 5))) ;; Funda
  (not (orden (customer-id ?cid) (part-number 6))) ;; Mica
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Funda y Mica")
                         (reason (str-cat "Te recomendamos proteger tu " ?modelo " con funda y mica con 15% de descuento."))))
)
;;Recomendacion cruzada por comportamiento de otros clientes
(defrule producto-complementario
  (orden (customer-id ?cid1) (part-number ?p1))
  (orden (customer-id ?cid2&~?cid1) (part-number ?p1))
  (orden (customer-id ?cid2) (part-number ?p2&~?p1))
  (not (orden (customer-id ?cid1) (part-number ?p2)))
  (smartphone (part-number ?p1) (modelo ?m1))
  (accesorio (part-number ?p2) (nombre ?a2))
  =>
  (assert (recomendacion (customer-id ?cid1)
                         (product-name ?a2)
                         (reason (str-cat "Otros clientes que compraron " ?m1 " tambien adquirieron " ?a2 "."))))
)

;;Oferta por MacBookPro con BBVA
(defrule macbookpro-bbva-oferta
  (orden (orden-id ?oid) (part-number ?pnum) (tarjeta-id ?tid))
  (compu (part-number ?pnum) (modelo "MacBookPro"))
  (tarjeta (tarjeta-id ?tid) (banco bbva))
  =>
  (assert (oferta (descripcion "MacBookPro con BBVA: 18 meses sin intereses")))
)

;;Descuento por combo de accesorios
(defrule combo-accesorios-descuento
  (orden (customer-id ?cid) (part-number 5))
  (orden (customer-id ?cid) (part-number 6))
  =>
  (assert (descuento (descripcion "10% adicional por comprar funda y mica juntos")))
)

;;Recomendacion por compra frecuente
(defrule cliente-frecuente
  (customer (customer-id ?cid))
  (test (>= (length$ (find-all-facts ((?o orden)) (eq ?o:customer-id ?cid))) 3))
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Cliente frecuente")
                         (reason "Gracias por tu lealtad. Revisa nuestras promociones exclusivas.")))
)

;;Oferta por pagar con tarjeta Liverpool en cualquier producto Apple
(defrule apple-liverpool-oferta
  (orden (orden-id ?oid) (part-number ?pnum) (tarjeta-id ?tid))
  (tarjeta (tarjeta-id ?tid) (banco liverpool))
  (or (smartphone (part-number ?pnum) (marca apple))
      (compu (part-number ?pnum) (marca apple)))
  =>
  (assert (oferta (descripcion "Producto Apple con Liverpool: 10% de descuento adicional")))
)

;;Recomendacion por no usar tarjeta en compra
(defrule sin-tarjeta-recomendar
  (orden (orden-id ?oid) (customer-id ?cid) (tarjeta-id ?tid&:(eq ?tid 0)))
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Tarjeta recomendada")
                         (reason "Obtén beneficios adicionales pagando con tarjeta de credito participante.")))
)