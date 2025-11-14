-- Fixed column count mismatch - all INSERT statements now have consistent columns

-- Delete existing menu data to avoid duplicates
DELETE FROM public.menu_items;
DELETE FROM public.menu_categories;

-- Nikkei Menu
INSERT INTO public.menu_categories (restaurant_id, name, display_order)
SELECT id, 'Rolls', 1 FROM public.restaurants WHERE slug = 'nikkei'
UNION ALL
SELECT id, 'Ceviches', 2 FROM public.restaurants WHERE slug = 'nikkei'
UNION ALL
SELECT id, 'Bebidas', 3 FROM public.restaurants WHERE slug = 'nikkei';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'California Roll',
  'Roll clásico con cangrejo, aguacate y pepino',
  1800,
  '/placeholder.svg?height=300&width=300',
  true,
  10,
  ARRAY['pescado']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'nikkei' AND c.name = 'Rolls';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Spicy Tuna Roll',
  'Roll picante con atún fresco y salsa especial',
  2000,
  '/placeholder.svg?height=300&width=300',
  false,
  12,
  ARRAY['pescado', 'picante']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'nikkei' AND c.name = 'Rolls';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Ceviche Nikkei',
  'Ceviche de pescado con leche de tigre',
  2200,
  '/placeholder.svg?height=300&width=300',
  false,
  15,
  ARRAY['pescado', 'picante']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'nikkei' AND c.name = 'Ceviches';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Limonada Natural',
  'Limonada fresca recién preparada',
  500,
  '/placeholder.svg?height=300&width=300',
  true,
  3,
  ARRAY['vegetariano', 'vegano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'nikkei' AND c.name = 'Bebidas';

-- Hood Menu
INSERT INTO public.menu_categories (restaurant_id, name, display_order)
SELECT id, 'Hamburguesas', 1 FROM public.restaurants WHERE slug = 'hood'
UNION ALL
SELECT id, 'Acompañamientos', 2 FROM public.restaurants WHERE slug = 'hood'
UNION ALL
SELECT id, 'Bebidas', 3 FROM public.restaurants WHERE slug = 'hood';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Hood Burger',
  'Hamburguesa con carne angus, queso cheddar y salsa especial',
  1600,
  '/placeholder.svg?height=300&width=300',
  false,
  12,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'hood' AND c.name = 'Hamburguesas';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Doble Queso',
  'Doble carne, doble queso, doble sabor',
  1900,
  '/placeholder.svg?height=300&width=300',
  false,
  15,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'hood' AND c.name = 'Hamburguesas';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Papas Fritas',
  'Papas crujientes con sal de mar',
  600,
  '/placeholder.svg?height=300&width=300',
  true,
  5,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'hood' AND c.name = 'Acompañamientos';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Gaseosa',
  'Coca-Cola, Sprite o Fanta',
  400,
  '/placeholder.svg?height=300&width=300',
  true,
  2,
  ARRAY['vegetariano', 'vegano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'hood' AND c.name = 'Bebidas';

-- Frisby Menu
INSERT INTO public.menu_categories (restaurant_id, name, display_order)
SELECT id, 'Pollo', 1 FROM public.restaurants WHERE slug = 'frisby'
UNION ALL
SELECT id, 'Combos', 2 FROM public.restaurants WHERE slug = 'frisby'
UNION ALL
SELECT id, 'Bebidas', 3 FROM public.restaurants WHERE slug = 'frisby';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Pollo Broaster 8 Piezas',
  'Pollo frito crujiente estilo colombiano',
  2400,
  '/placeholder.svg?height=300&width=300',
  false,
  15,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'frisby' AND c.name = 'Pollo';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Combo Personal',
  '4 piezas de pollo + papas + gaseosa',
  1800,
  '/placeholder.svg?height=300&width=300',
  false,
  12,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'frisby' AND c.name = 'Combos';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Jugo Natural',
  'Jugo de frutas naturales',
  600,
  '/placeholder.svg?height=300&width=300',
  true,
  3,
  ARRAY['vegetariano', 'vegano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'frisby' AND c.name = 'Bebidas';

-- Corral Menu
INSERT INTO public.menu_categories (restaurant_id, name, display_order)
SELECT id, 'Hamburguesas', 1 FROM public.restaurants WHERE slug = 'corral'
UNION ALL
SELECT id, 'Perros Calientes', 2 FROM public.restaurants WHERE slug = 'corral'
UNION ALL
SELECT id, 'Bebidas', 3 FROM public.restaurants WHERE slug = 'corral';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Corralita',
  'Hamburguesa clásica con carne, queso y vegetales',
  1400,
  '/placeholder.svg?height=300&width=300',
  false,
  10,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'corral' AND c.name = 'Hamburguesas';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Corral Especial',
  'Hamburguesa con doble carne y queso',
  1800,
  '/placeholder.svg?height=300&width=300',
  false,
  12,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'corral' AND c.name = 'Hamburguesas';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Perro Caliente Sencillo',
  'Perro con salchicha y salsas',
  900,
  '/placeholder.svg?height=300&width=300',
  true,
  7,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'corral' AND c.name = 'Perros Calientes';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Malteada',
  'Malteada de vainilla, chocolate o fresa',
  700,
  '/placeholder.svg?height=300&width=300',
  true,
  4,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'corral' AND c.name = 'Bebidas';

-- Taco Factory Menu
INSERT INTO public.menu_categories (restaurant_id, name, display_order)
SELECT id, 'Tacos', 1 FROM public.restaurants WHERE slug = 'taco-factory'
UNION ALL
SELECT id, 'Burritos', 2 FROM public.restaurants WHERE slug = 'taco-factory'
UNION ALL
SELECT id, 'Bebidas', 3 FROM public.restaurants WHERE slug = 'taco-factory';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Tacos al Pastor',
  'Tres tacos con carne al pastor, piña y cilantro',
  1200,
  '/placeholder.svg?height=300&width=300',
  true,
  7,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'taco-factory' AND c.name = 'Tacos';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Tacos de Pollo',
  'Tres tacos con pollo marinado',
  1100,
  '/placeholder.svg?height=300&width=300',
  false,
  7,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'taco-factory' AND c.name = 'Tacos';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Burrito de Carne',
  'Burrito grande con carne, frijoles y arroz',
  1500,
  '/placeholder.svg?height=300&width=300',
  false,
  10,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'taco-factory' AND c.name = 'Burritos';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Agua de Horchata',
  'Bebida tradicional mexicana',
  500,
  '/placeholder.svg?height=300&width=300',
  true,
  3,
  ARRAY['vegetariano', 'vegano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'taco-factory' AND c.name = 'Bebidas';

-- Mi Buñuelo Menu
INSERT INTO public.menu_categories (restaurant_id, name, display_order)
SELECT id, 'Buñuelos', 1 FROM public.restaurants WHERE slug = 'mi-bunuelo'
UNION ALL
SELECT id, 'Postres', 2 FROM public.restaurants WHERE slug = 'mi-bunuelo'
UNION ALL
SELECT id, 'Bebidas Calientes', 3 FROM public.restaurants WHERE slug = 'mi-bunuelo';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Buñuelo con Chocolate',
  'Buñuelo tradicional con chocolate caliente',
  800,
  '/placeholder.svg?height=300&width=300',
  true,
  5,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'mi-bunuelo' AND c.name = 'Buñuelos';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Buñuelo con Queso',
  'Buñuelo con queso y arequipe',
  900,
  '/placeholder.svg?height=300&width=300',
  false,
  5,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'mi-bunuelo' AND c.name = 'Buñuelos';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Natilla',
  'Natilla tradicional colombiana',
  600,
  '/placeholder.svg?height=300&width=300',
  false,
  3,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'mi-bunuelo' AND c.name = 'Postres';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Chocolate Caliente',
  'Chocolate colombiano con queso',
  500,
  '/placeholder.svg?height=300&width=300',
  true,
  4,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'mi-bunuelo' AND c.name = 'Bebidas Calientes';

-- Dunkin Donuts Menu
INSERT INTO public.menu_categories (restaurant_id, name, display_order)
SELECT id, 'Donas', 1 FROM public.restaurants WHERE slug = 'dunkin-donuts'
UNION ALL
SELECT id, 'Café', 2 FROM public.restaurants WHERE slug = 'dunkin-donuts'
UNION ALL
SELECT id, 'Bebidas Frías', 3 FROM public.restaurants WHERE slug = 'dunkin-donuts';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Dona Glaseada',
  'Dona clásica con glaseado de azúcar',
  500,
  '/placeholder.svg?height=300&width=300',
  true,
  3,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'dunkin-donuts' AND c.name = 'Donas';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Dona de Chocolate',
  'Dona con cobertura de chocolate',
  550,
  '/placeholder.svg?height=300&width=300',
  false,
  3,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'dunkin-donuts' AND c.name = 'Donas';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Café Americano',
  'Café negro recién preparado',
  400,
  '/placeholder.svg?height=300&width=300',
  true,
  2,
  ARRAY['vegetariano', 'vegano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'dunkin-donuts' AND c.name = 'Café';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Café Latte',
  'Espresso con leche vaporizada',
  600,
  '/placeholder.svg?height=300&width=300',
  false,
  4,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'dunkin-donuts' AND c.name = 'Café';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Frappé de Caramelo',
  'Bebida helada con caramelo',
  700,
  '/placeholder.svg?height=300&width=300',
  false,
  5,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'dunkin-donuts' AND c.name = 'Bebidas Frías';

-- Bigos Menu
INSERT INTO public.menu_categories (restaurant_id, name, display_order)
SELECT id, 'Platos Principales', 1 FROM public.restaurants WHERE slug = 'bigos'
UNION ALL
SELECT id, 'Ensaladas', 2 FROM public.restaurants WHERE slug = 'bigos'
UNION ALL
SELECT id, 'Bebidas', 3 FROM public.restaurants WHERE slug = 'bigos';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Bandeja Paisa',
  'Plato típico colombiano completo',
  2800,
  '/placeholder.svg?height=300&width=300',
  false,
  20,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'bigos' AND c.name = 'Platos Principales';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Pechuga a la Plancha',
  'Pechuga de pollo con arroz y ensalada',
  1800,
  '/placeholder.svg?height=300&width=300',
  false,
  15,
  ARRAY[]::TEXT[]
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'bigos' AND c.name = 'Platos Principales';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Ensalada César',
  'Lechuga romana, crutones, parmesano y aderezo césar',
  1200,
  '/placeholder.svg?height=300&width=300',
  true,
  5,
  ARRAY['vegetariano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'bigos' AND c.name = 'Ensaladas';

INSERT INTO public.menu_items (restaurant_id, category_id, name, description, price_cents, image_url, is_priority_item, prep_time_minutes, dietary_tags)
SELECT 
  r.id,
  c.id,
  'Limonada de Coco',
  'Limonada con coco natural',
  600,
  '/placeholder.svg?height=300&width=300',
  true,
  3,
  ARRAY['vegetariano', 'vegano']
FROM public.restaurants r
JOIN public.menu_categories c ON c.restaurant_id = r.id
WHERE r.slug = 'bigos' AND c.name = 'Bebidas';
