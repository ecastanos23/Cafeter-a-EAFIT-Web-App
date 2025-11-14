-- Script para verificar que los datos se insertaron correctamente

-- Verificar restaurantes
SELECT 'Restaurantes:' as tabla, COUNT(*) as total FROM restaurants;
SELECT id, name, slug, is_open FROM restaurants ORDER BY name;

-- Verificar categorías de menú
SELECT 'Categorías de Menú:' as tabla, COUNT(*) as total FROM menu_categories;
SELECT mc.id, r.name as restaurant, mc.name as category, mc.display_order 
FROM menu_categories mc
JOIN restaurants r ON r.id = mc.restaurant_id
ORDER BY r.name, mc.display_order;

-- Verificar items del menú
SELECT 'Items del Menú:' as tabla, COUNT(*) as total FROM menu_items;
SELECT mi.name, r.name as restaurant, mc.name as category, mi.price_cents, mi.is_available
FROM menu_items mi
JOIN restaurants r ON r.id = mi.restaurant_id
JOIN menu_categories mc ON mc.id = mi.category_id
ORDER BY r.name, mc.display_order, mi.name
LIMIT 20;
