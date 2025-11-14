-- Script completo para insertar menús de todos los restaurantes
-- Este script es idempotente (se puede ejecutar múltiples veces sin errores)

-- Primero, verificar qué restaurantes tenemos
DO $$
BEGIN
  RAISE NOTICE 'Restaurantes en la base de datos:';
END $$;

SELECT name, slug FROM restaurants ORDER BY name;

-- ============================================
-- NIKKEI - Comida Nikkei/Japonesa-Peruana
-- ============================================

-- Categorías
INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT 
  gen_random_uuid(),
  r.id,
  'Bebidas',
  1
FROM restaurants r WHERE r.slug = 'nikkei'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT 
  gen_random_uuid(),
  r.id,
  'Platos Principales',
  2
FROM restaurants r WHERE r.slug = 'nikkei'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT 
  gen_random_uuid(),
  r.id,
  'Postres',
  3
FROM restaurants r WHERE r.slug = 'nikkei'
ON CONFLICT DO NOTHING;

-- Items de menú
INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  gen_random_uuid(),
  r.id,
  c.id,
  'Ceviche Clásico',
  'Pescado fresco marinado en limón con cebolla morada y cilantro',
  2500000,
  '/placeholder.svg?height=200&width=200',
  false,
  15,
  ARRAY['pescado', 'sin gluten']::TEXT[]
FROM restaurants r
JOIN menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'nikkei' AND c.name = 'Platos Principales'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  gen_random_uuid(),
  r.id,
  c.id,
  'Tiradito de Salmón',
  'Salmón en finas láminas con salsa de ají amarillo',
  2800000,
  '/placeholder.svg?height=200&width=200',
  false,
  12,
  ARRAY['pescado']::TEXT[]
FROM restaurants r
JOIN menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'nikkei' AND c.name = 'Platos Principales'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  gen_random_uuid(),
  r.id,
  c.id,
  'Limonada Natural',
  'Limonada fresca hecha al momento',
  500000,
  '/placeholder.svg?height=200&width=200',
  true,
  3,
  ARRAY['vegano', 'sin gluten']::TEXT[]
FROM restaurants r
JOIN menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'nikkei' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  gen_random_uuid(),
  r.id,
  c.id,
  'Té Verde',
  'Té verde japonés caliente',
  400000,
  '/placeholder.svg?height=200&width=200',
  true,
  2,
  ARRAY['vegano', 'sin gluten']::TEXT[]
FROM restaurants r
JOIN menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'nikkei' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

-- ============================================
-- HOOD - Hamburguesas gourmet
-- ============================================

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'hood'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Hamburguesas', 2 FROM restaurants r WHERE r.slug = 'hood'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Acompañamientos', 3 FROM restaurants r WHERE r.slug = 'hood'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Hamburguesa Clásica', 'Carne de res, lechuga, tomate, cebolla y salsas', 1800000, '/placeholder.svg?height=200&width=200', false, 12, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'hood' AND c.name = 'Hamburguesas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Hamburguesa BBQ', 'Carne, queso cheddar, tocino y salsa BBQ', 2200000, '/placeholder.svg?height=200&width=200', false, 15, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'hood' AND c.name = 'Hamburguesas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Coca Cola', 'Gaseosa 350ml', 400000, '/placeholder.svg?height=200&width=200', true, 2, ARRAY['vegano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'hood' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Papas Fritas', 'Papas crujientes con sal', 800000, '/placeholder.svg?height=200&width=200', false, 8, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'hood' AND c.name = 'Acompañamientos'
ON CONFLICT DO NOTHING;

-- ============================================
-- BIGOS - Comida internacional
-- ============================================

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'bigos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Platos del Día', 2 FROM restaurants r WHERE r.slug = 'bigos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Ensaladas', 3 FROM restaurants r WHERE r.slug = 'bigos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Bandeja Paisa', 'Plato típico colombiano completo', 2000000, '/placeholder.svg?height=200&width=200', false, 20, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'bigos' AND c.name = 'Platos del Día'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Ensalada César', 'Lechuga, pollo, crutones y aderezo césar', 1500000, '/placeholder.svg?height=200&width=200', false, 10, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'bigos' AND c.name = 'Ensaladas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Jugo Natural', 'Jugo de frutas frescas', 600000, '/placeholder.svg?height=200&width=200', true, 5, ARRAY['vegano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'bigos' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

-- ============================================
-- FRISBY - Pollo frito
-- ============================================

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'frisby'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Pollo', 2 FROM restaurants r WHERE r.slug = 'frisby'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Combos', 3 FROM restaurants r WHERE r.slug = 'frisby'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Pollo Broaster 4 Piezas', 'Pollo frito crujiente', 1600000, '/placeholder.svg?height=200&width=200', false, 15, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'frisby' AND c.name = 'Pollo'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Combo Personal', 'Pollo, papas y gaseosa', 1800000, '/placeholder.svg?height=200&width=200', false, 12, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'frisby' AND c.name = 'Combos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Gaseosa', 'Gaseosa 400ml', 400000, '/placeholder.svg?height=200&width=200', true, 2, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'frisby' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

