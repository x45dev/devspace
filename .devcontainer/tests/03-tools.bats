#!/usr/bin/env bats

@test "Core tools from config.toml are installed and on the PATH" {
  tools=$(yq '.tools | keys | .[]' .config/mise/config.toml)
  for tool in $tools; do
    run command -v "$tool"
    [ "$status" -eq 0 ]
  done
}
