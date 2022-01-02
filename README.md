# Backblaze B2 Config

This is the configuration of my personal [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html) infrastructure.
It is provided under the [ISC license](https://choosealicense.com/licenses/isc/) (see the accompanying [LICENSE.txt](./LICENSE.txt)).

## Use

1. Update `inputs` in [`terragrunt.hcl`](./terragrunt.hcl) with names of your B2 buckets.
1. Setup Backblaze environment variables with your secrets.
   - These environment variables are
      - `B2_APPLICATION_KEY_ID`
      - `B2_APPLICATION_KEY`
   - If you use `direnv` and Nix Flakes, see the ["Direnv" section](#Direnv) below.
1. Create the `provider.tf` and initialize Terraform: `terragrunt init`
1. Create a plan: `terragrunt plan --out=plan.out`
1. Inspect the plan.
1. Run the plan: `terragrunt apply plan.out`
1. Print the created application key(s): `terragrunt output application_key`

Copy the value of `application_key_id` and the printed application key for later use.

### Direnv

1. Update [`.envrc.private`](./.envrc.private) to export environment variables containing your Backblaze account's master secrets.
   The names of the variables to use are
      - `B2_APPLICATION_KEY_ID`
      - `B2_APPLICATION_KEY`
1. Ensure `use_flake` is defined in your `direnv` config.
   If it's not already, you can add it using the following script:
   ```sh
   lib="${XDG_CONFIG_HOME:-$HOME/.config}/direnv/lib"
   cat <<EOF >"$lib/use_flake.sh"
   # Copied verbatim from https://nixos.wiki/wiki/Flakes#Direnv_integration on 2022-01-01.
   # Per https://nixos.wiki/wiki/NixOS_Wiki:Copyrights:
   # Copyright (c) 2017 Jörg Thalheim
   # Licensed under the MIT license.

   use_flake() {
     watch_file flake.nix
     watch_file flake.lock
     eval "$(nix print-dev-env --profile "$(direnv_layout_dir)/flake-profile")"
   }
   EOF
   ```
1. Whitelist this repository: `direnv allow .`
