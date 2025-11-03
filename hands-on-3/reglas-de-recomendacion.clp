(defrule recomendar-a-cliente-inactivo
  (declare (salience 10))
  (customer (customer-id ?cid) (name ?cname))
  (not (order (customer-id ?cid)))
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Oferta de Bienvenida")
                         (reason (str-cat "Hola " ?cname ", tenemos un descuento especial en tu primera compra."))))
)

(defrule recomendar-producto-complementario
  (declare (salience 10))
  (order (customer-id ?cid1) (part-number ?pnum1))
  (product (part-number ?pnum1) (name ?pname1))
  (order (customer-id ?cid2&~?cid1) (part-number ?pnum1))
  (order (customer-id ?cid2) (part-number ?pnum2&~?pnum1))
  (product (part-number ?pnum2) (name ?pname2))
  (not (order (customer-id ?cid1) (part-number ?pnum2)))
  =>
  (assert (recomendacion (customer-id ?cid1)
                         (product-name ?pname2)
                         (reason (str-cat "Quienes compraron " ?pname1 " también se interesaron por " ?pname2 "."))))
)

(defrule recomendar-accesorio-smartphone
  (order (customer-id ?cid) (part-number ?pnum))
  (product (part-number ?pnum) (category smartphone) (name ?pname))
  (not (order (customer-id ?cid) (part-number 12))) ;; Funda
  (not (order (customer-id ?cid) (part-number 13))) ;; Mica
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Funda y Mica")
                         (reason (str-cat "Te recomendamos proteger tu " ?pname " con funda y mica con 15% de descuento."))))
)

(defrule recomendar-beneficio-mayorista
  (customer (customer-id ?cid) (tipo mayorista))
  (order (customer-id ?cid))
  =>
  (assert (recomendacion (customer-id ?cid)
                         (product-name "Descuento por volumen")
                         (reason "Como cliente mayorista, puedes acceder a precios especiales por compras grandes.")))
)

(defrule mostrar-recomendaciones
  (declare (salience -10))
  ?rec <- (recomendacion (customer-id ?cid) (product-name ?pname) (reason ?razon))
  =>
  (printout t "-> Recomendacion para Cliente " ?cid ": " ?pname crlf)
  (printout t "   Motivo: " ?razon crlf crlf)
  (retract ?rec)
)
