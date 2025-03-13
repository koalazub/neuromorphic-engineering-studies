velocity_mps <- 5
gravity <- 9.81
angle_deg <- 60
angle_rad <- angle_deg * (pi / 180)


projectile_motion <- function(velocity, gravity, radians) {
  vel_squared <- velocity^2

  distance <- (vel_squared / gravity) * sin(2 * radians)

  return(distance)
}


cat("velocity_mps = ", velocity_mps, "\n")
cat("gravity = ", gravity, "\n")
cat("angle_deg = ", angle_deg, "\n")
cat("angle_rad = ", angle_rad, "\n")

cat(
  "rounded distance calculated =",
  round(projectile_motion(velocity_mps, gravity, angle_rad), digits = 2), "\n"
)
