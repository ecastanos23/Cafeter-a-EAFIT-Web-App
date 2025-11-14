-- Function to add order to queue
CREATE OR REPLACE FUNCTION add_order_to_queue(
  p_order_id UUID,
  p_restaurant_id UUID,
  p_is_priority BOOLEAN DEFAULT false
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_queue_number INTEGER;
BEGIN
  -- Get next queue number for this restaurant
  SELECT COALESCE(MAX(queue_number), 0) + 1
  INTO v_queue_number
  FROM order_queue
  WHERE restaurant_id = p_restaurant_id;

  -- Insert into queue
  INSERT INTO order_queue (order_id, restaurant_id, queue_number, is_priority)
  VALUES (p_order_id, p_restaurant_id, v_queue_number, p_is_priority);

  -- Update order with queue position
  UPDATE orders
  SET queue_position = v_queue_number
  WHERE id = p_order_id;

  RETURN v_queue_number;
END;
$$;

-- Function to get orders ahead in queue
CREATE OR REPLACE FUNCTION get_orders_ahead(
  p_order_id UUID
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_count INTEGER;
  v_restaurant_id UUID;
  v_queue_number INTEGER;
BEGIN
  -- Get order's restaurant and queue number
  SELECT oq.restaurant_id, oq.queue_number
  INTO v_restaurant_id, v_queue_number
  FROM order_queue oq
  WHERE oq.order_id = p_order_id;

  -- Count orders ahead in same restaurant
  SELECT COUNT(*)
  INTO v_count
  FROM order_queue oq
  JOIN orders o ON o.id = oq.order_id
  WHERE oq.restaurant_id = v_restaurant_id
    AND oq.queue_number < v_queue_number
    AND o.status IN ('pending', 'preparing');

  RETURN v_count;
END;
$$;

-- Function to complete order and remove from queue
CREATE OR REPLACE FUNCTION complete_order(p_order_id UUID)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
  -- Update order status
  UPDATE orders
  SET status = 'completed',
      actual_ready_time = NOW()
  WHERE id = p_order_id;

  -- Remove from queue
  DELETE FROM order_queue
  WHERE order_id = p_order_id;
END;
$$;
