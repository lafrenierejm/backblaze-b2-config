# Backblaze B2 Config

This is the configuration of my personal [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html) infrastructure.
It is provided under the [ISC license](https://choosealicense.com/licenses/isc/) (see the accompanying [LICENSE.txt](./LICENSE.txt)).

## Use

1. Export your Backblaze master key components as the following environment variables:
   - `B2_APPLICATION_KEY_ID`
   - `B2_APPLICATION_KEY`
1. Create the `provider.tf` and initialize Terraform: `terragrunt init`
1. Create and inspect a plan: `terragrunt plan --out=plan.out`
1. Run the plan: `terragrunt apply plan.out`
1. Print the created application key: `terragrunt output application_key`

Copy the value of `application_key_id` and the printed application key for later use.
