"use client"

import type { MenuItem } from "@/lib/types"
import { MenuItemCard } from "@/components/menu-item-card"
import { createClient } from "@/lib/supabase/client"
import { useRouter } from "next/navigation"
import { useState } from "react"

interface FavoritesListProps {
  favorites: any[]
}

export function FavoritesList({ favorites: initialFavorites }: FavoritesListProps) {
  const [favorites, setFavorites] = useState(initialFavorites)
  const supabase = createClient()
  const router = useRouter()

  const handleToggleFavorite = async (item: MenuItem) => {
    const {
      data: { user },
    } = await supabase.auth.getUser()
    if (!user) return

    const isFavorite = favorites.some((fav) => fav.menu_items.id === item.id)

    if (isFavorite) {
      await supabase.from("favorites").delete().eq("user_id", user.id).eq("menu_item_id", item.id)

      setFavorites((prev) => prev.filter((fav) => fav.menu_items.id !== item.id))
    }
  }

  const handleAddToCart = (item: MenuItem) => {
    const cartData = localStorage.getItem("cart")
    const cart = cartData ? JSON.parse(cartData) : { restaurantId: item.restaurant_id, items: [] }

    const existingItem = cart.items.find((cartItem: any) => cartItem.menuItem.id === item.id)
    if (existingItem) {
      existingItem.quantity += 1
    } else {
      cart.items.push({ menuItem: item, quantity: 1 })
    }

    localStorage.setItem("cart", JSON.stringify(cart))
    router.push("/cart")
  }

  // Group by restaurant
  const groupedFavorites = favorites.reduce(
    (acc, fav) => {
      const restaurantName = fav.menu_items.restaurants.name
      if (!acc[restaurantName]) {
        acc[restaurantName] = []
      }
      acc[restaurantName].push(fav)
      return acc
    },
    {} as Record<string, any[]>,
  )

  return (
    <div className="space-y-8">
      {Object.entries(groupedFavorites).map(([restaurantName, items]) => (
        <div key={restaurantName}>
          <h2 className="text-2xl font-bold mb-4">{restaurantName}</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {items.map((fav) => (
              <MenuItemCard
                key={fav.id}
                item={fav.menu_items as MenuItem}
                onAddToCart={handleAddToCart}
                onToggleFavorite={handleToggleFavorite}
                isFavorite={true}
              />
            ))}
          </div>
        </div>
      ))}
    </div>
  )
}
