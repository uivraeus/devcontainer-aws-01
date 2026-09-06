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

