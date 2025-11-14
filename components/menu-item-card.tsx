"use client"

import type { MenuItem } from "@/lib/types"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { formatPrice } from "@/lib/utils/format"
import { Plus, Clock, Heart } from "lucide-react"
import Image from "next/image"
import { useState } from "react"

interface MenuItemCardProps {
  item: MenuItem
  onAddToCart: (item: MenuItem) => void
  onToggleFavorite?: (item: MenuItem) => void
  isFavorite?: boolean
}

export function MenuItemCard({ item, onAddToCart, onToggleFavorite, isFavorite }: MenuItemCardProps) {
  const [isAdding, setIsAdding] = useState(false)

  const handleAddToCart = async () => {
    setIsAdding(true)
    await onAddToCart(item)
    setTimeout(() => setIsAdding(false), 500)
  }

  return (
    <Card className="overflow-hidden">
      <div className="relative h-40 w-full bg-muted">
        {item.image_url && (
          <Image src={item.image_url || "/placeholder.svg"} alt={item.name} fill className="object-cover" />
        )}
        {!item.is_available && (
          <div className="absolute inset-0 bg-black/60 flex items-center justify-center">
            <Badge variant="destructive">No Disponible</Badge>
          </div>
        )}
        {item.is_priority_item && item.is_available && (
          <Badge className="absolute top-2 left-2 bg-green-600">Rápido</Badge>
        )}
        {onToggleFavorite && (
          <Button
            size="icon"
            variant="secondary"
            className="absolute top-2 right-2"
            onClick={(e) => {
              e.stopPropagation()
              onToggleFavorite(item)
            }}
          >
            <Heart className={`h-4 w-4 ${isFavorite ? "fill-red-500 text-red-500" : ""}`} />
          </Button>
        )}
      </div>
      <CardHeader>
        <CardTitle className="text-lg">{item.name}</CardTitle>
        <CardDescription className="line-clamp-2">{item.description}</CardDescription>
      </CardHeader>
      <CardContent>
        <div className="flex items-center justify-between">
          <div>
            <div className="text-2xl font-bold">{formatPrice(item.price_cents)}</div>
            <div className="flex items-center gap-1 text-xs text-muted-foreground mt-1">
              <Clock className="h-3 w-3" />
              <span>{item.prep_time_minutes} min</span>
            </div>
          </div>
          <Button size="icon" onClick={handleAddToCart} disabled={!item.is_available || isAdding}>
            <Plus className="h-4 w-4" />
          </Button>
        </div>
        {item.dietary_tags && item.dietary_tags.length > 0 && (
          <div className="flex flex-wrap gap-1 mt-3">
            {item.dietary_tags.map((tag) => (
              <Badge key={tag} variant="outline" className="text-xs">
                {tag}
              </Badge>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  )
}
