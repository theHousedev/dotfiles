# Configuration file path
PROMPT_CONFIG_FILE="$HOME/.prompt_config"

# Function to load saved configuration
load_prompt_config() {
    if [[ -f "$PROMPT_CONFIG_FILE" ]]; then
        source "$PROMPT_CONFIG_FILE"
    else
        # Default values if no config file exists
        export PROMPT_CHARS="special"
    fi
}

# Function to save current configuration
save_prompt_config() {
    echo "export PROMPT_CHARS=\"$PROMPT_CHARS\"" > "$PROMPT_CONFIG_FILE"
    echo "Prompt configuration saved to $PROMPT_CONFIG_FILE"
}

# Function to toggle between special and simple characters
toggle_prompt() {
    if [[ "$PROMPT_CHARS" == "special" ]]; then
        export PROMPT_CHARS="simple"
        echo "Switched to simple prompt characters"
    else
        export PROMPT_CHARS="special"
        echo "Switched to special prompt characters"
    fi
    
    # Save the new setting
    save_prompt_config
    
    # Refresh the prompt
    set_prompt
}

# Function to show current setting
show_prompt_config() {
    echo "Current prompt style: $PROMPT_CHARS"
    echo "Config file: $PROMPT_CONFIG_FILE"
}

# Load configuration on shell startup
load_prompt_config
