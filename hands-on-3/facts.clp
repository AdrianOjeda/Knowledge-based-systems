(deffacts clientes-y-productos
  ;; Clientes
  (customer (customer-id 201) (name "Adrian") (tipo mayorista))
  (customer (customer-id 202) (name "Brenda") (tipo menudista))
  (customer (customer-id 203) (name "Carlos") (tipo menudista))
  (customer (customer-id 204) (name "Diana") (tipo mayorista)) ;; inactiva
  (customer (customer-id 205) (name "Elena") (tipo menudista)) ;; inactiva

  ;; Productos
  (product (part-number 10) (name "iPhone16") (category smartphone))
  (product (part-number 11) (name "MacBookAir") (category compu))
  (product (part-number 12) (name "Funda") (category accesorio))
  (product (part-number 13) (name "Mica") (category accesorio))
  (product (part-number 14) (name "Note21") (category smartphone))
)

(deffacts historial-de-compras
  ;; Órdenes existentes
  (order (customer-id 201) (part-number 10)) ;; Adrian compró iPhone16
  (order (customer-id 201) (part-number 11)) ;; Adrian compró MacBookAir
  (order (customer-id 202) (part-number 14)) ;; Brenda compró Note21
  (order (customer-id 203) (part-number 10)) ;; Carlos compró iPhone16
  (order (customer-id 203) (part-number 12)) ;; Carlos compró Funda
)
