import type { Restaurant } from "@/lib/types"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Clock } from "lucide-react"
import { formatTime } from "@/lib/utils/format"
import Link from "next/link"
import Image from "next/image"

interface RestaurantCardProps {
  restaurant: Restaurant
}

export function RestaurantCard({ restaurant }: RestaurantCardProps) {
  return (
    <Link href={`/restaurants/${restaurant.slug}`}>
      <Card className="overflow-hidden transition-all hover:shadow-lg hover:scale-[1.02] cursor-pointer">
        <div className="relative h-48 w-full bg-muted">
          {restaurant.logo_url && (
            <Image
              src={restaurant.logo_url || "/placeholder.svg"}
              alt={restaurant.name}
              fill
              className="object-cover"
            />
          )}
          {!restaurant.is_open && (
            <div className="absolute inset-0 bg-black/60 flex items-center justify-center">
              <Badge variant="destructive" className="text-lg">
                Cerrado
              </Badge>
            </div>
          )}
        </div>
        <CardHeader>
          <div className="flex items-start justify-between">
            <div className="flex-1">
              <CardTitle className="text-xl">{restaurant.name}</CardTitle>
              <CardDescription className="mt-1">{restaurant.description}</CardDescription>
            </div>
            {restaurant.is_open && (
              <Badge variant="secondary" className="ml-2">
                Abierto
              </Badge>
            )}
          </div>
        </CardHeader>
        <CardContent>
          <div className="flex items-center gap-2 text-sm text-muted-foreground">
            <Clock className="h-4 w-4" />
            <span>
              {formatTime(restaurant.opening_time)} - {formatTime(restaurant.closing_time)}
            </span>
          </div>
          <div className="mt-2 text-sm text-muted-foreground">
            Tiempo promedio: {restaurant.average_prep_time_minutes} min
          </div>
        </CardContent>
      </Card>
    </Link>
  )
}
