#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$ROOT_DIR/../utils.sh"

plugin_stocks_icon=$(get_tmux_option "@theme_plugin_stocks_icon" "󰝚 ")
plugin_stocks_accent_color=$(get_tmux_option "@theme_plugin_stocks_accent_color" "blue7")
plugin_stocks_accent_color_icon=$(get_tmux_option "@theme_plugin_stocks_accent_color_icon" "blue0")

plugin_stocks_format_string=$(get_tmux_option "@theme_plugin_stocks_format_string" "HELLO %h")


function load_plugin() {
    echo "Test"

    if ! command -v stocks &>/dev/null; then
		exit 1
	fi

	echo "HELLO!"
}

export plugin_stocks_icon plugin_stocks_accent_color plugin_stocks_accent_color_icon

load_plugin
