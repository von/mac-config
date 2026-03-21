Mac setup using https://github.com/zero-sh/zero.sh

Set up by running `setup.sh <workspace>` where `<workspace>` is directory under
`workspaces/`

zero.sh uses `apply-user-defaults` to apply defaults in `default.yaml`
This can't handle complicated data types (arrays, dicts, etc.) so there
is still some manual running of `default` in scripts.
See https://github.com/zero-sh/apply-user-defaults
