(clear)

(load "templates.clp")
(load "facts.clp")
(load "reglas-de-recomendacion.clp")

(reset)

(printout t crlf "--- Ejecutando Sistema Recomendador de Tecnologia ---" crlf crlf)

(assert (smartphone (part-number 1) (marca apple) (modelo "iphone16") (precio 27000)))
(assert (customer (customer-id 101) (name "Ana") (tipo menudista)))
(assert (tarjeta (tarjeta-id 201) (banco banamex) (grupo oro) (exp-date "01-12-26")))
(assert (orden (orden-id 3001) (customer-id 101) (part-number 1) (tarjeta-id 201) (qty 30) (pago contado)))
(assert (customer (customer-id 104) (name "Diana") (tipo mayorista)))
(assert (orden (orden-id 3002) (customer-id 104) (part-number 4) (tarjeta-id 203) (qty 1) (pago credito)))
(assert (customer (customer-id 105) (name "Elena") (tipo menudista)))
(assert (customer (customer-id 106) (name "Luis") (tipo menudista)))
(assert (orden (orden-id 3003) (customer-id 106) (part-number 1) (tarjeta-id 202) (qty 1) (pago contado)))
(assert (customer (customer-id 107) (name "Carlos") (tipo menudista)))
(assert (orden (orden-id 3004) (customer-id 107) (part-number 1) (tarjeta-id 202) (qty 1) (pago contado)))
(assert (orden (orden-id 3005) (customer-id 108) (part-number 1) (tarjeta-id 202) (qty 1) (pago contado)))
(assert (orden (orden-id 3006) (customer-id 108) (part-number 5) (tarjeta-id 202) (qty 1) (pago contado)))
(assert (orden (orden-id 3007) (customer-id 107) (part-number 5) (tarjeta-id 202) (qty 1) (pago contado)))
(assert (orden (orden-id 3008) (customer-id 107) (part-number 6) (tarjeta-id 202) (qty 1) (pago contado)))
(assert (orden (orden-id 3009) (customer-id 105) (part-number 1) (tarjeta-id 202) (qty 1) (pago credito)))
(assert (orden (orden-id 3010) (customer-id 106) (part-number 2) (tarjeta-id 0) (qty 1) (pago contado)))


(run)

(printout t "--- Fin de la ejecución ---" crlf)
