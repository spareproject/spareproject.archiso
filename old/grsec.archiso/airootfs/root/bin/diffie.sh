#!/bin/env bash

clear

prime=563
random=5
alicePrivate=9
bobPrivate=14

alicePublic=$((random^alicePrivate))
alicePublic=$((alicePublic%prime))

bobPublic=$((random^bobPrivate))
bobPublic=$((bobPublic%prime))

echo "exchange public..."

aliceSecret=$((bobPublic^alicePrivate))
aliceSecret=$((aliceSecret%prime))

bobSecret=$((alicePublic^bobPrivate))
bobSecret=$((bobSecret%prime))

echo "#########################################"
echo ${aliceSecret}
echo ${bobSecret}
echo "#########################################"

