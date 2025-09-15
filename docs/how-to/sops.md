# How-To: SOPS (Secrets Operator)

- To encrypt an unencrypted file: `sops --encrypt --config="$sops_config_file" "${unencrypted_file}"`

- To edit an encrypted file (editor mode; in-place): `sops --config="$sops_config_file" --in-place "${encrypted_file}"`

- To decrypt an encrypted file (to STDOUT): `sops --decrypt "${encrypted_file}"`
