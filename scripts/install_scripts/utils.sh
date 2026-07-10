#!/bin/bash

ERROR_LOG="/tmp/system_install_errors.log"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

execute_step() {
    local step_name="$1"
    shift 
    echo -e "${YELLOW}  -> Running: ${step_name}...${NC}"
    
    "$@"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}     [✓] Success${NC}"
    else
        echo -e "${RED}     [✗] FAILED${NC}"
        local script_name=$(basename "$0")
        echo "[$script_name] $step_name" >> "$ERROR_LOG"
    fi
}
