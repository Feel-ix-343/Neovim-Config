# Neovim-Config
This is my personal neovim config.

It has support for:
- Treesitter
    * Neovim tree sitter context
    * Tree sitter playground 
    * Tree sitter text objects (with custom text objects and queries for markdown files)
    * Color schemes
- Several Colorschemes
- Mix of automatic and manual LSP configurations through mason.nvim
- Debugging in all the supported languages (I think? I haven't done this in a while)
- Git support
    * Gitsigns
    * neogit
    * diffview
- Many other plugins (check the plugins directory)

## Why I use Neovim

My Reasons
- Speed and flow from modal based editing; **I have learned the vim language, all of its verbs, nouns, and modifiers**. There is minimal need to make new keybindings (like a vscoder might); moreso, I just learn new patterns in the vim language!
- Endless customizability; 
    * Tree sitter plugins
    * LSP Plugins
    * Keybindings
    * These plugins specially integrating with the model editing ecosystem (tree sitter text objects for example). 
- I know everything about my editor, and I can make everything, even down to the UI design, exactly how I want it. For example:
    * *I make all the default shortcuts*
    * *I get to chose that I don't want tabs!*
    * I can choose exactly what I want my status bar to include
    * ...many more examples
- Usage from the terminal and with tmux. Tmux allows me to bring all of my CLI tools together in one place. Neovim as a TUI allows me to add it to this arsenal. 
- Everything is designed for speed: there is no reliance on the mouse or arrow keys, and it feels very fast to me; I can become one with the code
