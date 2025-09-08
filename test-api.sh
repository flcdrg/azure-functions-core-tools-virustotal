#!/bin/bash
# Simple test script to verify the GitHub API functionality used in the workflows

echo "Testing GitHub API access to Azure Functions Core Tools..."

# Test the API endpoint used in the workflows
RELEASE_INFO=$(curl -s \
  -H "Accept: application/vnd.github.v3+json" \
  -H "User-Agent: azure-functions-core-tools-virustotal-test" \
  "https://api.github.com/repos/Azure/azure-functions-core-tools/releases/latest")

# Check if we got a valid response
if echo "$RELEASE_INFO" | jq -e '.tag_name' > /dev/null 2>&1; then
  echo "✅ API access successful!"
  
  # Extract and display basic information
  TAG_NAME=$(echo "$RELEASE_INFO" | jq -r '.tag_name')
  RELEASE_NAME=$(echo "$RELEASE_INFO" | jq -r '.name')
  PUBLISHED_AT=$(echo "$RELEASE_INFO" | jq -r '.published_at')
  
  echo "Latest release: $TAG_NAME"
  echo "Release name: $RELEASE_NAME"
  echo "Published: $PUBLISHED_AT"
  
  # Show available assets
  echo ""
  echo "Available assets:"
  echo "$RELEASE_INFO" | jq -r '.assets[] | "- \(.name) (\(.size) bytes)"'
  
else
  echo "❌ API access failed or invalid response"
  echo "Response: $RELEASE_INFO"
  exit 1
fi

echo ""
echo "🎉 Test completed successfully!"
echo "The workflows should work correctly with the GitHub API."