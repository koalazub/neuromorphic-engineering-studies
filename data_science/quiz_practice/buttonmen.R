# This file is just generated trash for me to reference later on
# Button Men Game Simulation
# Author: Your Name
# Description:
# Simulates a Button Men game with two ten-sided dice for the player
# and one ten-sided die for the opponent, then checks for possible attacks.

# 1. Simulate rolling the dice
# For player (two ten-sided dice)
player_dice <- sample(1:10, size = 2, replace = TRUE)
# For opponent (one ten-sided die)
opponent_die <- sample(1:10, size = 1)

# Display the results
cat("Player's dice:", player_dice, "\n")
cat("Opponent's die:", opponent_die, "\n")

# 2. Test for Power Attack
# A Power Attack is possible if any of player's dice is >= opponent's die
power_attack_possible <- any(player_dice >= opponent_die)

if (power_attack_possible) {
  # Find which die can be used for the power attack
  attacking_dice <- player_dice[player_dice >= opponent_die]
  cat(
    "Power Attack is possible using", attacking_dice,
    "against", opponent_die, "\n"
  )
} else {
  cat("Power Attack is not possible\n")
}

# 3. Test for Skill Attack
# A Skill Attack is possible if the sum of any combination of player's
# dice equals opponent's die
skill_attack_possible <- FALSE

# Check if any single die equals opponent's die
if (any(player_dice == opponent_die)) {
  skill_attack_possible <- TRUE
  cat(
    "Skill Attack is possible using",
    player_dice[player_dice == opponent_die], "against", opponent_die, "\n"
  )
  # Check if the sum of both dice equals opponent's die
} else if (sum(player_dice) == opponent_die) {
  skill_attack_possible <- TRUE
  cat(
    "Skill Attack is possible using both dice (", player_dice[1],
    "+", player_dice[2], ") against", opponent_die, "\n"
  )
} else {
  cat("Skill Attack is not possible\n")
}
