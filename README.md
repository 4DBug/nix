# nix

[dendritic](https://github.com/vic/den) [nix](https://nixos.org/) configuration.

## hosts
| host | command |
|-|-|
| [desktop](https://github.com/4DBug/nix/tree/master/modules/hosts/nix/nix.nix) | `nh os switch ~/nix --impure -H nix` |
| [laptop](https://github.com/4DBug/nix/tree/master/modules/hosts/nix/laptop.nix) | `nh os switch ~/nix --impure -H laptop` |
| [server](https://github.com/4DBug/nix/tree/master/modules/hosts/nix/box.nix) | `nh os switch ~/nix --impure -H box` |

## services
| service | location | file |
|-|-|-|
| [invidious](https://github.com/invidious/invidious) | [tube.bug.tools](https://tube.bug.tools/) | /modules/services |
| [glances](https://github.com/nicolargo/glances) | [monitor.bug.tools](https://monitor.bug.tools/) | /modules/services |
| [searxng](https://github.com/searxng/searxng) | [search.bug.tools](https://search.bug.tools/) | /modules/services |
| [redlib](https://github.com/redlib-org/redlibb) | [reddit.bug.tools](https://reddit.bug.tools/) | ./modules/services/searxng/searxng.nix |
| [copyparty](https://github.com/9001/copyparty) | [files.bug.tools](https://files.bug.tools/) | /modules/services |
| [matrix](https://matrix.org/) | [matrix.bug.tools](https://matrix.bug.tools/) | /modules/services |
| [nixos-mailserver](https://gitlab.com/simple-nixos-mailserver/nixos-mailserver) | [mail.bug.tools](https://mail.bug.tools/) | /modules/services |
| [sish](https://docs.ssi.sh/) | [tuns.bug.tools](https://tuns.bug.tools/) | /modules/services |
| [vscode-server](https://github.com/cdr/code-server) | - | /modules/services |

## software

| software | file |
|-|-|
| a | b |
| c | d |
| e | f |