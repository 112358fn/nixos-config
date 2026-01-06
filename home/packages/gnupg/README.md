# GNUPG

## Retrieving keys

<https://keys.openpgp.org/about/usage>

To locate the key of a user, by email address:

```sh
gpg --auto-key-locate keyserver --locate-keys user@example.net
```

To refresh all your keys (e.g. new revocation certificates and subkeys):

```sh
gpg --refresh-keys
```

## Restart GPG-AGENT

```sh
gpgconf --kill gpg-agent
```
