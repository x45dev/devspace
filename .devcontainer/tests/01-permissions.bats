#!/usr/bin/env bats

@test "UID matches PUID" {
  result=$(id -u)
  [ "$result" -eq "$PUID" ]
}

@test "GID matches PGID" {
  result=$(id -g)
  [ "$result" -eq "$PGID" ]
}

@test "File created in container has correct ownership" {
  touch test-file.tmp
  owner_uid=$(stat -c '%u' test-file.tmp)
  rm test-file.tmp
  [ "$owner_uid" -eq "$PUID" ]
}
