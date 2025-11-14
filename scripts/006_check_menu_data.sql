-- Script para verificar si hay datos en las tablas de menú
-- Ejecuta este script para ver cuántos registros hay en cada tabla

SELECT 'Restaurantes' as tabla, COUNT(*) as total FROM restaurants
UNION ALL
SELECT 'Categorías de Menú' as tabla, COUNT(*) as total FROM menu_categories
UNION ALL
SELECT 'Items de Menú' as tabla, COUNT(*) as total FROM menu_items
UNION ALL
SELECT 'Pedidos' as tabla, COUNT(*) as total FROM orders
UNION ALL
SELECT 'Items de Pedido' as tabla, COUNT(*) as total FROM order_items;

-- Ver detalles de categorías por restaurante
SELECT 
  r.name as restaurante,
  COUNT(mc.id) as num_categorias
FROM restaurants r
LEFT JOIN menu_categories mc ON r.id = mc.restaurant_id
GROUP BY r.id, r.name
ORDER BY r.name;

-- Ver detalles de items por restaurante
SELECT 
  r.name as restaurante,
  COUNT(mi.id) as num_items
FROM restaurants r
LEFT JOIN menu_items mi ON r.id = mi.restaurant_id
GROUP BY r.id, r.name
ORDER BY r.name;
