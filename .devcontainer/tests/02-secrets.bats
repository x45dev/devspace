#!/usr/bin/env bats

@test "Secrets are decrypted and loaded into environment" {
  # This test assumes GIT_USERNAME is a secret managed by SOPS
  [ -n "$GIT_USERNAME" ]
}
