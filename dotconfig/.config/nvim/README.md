# Nvim Configuration

## Requirements

- Neovim 0.10.0+

## Dependencies

**Note**: You can install all the dependencies here with homebrew!

### fzf

- ripgrep

This is necessary for telescope.nvim to work properly.

### lsp

- lua-language-server

- cmake-language-server

- pylsp(python-lsp-server)

- llvm(required by c++)

On MacOS, you could download the all the servers with:

```bash
brew install lua-language-server cmake-language-server
```

### font

Currently I use [Jetbrain Mono Nerd Font](https://www.nerdfonts.com/font-downloads) as the default font. 


### Code format

I'm using clang-format Microsoft style, you can check at the `conform.lua` file, if the format doesn't work, try to install the laster version of the clang-format

On MacOS, you can try:

```bash
brew install clang-format
```

### obsidian

In order to make obsidian.nvim work, you should create a vault and some sub-dirs to store all the markdown files, the folder structure will be like the following:

- $HOME
    + vaults
        * daily_notes
        * temp-notes
        * template
        * assets
           . imgs
        * notes
           . every-week
        * weekly_reports (optional)
        * monthly_reports (optional)
        * literature_notes (optional)
        * distrilled_notes (optional)

[pngpaste plugin](https://github.com/jcsalterego/pngpaste) is needed for obsidian to paste images on **Macos**!

On **Linux**, use [xclip](https://github.com/astrand/xclip)

### Markdown

`Yarn` is necessary to install markdown preview plugin

> [!TIP]
>
> Install necessary parsers are necessary for treesitter

```nvim
:TSInstall markdown markdown_inline html latex typst yaml
```

