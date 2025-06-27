#!/bin/bash
# Privacy Protection Scanner for Context-Based Project Framework

echo "🔍 Privacy Protection Scanner"
echo "=============================="

FAILED=0

# Personal names check
echo "Checking for personal names..."
PERSONAL_NAMES=("平子" "hirako" "aoitairako" "川口" "kawaguchi" "神田" "kanda")
for name in "${PERSONAL_NAMES[@]}"; do
    if grep -r "$name" . --exclude-dir=.git --exclude-dir=scripts >/dev/null 2>&1; then
        echo "❌ Personal name detected: $name"
        FAILED=1
    fi
done

# Email addresses check
echo "Checking for email addresses..."
if grep -r "@[a-zA-Z0-9.-]*\.[a-zA-Z]" . --exclude-dir=.git | grep -v "noreply" | grep -v "example.com" >/dev/null 2>&1; then
    echo "❌ Real email addresses detected"
    FAILED=1
fi

# Company names check
echo "Checking for company names..."
COMPANIES=("AWESOME SAUCE" "MLS Management" "RUN EDGE")
for company in "${COMPANIES[@]}"; do
    if grep -r "$company" . --exclude-dir=.git >/dev/null 2>&1; then
        echo "❌ Company name detected: $company"
        FAILED=1
    fi
done

# Financial information check
echo "Checking for financial information..."
if grep -r "[0-9]\+円\|[0-9]\+万円\|売上高" . --exclude-dir=.git >/dev/null 2>&1; then
    echo "❌ Financial information detected"
    FAILED=1
fi

# Phone numbers check
echo "Checking for phone numbers..."
if grep -r "[0-9]\{3\}-[0-9]\{4\}-[0-9]\{4\}" . --exclude-dir=.git >/dev/null 2>&1; then
    echo "❌ Phone numbers detected"
    FAILED=1
fi

if [ $FAILED -eq 0 ]; then
    echo "✅ Privacy scan passed - No personal information detected"
else
    echo "❌ Privacy scan failed - Personal information found"
    echo "Please remove all personal information before committing"
    exit 1
fi