-- ============================================
-- CORRAL - Hamburguesas colombianas
-- ============================================

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'corral'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Hamburguesas', 2 FROM restaurants r WHERE r.slug = 'corral'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Papas', 3 FROM restaurants r WHERE r.slug = 'corral'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Corralita', 'Hamburguesa clásica del Corral', 1500000, '/placeholder.svg?height=200&width=200', false, 10, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'corral' AND c.name = 'Hamburguesas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Todoterreno', 'Hamburguesa con doble carne y queso', 2000000, '/placeholder.svg?height=200&width=200', false, 12, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'corral' AND c.name = 'Hamburguesas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Papas a la Francesa', 'Papas fritas clásicas', 700000, '/placeholder.svg?height=200&width=200', false, 8, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'corral' AND c.name = 'Papas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Limonada de Coco', 'Bebida refrescante', 600000, '/placeholder.svg?height=200&width=200', true, 3, ARRAY['vegano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'corral' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

-- ============================================
-- TACO FACTORY - Comida mexicana
-- ============================================

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'taco-factory'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Tacos', 2 FROM restaurants r WHERE r.slug = 'taco-factory'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Burritos', 3 FROM restaurants r WHERE r.slug = 'taco-factory'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Tacos de Carne', '3 tacos con carne asada', 1400000, '/placeholder.svg?height=200&width=200', false, 10, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'taco-factory' AND c.name = 'Tacos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Burrito de Pollo', 'Burrito grande con pollo y frijoles', 1600000, '/placeholder.svg?height=200&width=200', false, 12, ARRAY[]::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'taco-factory' AND c.name = 'Burritos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Agua de Horchata', 'Bebida tradicional mexicana', 500000, '/placeholder.svg?height=200&width=200', true, 3, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'taco-factory' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

-- ============================================
-- MI BUÑUELO - Postres colombianos
-- ============================================

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'mi-bunuelo'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Buñuelos', 2 FROM restaurants r WHERE r.slug = 'mi-bunuelo'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Postres', 3 FROM restaurants r WHERE r.slug = 'mi-bunuelo'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Buñuelo Tradicional', 'Buñuelo colombiano recién hecho', 300000, '/placeholder.svg?height=200&width=200', false, 5, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'mi-bunuelo' AND c.name = 'Buñuelos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Natilla', 'Natilla colombiana tradicional', 400000, '/placeholder.svg?height=200&width=200', false, 3, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'mi-bunuelo' AND c.name = 'Postres'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Chocolate Caliente', 'Chocolate colombiano con queso', 600000, '/placeholder.svg?height=200&width=200', true, 5, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'mi-bunuelo' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

-- ============================================
-- DUNKIN DONUTS - Donas y café
-- ============================================

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'dunkin-donuts'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Donas', 2 FROM restaurants r WHERE r.slug = 'dunkin-donuts'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (id, restaurant_id, name, display_order)
SELECT gen_random_uuid(), r.id, 'Café', 3 FROM restaurants r WHERE r.slug = 'dunkin-donuts'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Dona Glaseada', 'Dona clásica con glaseado', 400000, '/placeholder.svg?height=200&width=200', false, 2, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'dunkin-donuts' AND c.name = 'Donas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Dona de Chocolate', 'Dona con cobertura de chocolate', 450000, '/placeholder.svg?height=200&width=200', false, 2, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'dunkin-donuts' AND c.name = 'Donas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Café Americano', 'Café negro americano', 500000, '/placeholder.svg?height=200&width=200', true, 3, ARRAY['vegano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'dunkin-donuts' AND c.name = 'Café'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (id, restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT gen_random_uuid(), r.id, c.id, 'Latte', 'Café con leche espumosa', 600000, '/placeholder.svg?height=200&width=200', true, 4, ARRAY['vegetariano']::TEXT[]
FROM restaurants r JOIN menu_categories c ON c.restaurant_id = r.id WHERE r.slug = 'dunkin-donuts' AND c.name = 'Café'
ON CONFLICT DO NOTHING;

-- Verificar resultados finales
SELECT 
  'Resumen Final' as tipo,
  (SELECT COUNT(*) FROM restaurants) as restaurantes,
  (SELECT COUNT(*) FROM menu_categories) as categorias,
  (SELECT COUNT(*) FROM menu_items) as items;

-- Mostrar conteo por restaurante
SELECT 
  r.name as restaurante,
  COUNT(DISTINCT c.id) as categorias,
  COUNT(DISTINCT mi.id) as items
FROM restaurants r
LEFT JOIN menu_categories c ON c.restaurant_id = r.id
LEFT JOIN menu_items mi ON mi.restaurant_id = r.id
GROUP BY r.name
ORDER BY r.name;
