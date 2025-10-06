#!/bin/bash

# String Coverage Checker for ClipBear MVP
# This script ensures all strings have both EN and PT translations

set -e

echo "🔍 Checking string coverage for ClipBear MVP..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check Android strings
check_android_strings() {
    echo "📱 Checking Android strings..."
    
    local android_dir="android/app/src/main/res"
    local en_strings="$android_dir/values/strings.xml"
    local pt_strings="$android_dir/values-pt/strings.xml"
    
    if [ ! -f "$en_strings" ]; then
        echo -e "${RED}❌ English strings file not found: $en_strings${NC}"
        exit 1
    fi
    
    if [ ! -f "$pt_strings" ]; then
        echo -e "${RED}❌ Portuguese strings file not found: $pt_strings${NC}"
        exit 1
    fi
    
    # Extract string names from English file
    local en_strings_list=$(grep -o 'name="[^"]*"' "$en_strings" | sed 's/name="//g' | sed 's/"//g' | sort)
    
    # Extract string names from Portuguese file
    local pt_strings_list=$(grep -o 'name="[^"]*"' "$pt_strings" | sed 's/name="//g' | sed 's/"//g' | sort)
    
    # Find missing strings
    local missing_in_pt=$(comm -23 <(echo "$en_strings_list") <(echo "$pt_strings_list"))
    local missing_in_en=$(comm -13 <(echo "$en_strings_list") <(echo "$pt_strings_list"))
    
    if [ -n "$missing_in_pt" ]; then
        echo -e "${RED}❌ Missing Portuguese translations:${NC}"
        echo "$missing_in_pt"
        exit 1
    fi
    
    if [ -n "$missing_in_en" ]; then
        echo -e "${YELLOW}⚠️  Extra Portuguese strings (not in English):${NC}"
        echo "$missing_in_en"
    fi
    
    local total_strings=$(echo "$en_strings_list" | wc -l)
    echo -e "${GREEN}✅ Android strings coverage: $total_strings strings in both languages${NC}"
}

# Function to check iOS strings
check_ios_strings() {
    echo "🍎 Checking iOS strings..."
    
    local ios_dir="ios/ClipBear/ClipBear"
    local en_strings="$ios_dir/en.lproj/Localizable.strings"
    local pt_strings="$ios_dir/pt.lproj/Localizable.strings"
    
    # Check if Localizable.strings files exist
    if [ ! -f "$en_strings" ]; then
        echo -e "${YELLOW}⚠️  English Localizable.strings not found, checking hardcoded strings...${NC}"
        return 0
    fi
    
    if [ ! -f "$pt_strings" ]; then
        echo -e "${YELLOW}⚠️  Portuguese Localizable.strings not found, checking hardcoded strings...${NC}"
        return 0
    fi
    
    # Extract string keys from English file
    local en_keys=$(grep -o '^"[^"]*"' "$en_strings" | sed 's/"//g' | sort)
    
    # Extract string keys from Portuguese file
    local pt_keys=$(grep -o '^"[^"]*"' "$pt_strings" | sed 's/"//g' | sort)
    
    # Find missing keys
    local missing_in_pt=$(comm -23 <(echo "$en_keys") <(echo "$pt_keys"))
    local missing_in_en=$(comm -13 <(echo "$en_keys") <(echo "$pt_keys"))
    
    if [ -n "$missing_in_pt" ]; then
        echo -e "${RED}❌ Missing Portuguese translations:${NC}"
        echo "$missing_in_pt"
        exit 1
    fi
    
    if [ -n "$missing_in_en" ]; then
        echo -e "${YELLOW}⚠️  Extra Portuguese keys (not in English):${NC}"
        echo "$missing_in_en"
    fi
    
    local total_keys=$(echo "$en_keys" | wc -l)
    echo -e "${GREEN}✅ iOS strings coverage: $total_keys keys in both languages${NC}"
}

# Function to check for hardcoded strings in code
check_hardcoded_strings() {
    echo "🔍 Checking for hardcoded strings in code..."
    
    local hardcoded_found=false
    
    # Check Android Kotlin files
    if [ -d "android" ]; then
        local android_hardcoded=$(find android -name "*.kt" -exec grep -l '"[A-Za-z][^"]*"' {} \; | head -5)
        if [ -n "$android_hardcoded" ]; then
            echo -e "${YELLOW}⚠️  Potential hardcoded strings in Android files:${NC}"
            echo "$android_hardcoded"
            hardcoded_found=true
        fi
    fi
    
    # Check iOS Swift files
    if [ -d "ios" ]; then
        local ios_hardcoded=$(find ios -name "*.swift" -exec grep -l '"[A-Za-z][^"]*"' {} \; | head -5)
        if [ -n "$ios_hardcoded" ]; then
            echo -e "${YELLOW}⚠️  Potential hardcoded strings in iOS files:${NC}"
            echo "$ios_hardcoded"
            hardcoded_found=true
        fi
    fi
    
    if [ "$hardcoded_found" = false ]; then
        echo -e "${GREEN}✅ No obvious hardcoded strings found${NC}"
    fi
}

# Main execution
main() {
    echo "🚀 Starting string coverage check..."
    echo ""
    
    # Check if we're in the right directory
    if [ ! -f "README.md" ]; then
        echo -e "${RED}❌ Please run this script from the project root directory${NC}"
        exit 1
    fi
    
    # Run checks
    check_android_strings
    echo ""
    
    check_ios_strings
    echo ""
    
    check_hardcoded_strings
    echo ""
    
    echo -e "${GREEN}🎉 String coverage check completed successfully!${NC}"
}

# Run main function
main "$@"
