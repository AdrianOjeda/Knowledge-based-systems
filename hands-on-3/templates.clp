(deftemplate customer
  (slot customer-id (type INTEGER))
  (slot name (type STRING))
  (slot tipo (type SYMBOL)) ;; menudista o mayorista
)

(deftemplate product
  (slot part-number (type INTEGER))
  (slot name (type STRING))
  (slot category (type SYMBOL)) ;; smartphone, compu, accesorio
)

(deftemplate order
  (slot customer-id (type INTEGER))
  (slot part-number (type INTEGER))
)

(deftemplate recomendacion
  (slot customer-id (type INTEGER))
  (slot product-name (type STRING))
  (slot reason (type STRING))
)
