# Devcontainer for working with AWS

This devcontainer definiton is intended for typical AWS related IaC tasks/experiments. It is designed so thatone common instance of it can be shared among multiple sibling-folders (e.g separate repos).

```console
.
├── devcontainer-aws
│   └── .devcontainer/
├── project-a
└── project-b
```

## How to use

### Prereq

* Docker
* VS Code with [Dev Containers extenstion](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed 

### Start the contianer

Open the devcontainer-aws directory (this repo) in VS Code and then select "Reopen in container".

```shell
code devcontainer-aws
```

### Open desired workspace

In a terminal _within VS Code_ (launched above), navigate to the desired workspace and start VS Code for it, e.g.

```shell
cd ..
code project-a
```

> _**Avoid multiple VS Code instances?**_
>
> Add `-r` to the `code` command above to re-use the VS Code instance from where the command is run.

If you want to have multiple workspaces open, you can either just "open" the parent folder or run the `code` command for each explicit workspace directory (will result in multiple VS Code instances).

## GitHub CLI

`gh` needs no `gh auth login`. A wrapper ([gh-wrapper.sh](.devcontainer/gh-wrapper.sh), installed as `/usr/local/bin/gh`) fetches the token from git's credential helper, i.e. the host's credentials forwarded by VS Code, on every call, just like `git` operations. No token is stored in the container.

* Works only while VS Code is attached (same as `git` credential forwarding).
* The token has the scopes the host's credential manager requested (`repo`, `workflow`, `gist` for GCM), so features needing e.g. `read:org` won't work.
* `gh` aliases are defined in [gh-aliases.sh](.devcontainer/gh-aliases.sh), since `~/.config/gh` doesn't survive a rebuild.

