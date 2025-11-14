"use client"

import type { Restaurant, MenuCategory, MenuItem, CartItem } from "@/lib/types"
import { MenuItemCard } from "@/components/menu-item-card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Search, ShoppingCart, Filter } from "lucide-react"
import { useState, useMemo, useEffect } from "react"
import { useRouter } from "next/navigation"
import { formatPrice } from "@/lib/utils/format"
import { createClient } from "@/lib/supabase/client"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuCheckboxItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"

interface RestaurantMenuProps {
  restaurant: Restaurant
  categories: MenuCategory[]
  menuItems: MenuItem[]
}

export function RestaurantMenu({ restaurant, categories, menuItems }: RestaurantMenuProps) {
  const [searchQuery, setSearchQuery] = useState("")
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)
  const [cart, setCart] = useState<CartItem[]>([])
  const [favorites, setFavorites] = useState<Set<string>>(new Set())
  const [dietaryFilters, setDietaryFilters] = useState<Set<string>>(new Set())
  const router = useRouter()
  const supabase = createClient()

  useEffect(() => {
    loadFavorites()
  }, [])

  const loadFavorites = async () => {
    const {
      data: { user },
    } = await supabase.auth.getUser()
    if (!user) return

    const { data } = await supabase.from("favorites").select("menu_item_id").eq("user_id", user.id)

    if (data) {
      setFavorites(new Set(data.map((f) => f.menu_item_id)))
    }
  }

  const allDietaryTags = useMemo(() => {
    const tags = new Set<string>()
    menuItems.forEach((item) => {
      item.dietary_tags?.forEach((tag) => tags.add(tag))
    })
    return Array.from(tags)
  }, [menuItems])

  const filteredItems = useMemo(() => {
    let items = menuItems

    if (selectedCategory) {
      items = items.filter((item) => item.category_id === selectedCategory)
    }

    if (searchQuery) {
      items = items.filter(
        (item) =>
          item.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
          item.description?.toLowerCase().includes(searchQuery.toLowerCase()),
      )
    }

    if (dietaryFilters.size > 0) {
      items = items.filter((item) => item.dietary_tags?.some((tag) => dietaryFilters.has(tag)))
    }

    return items
  }, [menuItems, selectedCategory, searchQuery, dietaryFilters])

  const handleAddToCart = (item: MenuItem) => {
    setCart((prev) => {
      const existing = prev.find((cartItem) => cartItem.menuItem.id === item.id)
      if (existing) {
        return prev.map((cartItem) =>
          cartItem.menuItem.id === item.id ? { ...cartItem, quantity: cartItem.quantity + 1 } : cartItem,
        )
      }
      return [...prev, { menuItem: item, quantity: 1 }]
    })
  }

  const handleToggleFavorite = async (item: MenuItem) => {
    const {
      data: { user },
    } = await supabase.auth.getUser()
    if (!user) {
      router.push("/auth/login")
      return
    }

    const isFavorite = favorites.has(item.id)

    if (isFavorite) {
      await supabase.from("favorites").delete().eq("user_id", user.id).eq("menu_item_id", item.id)

      setFavorites((prev) => {
        const newSet = new Set(prev)
        newSet.delete(item.id)
        return newSet
      })
    } else {
      await supabase.from("favorites").insert({
        user_id: user.id,
        menu_item_id: item.id,
      })

      setFavorites((prev) => new Set(prev).add(item.id))
    }
  }

  const cartTotal = cart.reduce((sum, item) => sum + item.menuItem.price_cents * item.quantity, 0)

  const cartItemCount = cart.reduce((sum, item) => sum + item.quantity, 0)

  const handleCheckout = () => {
    localStorage.setItem("cart", JSON.stringify({ restaurantId: restaurant.id, items: cart }))
    router.push("/cart")
  }

  const toggleDietaryFilter = (tag: string) => {
    setDietaryFilters((prev) => {
      const newSet = new Set(prev)
      if (newSet.has(tag)) {
        newSet.delete(tag)
      } else {
        newSet.add(tag)
      }
      return newSet
    })
  }

  return (
    <div className="container py-8">
      {/* Search and Filters */}
      <div className="mb-8 space-y-4">
        <div className="flex gap-2">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
            <Input
              placeholder="Buscar en el menú..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-10"
            />
          </div>
          {allDietaryTags.length > 0 && (
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="outline">
                  <Filter className="h-4 w-4 mr-2" />
                  Filtros
                  {dietaryFilters.size > 0 && (
                    <Badge variant="secondary" className="ml-2">
                      {dietaryFilters.size}
                    </Badge>
                  )}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-56">
                <DropdownMenuLabel>Opciones Dietéticas</DropdownMenuLabel>
                <DropdownMenuSeparator />
                {allDietaryTags.map((tag) => (
                  <DropdownMenuCheckboxItem
                    key={tag}
                    checked={dietaryFilters.has(tag)}
                    onCheckedChange={() => toggleDietaryFilter(tag)}
                  >
                    {tag}
                  </DropdownMenuCheckboxItem>
                ))}
              </DropdownMenuContent>
            </DropdownMenu>
          )}
        </div>

        <div className="flex flex-wrap gap-2">
          <Button
            variant={selectedCategory === null ? "default" : "outline"}
            size="sm"
            onClick={() => setSelectedCategory(null)}
          >
            Todos
          </Button>
          {categories.map((category) => (
            <Button
              key={category.id}
              variant={selectedCategory === category.id ? "default" : "outline"}
              size="sm"
              onClick={() => setSelectedCategory(category.id)}
            >
              {category.name}
            </Button>
          ))}
        </div>
      </div>

      {/* Menu Items Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredItems.map((item) => (
          <MenuItemCard
            key={item.id}
            item={item}
            onAddToCart={handleAddToCart}
            onToggleFavorite={handleToggleFavorite}
            isFavorite={favorites.has(item.id)}
          />
        ))}
      </div>

      {filteredItems.length === 0 && (
        <div className="text-center py-12">
          <p className="text-muted-foreground">No se encontraron items</p>
        </div>
      )}

      {/* Floating Cart Button */}
      {cart.length > 0 && (
        <div className="fixed bottom-6 right-6 z-50">
          <Button size="lg" className="rounded-full shadow-lg h-14 px-6" onClick={handleCheckout}>
            <ShoppingCart className="h-5 w-5 mr-2" />
            <span className="font-semibold">
              {cartItemCount} {cartItemCount === 1 ? "item" : "items"}
            </span>
            <span className="mx-2">•</span>
            <span className="font-bold">{formatPrice(cartTotal)}</span>
          </Button>
        </div>
      )}
    </div>
  )
}
