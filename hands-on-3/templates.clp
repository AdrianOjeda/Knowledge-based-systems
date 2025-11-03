
;; Clientes
(deftemplate customer
  (slot customer-id (type INTEGER))
  (slot name (type STRING))
  (slot tipo (type SYMBOL)) ;; menudista o mayorista
)

;; Smartphones
(deftemplate smartphone
  (slot part-number (type INTEGER))
  (slot marca (type SYMBOL))
  (slot modelo (type STRING))
  (slot precio (type INTEGER))
)

;; Computadores
(deftemplate compu
  (slot part-number (type INTEGER))
  (slot marca (type SYMBOL))
  (slot modelo (type STRING))
  (slot precio (type INTEGER))
)

;; Accesorios
(deftemplate accesorio
  (slot part-number (type INTEGER))
  (slot nombre (type STRING))
  (slot tipo (type SYMBOL)) ;; funda, mica, etc.
  (slot precio (type INTEGER))
)

;; Tarjetas de crédito
(deftemplate tarjeta
  (slot tarjeta-id (type INTEGER))
  (slot banco (type SYMBOL))
  (slot grupo (type SYMBOL))
  (slot exp-date (type STRING)) ;; formato: dd-mm-aa
)

;; Orden de compra
(deftemplate orden
  (slot orden-id (type INTEGER))
  (slot customer-id (type INTEGER))
  (slot part-number (type INTEGER)) ;; producto comprado
  (slot tarjeta-id (type INTEGER))  ;; tarjeta usada
  (slot qty (type INTEGER))
  (slot pago (type SYMBOL)) ;; contado o credito
)

;; Vales
(deftemplate vale
  (slot customer-id (type INTEGER))
  (slot monto (type INTEGER))
)

;; Recomendaciones
(deftemplate recomendacion
  (slot customer-id (type INTEGER))
  (slot product-name (type STRING))
  (slot reason (type STRING))
)

;; Ofertas
(deftemplate oferta
  (slot descripcion (type STRING))
)

;; Descuentos
(deftemplate descuento
  (slot descripcion (type STRING))
)