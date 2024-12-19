#!/bin/sh

# Network interface Name
# Example
# ens192   ens224   ens256

INTERFACE="ens256"

# Routes to be inserted in the nmcli
# "<network>/<mask> <gateway>" 
ROUTES=(
    "192.16.0.0/16 10.107.0.1"
)

# Add each route to nmcli 
for route in "${ROUTES[@]}"; do
  NETWORK=$(echo $route | awk '{print $1}')
  GATEWAY=$(echo $route | awk '{print $2}')
  nmcli connection modify $INTERFACE +ipv4.routes "$NETWORK $GATEWAY"
done

# Reboot the interface
nmcli connection up $INTERFACE
