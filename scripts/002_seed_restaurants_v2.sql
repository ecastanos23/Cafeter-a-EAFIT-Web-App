-- Made script idempotent with ON CONFLICT DO UPDATE

INSERT INTO public.restaurants (name, slug, description, logo_url, is_open, opening_time, closing_time, average_prep_time_minutes) 
VALUES
  ('Nikkei', 'nikkei', 'Fusión japonesa-peruana con los mejores sabores', '/placeholder.svg?height=100&width=100', true, '08:00', '20:00', 15),
  ('Hood', 'hood', 'Comida urbana y hamburguesas gourmet', '/placeholder.svg?height=100&width=100', true, '08:00', '22:00', 12),
  ('Bigos', 'bigos', 'Cocina internacional con toque colombiano', '/placeholder.svg?height=100&width=100', true, '07:00', '21:00', 10),
  ('Frisby', 'frisby', 'Pollo frito y comida rápida colombiana', '/placeholder.svg?height=100&width=100', true, '07:00', '22:00', 8),
  ('Corral', 'corral', 'Las mejores hamburguesas colombianas', '/placeholder.svg?height=100&width=100', true, '08:00', '22:00', 10),
  ('Taco Factory', 'taco-factory', 'Tacos y comida mexicana auténtica', '/placeholder.svg?height=100&width=100', true, '09:00', '21:00', 7),
  ('Mi Buñuelo', 'mi-bunuelo', 'Buñuelos y postres tradicionales', '/placeholder.svg?height=100&width=100', true, '07:00', '20:00', 5),
  ('Dunkin Donuts', 'dunkin-donuts', 'Donas y café para todos los gustos', '/placeholder.svg?height=100&width=100', true, '06:00', '22:00', 5)
ON CONFLICT (slug) 
DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  logo_url = EXCLUDED.logo_url,
  is_open = EXCLUDED.is_open,
  opening_time = EXCLUDED.opening_time,
  closing_time = EXCLUDED.closing_time,
  average_prep_time_minutes = EXCLUDED.average_prep_time_minutes;
