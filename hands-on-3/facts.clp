;; --- Hechos iniciales del sistema recomendador ---

(deffacts base-de-conocimiento

  ;; Clientes
  (customer (customer-id 101) (name "Ana") (tipo menudista))
  (customer (customer-id 102) (name "Beto") (tipo mayorista))
  (customer (customer-id 103) (name "Carlos") (tipo menudista))
  (customer (customer-id 104) (name "Diana") (tipo mayorista)) 
  (customer (customer-id 105) (name "Elena") (tipo menudista)) 

  ;; Smartphones
  (smartphone (part-number 1) (marca apple) (modelo "iPhone16") (precio 27000))
  (smartphone (part-number 2) (marca samsung) (modelo "Note21") (precio 22000))

  ;; Computadoras
  (compu (part-number 3) (marca apple) (modelo "MacBookAir") (precio 30000))
  (compu (part-number 4) (marca apple) (modelo "MacBookPro") (precio 47000))

  ;; Accesorios
  (accesorio (part-number 5) (nombre "Funda") (tipo funda) (precio 500))
  (accesorio (part-number 6) (nombre "Mica") (tipo mica) (precio 200))
  (accesorio (part-number 7) (nombre "Mouse Bluetooth") (tipo mouse) (precio 800))

  ;; Tarjetas de crédito
  (tarjeta (tarjeta-id 201) (banco banamex) (grupo oro) (exp-date "01-12-26"))
  (tarjeta (tarjeta-id 202) (banco liverpool) (grupo visa) (exp-date "01-10-25"))
  (tarjeta (tarjeta-id 203) (banco bbva) (grupo visa) (exp-date "01-12-23"))

  ;; Ordenes de compra
  (orden (orden-id 1001) (customer-id 101) (part-number 1) (tarjeta-id 201) (qty 1) (pago credito)) 
  (orden (orden-id 1002) (customer-id 102) (part-number 2) (tarjeta-id 202) (qty 5) (pago credito)) 
  (orden (orden-id 1003) (customer-id 102) (part-number 3) (tarjeta-id 201) (qty 5) (pago contado)) 
  (orden (orden-id 1004) (customer-id 103) (part-number 1) (tarjeta-id 203) (qty 1) (pago contado)) 
  (orden (orden-id 1005) (customer-id 103) (part-number 5) (tarjeta-id 203) (qty 1) (pago contado)) 

  ;; Vales 
  (vale (customer-id 102) (monto 5700)) ;; 
)