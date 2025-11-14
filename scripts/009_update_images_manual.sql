-- Script para actualizar imágenes manualmente
-- Puedes reemplazar las URLs con las imágenes que quieras

-- ===================================
-- ACTUALIZAR LOGOS DE RESTAURANTES
-- ===================================

-- Ejemplo: Dunkin Donuts
UPDATE restaurants 
SET logo_url = 'https://s3.amazonaws.com/cms.ipressroom.com/285/files/20160/56aacfbd5e8eef63bda1c458_dunkin-donuts-logo/dunkin-donuts-logo_a13ef105-9564-4350-a786-4b27262de56a-prv.jpg'
WHERE slug = 'dunkin-donuts';

-- Ejemplo: Nikkei
UPDATE restaurants 
SET logo_url = 'https://scontent.fbaq1-1.fna.fbcdn.net/v/t39.30808-1/296969013_5293920527309625_6265544327791344190_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=111&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=D5dMASLi_BEQ7kNvwFqENgI&_nc_oc=AdmEP-xfI8Gr1ISeHOf0ad9W0FUD48s-xvhbF28Dz4c4sYjSuLnChAjHj4tOadcofCYPzich55AJneaBNzX-jxWN&_nc_zt=24&_nc_ht=scontent.fbaq1-1.fna&_nc_gid=79yf6Pd7_d-B2VkKmOB_FA&oh=00_AfjO9crroOcwTLu8zd0KIaDhIefFl9oCzrZ_kdXPDz9qKA&oe=69130B43'
WHERE slug = 'nikkei';

-- Ejemplo: Hood
UPDATE restaurants 
SET logo_url = 'https://i.imgur.com/lF0bjkt.png'
WHERE slug = 'hood';

-- Ejemplo: Bigos
UPDATE restaurants
SET logo_url = 'https://bigos.casaalimenticia.com/wp-content/uploads/2023/03/cropped-Mi-proyecto-1.png'
WHERE slug = 'bigos';

-- Ejemplo: Frisby
UPDATE restaurants 
SET logo_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqmAeUxpakHr00LNWLPAU9IHiUiNWWFlapRg&s'
WHERE slug = 'frisby';

-- Ejemplo: Corral
UPDATE restaurants 
SET logo_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d8/El_Corral.jpg'
WHERE slug = 'corral';

-- Ejemplo: Taco Factory
UPDATE restaurants 
SET logo_url = 'https://appu-store-bucket-s3.s3.us-east-1.amazonaws.com/cafeterias/logo%20(1).jpg'
WHERE slug = 'taco-factory';

-- Ejemplo: Mi Buñuelo
UPDATE restaurants 
SET logo_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkJWh-oNlfHEFvSEuvP7QkWXJTst0wwfYONg&s'
WHERE slug = 'mi-bunuelo';

-- ===================================
-- ACTUALIZAR IMÁGENES DE ITEMS DE MENÚ
-- ===================================

-- Actualizar por NOMBRE del item (más fácil)
UPDATE menu_items 
SET image_url = 'https://tu-url-de-imagen.com/cafe-latte.jpg'
WHERE name = 'Café Latte';

-- Actualizar por NOMBRE en un restaurante específico
UPDATE menu_items 
SET image_url = 'https://tu-url-de-imagen.com/hamburguesa.jpg'
WHERE name = 'Hamburguesa Clásica' 
  AND restaurant_id = (SELECT id FROM restaurants WHERE slug = 'corral');

-- ===================================
-- CONSULTAS ÚTILES
-- ===================================

-- Ver todos los restaurantes y sus imágenes actuales
SELECT name, slug, logo_url 
FROM restaurants 
ORDER BY name;

-- Ver items de menú sin imagen por restaurante
SELECT r.name as restaurante, mi.name as item, mi.image_url
FROM menu_items mi
JOIN restaurants r ON mi.restaurant_id = r.id
WHERE mi.image_url IS NULL OR mi.image_url LIKE '%placeholder%'
ORDER BY r.name, mi.name;

-- Ver todos los items de un restaurante específico con sus IDs (para actualizaciones precisas)
SELECT id, name, image_url 
FROM menu_items 
WHERE restaurant_id = (SELECT id FROM restaurants WHERE slug = 'dunkin-donuts')
ORDER BY name;
