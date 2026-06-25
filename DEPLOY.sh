#!/bin/bash
# Deploy black-family-maps to Netlify
# Run this from Terminal: bash ~/Dropbox/FAMILY\ HISTORY/black-family-maps-deploy/DEPLOY.sh

SITE_ID="9d58af8b-686e-45b6-a602-919b1b471d32"
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Deploying black-family-maps to Netlify..."
echo "Files: index.html, pa-map.html, catrijn-map.html"
echo ""

# Check for npx
if ! command -v npx &> /dev/null; then
    echo "npx not found. Install Node.js from https://nodejs.org first."
    exit 1
fi

# Deploy using Netlify CLI
cd "$DIR"
npx netlify-cli deploy --prod --dir=. --site="$SITE_ID"

echo ""
echo "Done! Your maps should be live at:"
echo "  https://black-family-maps.netlify.app/"
echo "  https://black-family-maps.netlify.app/pa-map.html"
echo "  https://black-family-maps.netlify.app/catrijn-map.html"
