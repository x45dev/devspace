# How-To: Manage Secrets with SOPS

This guide provides a quick reference for using Mozilla's SOPS (Secrets OPerationS) to manage encrypted secrets in this project. SOPS allows us to commit encrypted files to Git, with decryption handled securely by the `mise` toolchain at runtime.

Our project is configured to use `age` as the encryption provider. You must have a valid `age` key to decrypt or edit secrets.

---

## Common Commands

### Editing Encrypted Files

This is the most common command you will use. It decrypts the file in-memory, opens it in your default `$EDITOR`, and automatically re-encrypts it on save. This is the safest way to modify secrets.

```sh
sops .config/env/.env.sops.yaml
```

### Encrypting a New File

If you need to encrypt a new file for the first time, use the `sops --encrypt` command. You must specify the output file.

```sh
# Encrypt a new file and save it
sops --encrypt my-new-secrets.yaml > my-new-secrets.sops.yaml
```

### Decrypting a File to Standard Output

To view the contents of an encrypted file without editing it, you can decrypt it to your terminal's standard output. **Be careful not to accidentally commit or expose this output.**

```sh
sops --decrypt .config/env/.env.sops.yaml
```

---

For more advanced usage, please refer to the official [SOPS documentation](https://github.com/getsops/sops).
