# Homelab setup

This is my current kubernetes homelab setup. I've built it on top of the
following

- Minimised Ubuntu server deployment
- k3s - more or less stock deployment
- MetalLB + Traefik to manage the traffik
- Longhorn for network storage (keeps 2 copies on 3 nodes)
- Prometheus/Graphana/Loki - for observability
- DIND setup to use the cluster as a docker host
- Private image registry

There are few default apps too

- gitea
- pihole
- kubernetes dashboard

## Installation

1. Run `infrastructure/node-prep.sh` script on every node. I do that manually;
   because reasons.
2. `ssh-copy-id` your ssh key on every host
3. Change the host IPs list in the `bootstrap.sh` file
4. Run `./bootstrap.sh` script to setup baseline cluster
5. Run the `./cluster/*/install` individually, wait and observe
6. Run the `./apps/*/install` scripts as you see, might need tweakage

**WARNING**: this setup uses SSH connection and passwordless sudo setup to
simplify the setup. if you're following these steps, maybe consider coming back
to each node and undo those holes.

**WARNING**: the DIND setup runs in privileged context, it's for personal use
only

## Copyright & License

All code in this repository released under the terms of the MIT license

Copyright (C) 2025 Kai Evans
