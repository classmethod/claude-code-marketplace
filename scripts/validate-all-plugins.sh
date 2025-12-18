#!/bin/bash

# Claude Code Plugin Validator
# Usage:
#   ./scripts/validate-all-plugins.sh           # Validate all plugins
#   ./scripts/validate-all-plugins.sh my-plugin # Validate specific plugin

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
PLUGINS_DIR="$REPO_ROOT/plugins"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

validate_plugin() {
    local plugin_dir="$1"
    local plugin_name=$(basename "$plugin_dir")
    local plugin_json="$plugin_dir/.claude-plugin/plugin.json"

    # Check if plugin.json exists
    if [[ ! -f "$plugin_json" ]]; then
        echo -e "${RED}✗ $plugin_name: Missing .claude-plugin/plugin.json${NC}"
        return 1
    fi

    # Validate JSON syntax
    if ! python3 -c "import json; json.load(open('$plugin_json'))" 2>/dev/null; then
        echo -e "${RED}✗ $plugin_name: Invalid JSON in plugin.json${NC}"
        return 1
    fi

    # Check required fields
    local name=$(python3 -c "import json; print(json.load(open('$plugin_json')).get('name', ''))")
    local description=$(python3 -c "import json; print(json.load(open('$plugin_json')).get('description', ''))")
    local version=$(python3 -c "import json; print(json.load(open('$plugin_json')).get('version', ''))")
    local author_name=$(python3 -c "import json; print(json.load(open('$plugin_json')).get('author', {}).get('name', ''))")

    if [[ -z "$name" ]]; then
        echo -e "${RED}✗ $plugin_name: Missing 'name' field${NC}"
        return 1
    fi

    if [[ -z "$description" ]]; then
        echo -e "${RED}✗ $plugin_name: Missing 'description' field${NC}"
        return 1
    fi

    if [[ -z "$version" ]]; then
        echo -e "${RED}✗ $plugin_name: Missing 'version' field${NC}"
        return 1
    fi

    if [[ -z "$author_name" ]]; then
        echo -e "${RED}✗ $plugin_name: Missing 'author.name' field${NC}"
        return 1
    fi

    # Validate semantic versioning
    if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "${YELLOW}⚠ $plugin_name: Version '$version' doesn't follow semantic versioning${NC}"
    fi

    echo -e "${GREEN}✓ $plugin_name: Valid${NC}"
    return 0
}

main() {
    local specific_plugin="$1"
    local total=0
    local valid=0
    local invalid=0
    local failed_plugins=()

    echo "================================"
    echo "Claude Code Plugin Validator"
    echo "================================"
    echo ""

    if [[ -n "$specific_plugin" ]]; then
        # Validate specific plugin
        local plugin_path="$PLUGINS_DIR/$specific_plugin"
        if [[ ! -d "$plugin_path" ]]; then
            echo -e "${RED}Error: Plugin '$specific_plugin' not found${NC}"
            exit 1
        fi

        if validate_plugin "$plugin_path"; then
            echo -e "\n${GREEN}Plugin is valid!${NC}"
            exit 0
        else
            echo -e "\n${RED}Plugin validation failed!${NC}"
            exit 1
        fi
    fi

    # Validate all plugins
    if [[ ! -d "$PLUGINS_DIR" ]]; then
        echo -e "${YELLOW}No plugins directory found${NC}"
        exit 0
    fi

    for plugin_dir in "$PLUGINS_DIR"/*/; do
        [[ -d "$plugin_dir" ]] || continue
        ((total++))

        if validate_plugin "$plugin_dir"; then
            ((valid++))
        else
            ((invalid++))
            failed_plugins+=("$(basename "$plugin_dir")")
        fi
    done

    echo ""
    echo "================================"
    echo "Summary"
    echo "================================"
    echo "Total plugins: $total"
    echo -e "Valid: ${GREEN}$valid${NC}"
    echo -e "Invalid: ${RED}$invalid${NC}"

    if [[ ${#failed_plugins[@]} -gt 0 ]]; then
        echo ""
        echo "Failed plugins:"
        for plugin in "${failed_plugins[@]}"; do
            echo "  - $plugin"
        done
        exit 1
    fi

    exit 0
}

main "$@"
