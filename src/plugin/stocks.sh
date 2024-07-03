#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$ROOT_DIR/../utils.sh"

# shellcheck disable=SC2005
plugin_stocks_icon=$(get_tmux_option "@theme_plugin_stocks_icon" " ")
plugin_stocks_accent_color=$(get_tmux_option "@theme_plugin_stocks_accent_color" "blue7")
plugin_stocks_accent_color_icon=$(get_tmux_option "@theme_plugin_stocks_accent_color_icon" "blue0")

function load_plugin() {
    result=$(curl -X GET --header "Accept: */*" "https://login.questrade.com/oauth2/token?grant_type=refresh_token&refresh_token=UkOkfPHLeQXo6OrflacirIps87MjR7Qn0")
    echo "${result}"
}

export plugin_stocks_icon plugin_stocks_accent_color plugin_stocks_accent_color_icon

load_plugin
