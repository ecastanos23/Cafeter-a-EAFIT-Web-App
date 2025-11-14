export interface Restaurant {
  id: string
  name: string
  slug: string
  description: string | null
  logo_url: string | null
  is_open: boolean
  opening_time: string | null
  closing_time: string | null
  average_prep_time_minutes: number
  created_at: string
}

export interface MenuCategory {
  id: string
  restaurant_id: string
  name: string
  display_order: number
  created_at: string
}

export interface MenuItem {
  id: string
  restaurant_id: string
  category_id: string | null
  name: string
  description: string | null
  price_cents: number
  image_url: string | null
  is_available: boolean
  is_priority_item: boolean
  prep_time_minutes: number
  dietary_tags: string[] | null
  created_at: string
}

export interface Order {
  id: string
  user_id: string
  restaurant_id: string
  status: "pending" | "preparing" | "ready" | "completed" | "cancelled"
  total_cents: number
  payment_status: "pending" | "paid" | "refunded"
  payment_intent_id: string | null
  scheduled_for: string | null
  queue_position: number | null
  estimated_ready_time: string | null
  actual_ready_time: string | null
  special_instructions: string | null
  created_at: string
  updated_at: string
}

export interface OrderItem {
  id: string
  order_id: string
  menu_item_id: string
  quantity: number
  price_cents: number
  customizations: Record<string, any> | null
  created_at: string
}

export interface CartItem {
  menuItem: MenuItem
  quantity: number
  customizations?: Record<string, any>
}
