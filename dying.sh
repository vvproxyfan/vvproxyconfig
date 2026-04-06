#!/bin/bash

OUTPUT="happ_config.txt"
# Your custom Base64 title
TITLE_B64="aSBiZWxpdmUgaSBjYW4gZGllIHdpdGhvdXQgbXkgYnJvd3NlciBrbm93aW5nLg=="

echo "---------------------------------------"
echo "💀 Generating: The 'Silent Browser' List"
echo "---------------------------------------"

# 1. Create the Header with your specific Base64 title
cat <<EOF > $OUTPUT
#profile-title: base64:$TITLE_B64
#profile-update-interval: 6
#subscription-userinfo: upload=0; download=0; total=10737418240000000; expire=2546249531
#support-url: https://github.com/${GITHUB_REPOSITORY:-"local/repo"}
#profile-web-page-url: https://github.com/${GITHUB_REPOSITORY:-"local/repo"}

EOF

# 2. Grab the Barry-Far Tunnels
echo "📥 Infiltrating Barry-Far..."
# Fetch, decode if base64, and filter for protocol links
curl -s "https://raw.githubusercontent.com/barry-far/V2ray-Config/main/All_Configs_Sub.txt" | \
(base64 -d 2>/dev/null || cat) | grep "://" >> $OUTPUT

# 3. Grab and Format Proxifly Raw IPs
echo "📡 Harvesting Proxifly..."
# Converting IP:PORT to socks5:// links with a ghost tag
curl -s "https://raw.githubusercontent.com/proxifly/free-proxy-list/main/proxies/all/data.txt" | \
head -n 150 | \
sed 's/^/socks5:\/\//' | \
sed 's/$/#👻_Proxifly_Ghost/' >> $OUTPUT

echo "---------------------------------------"
echo "✅ Ghost config ready: $OUTPUT"
echo "---------------------------------------"
