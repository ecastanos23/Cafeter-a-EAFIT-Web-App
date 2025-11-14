-- Verificar datos actuales
SELECT 'Restaurantes' as tabla, COUNT(*) as total FROM restaurants
UNION ALL
SELECT 'Categorías', COUNT(*) FROM menu_categories
UNION ALL
SELECT 'Items de menú', COUNT(*) FROM menu_items;

-- Si no hay categorías, insertarlas
INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'nikkei'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Platos Principales', 2 FROM restaurants r WHERE r.slug = 'nikkei'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Postres', 3 FROM restaurants r WHERE r.slug = 'nikkei'
ON CONFLICT DO NOTHING;

-- Repetir para cada restaurante
INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'hood'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Hamburguesas', 2 FROM restaurants r WHERE r.slug = 'hood'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Acompañamientos', 3 FROM restaurants r WHERE r.slug = 'hood'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'bigos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Platos del Día', 2 FROM restaurants r WHERE r.slug = 'bigos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Ensaladas', 3 FROM restaurants r WHERE r.slug = 'bigos'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'frisby'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Pollo', 2 FROM restaurants r WHERE r.slug = 'frisby'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Combos', 3 FROM restaurants r WHERE r.slug = 'frisby'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'corral'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Hamburguesas', 2 FROM restaurants r WHERE r.slug = 'corral'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Papas', 3 FROM restaurants r WHERE r.slug = 'corral'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'taco-factory'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Tacos', 2 FROM restaurants r WHERE r.slug = 'taco-factory'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Burritos', 3 FROM restaurants r WHERE r.slug = 'taco-factory'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'mi-bunuelo'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Buñuelos', 2 FROM restaurants r WHERE r.slug = 'mi-bunuelo'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Postres', 3 FROM restaurants r WHERE r.slug = 'mi-bunuelo'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Bebidas', 1 FROM restaurants r WHERE r.slug = 'dunkin-donuts'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Donas', 2 FROM restaurants r WHERE r.slug = 'dunkin-donuts'
ON CONFLICT DO NOTHING;

INSERT INTO menu_categories (restaurant_id, name, display_order)
SELECT r.id, 'Café', 3 FROM restaurants r WHERE r.slug = 'dunkin-donuts'
ON CONFLICT DO NOTHING;

-- Insertar items de ejemplo para cada restaurante
-- Nikkei
INSERT INTO menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
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

INSERT INTO menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
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

-- Hood
INSERT INTO menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Hamburguesa Clásica',
  'Carne de res, lechuga, tomate, cebolla y salsas',
  1800000,
  '/placeholder.svg?height=200&width=200',
  false,
  12,
  ARRAY[]::TEXT[]
FROM restaurants r
JOIN menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'hood' AND c.name = 'Hamburguesas'
ON CONFLICT DO NOTHING;

INSERT INTO menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Coca Cola',
  'Gaseosa 350ml',
  400000,
  '/placeholder.svg?height=200&width=200',
  true,
  2,
  ARRAY['vegano']::TEXT[]
FROM restaurants r
JOIN menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'hood' AND c.name = 'Bebidas'
ON CONFLICT DO NOTHING;

-- Verificar resultados finales
SELECT 'Categorías insertadas' as resultado, COUNT(*) as total FROM menu_categories
UNION ALL
SELECT 'Items insertados', COUNT(*) FROM menu_items;
