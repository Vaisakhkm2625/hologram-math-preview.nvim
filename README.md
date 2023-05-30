# hologram-math-preview.nvim

A simple Neovim plugin for previewing latex equations in markdown/orgmode/norg/tex files 

> This is made for me to learn and test similar impl for neorg,- not for daily use
> latex redering implementation i took from Vhirro's neorg's unmerged branch - https://github.com/nvim-neorg/neorg/commit/73ca7b63c79a76d5cd8a3f0b39c5d171c1406fdc

demo - current progress

[hologram-math-preview-demo3.webm](https://github.com/Vaisakhkm2625/hologram-math-preview.nvim/assets/68694876/14c7a246-27c7-42b4-84fc-39ee3d3fec13)


[hologram-math-preview-demo-update.webm](https://github.com/Vaisakhkm2625/hologram-math-preview.nvim/assets/68694876/2c3848f8-61ce-4028-bdea-eb074ab9e93f)

[hologram-math-preview-demo.webm](https://github.com/Vaisakhkm2625/hologram-math-preview.nvim/assets/68694876/8f0f6610-2fa3-48c2-8e87-1cdecd7a2b03)

## Installation

lazy.nvim
```lua

{'Vaisakhkm2625/hologram-math-preview.nvim'}

```
## TODOs

- [ ] find pos of equations and place images
  - [ ] equation for the first q
- [ ] keep track of images generated, keep it in memory and don't generate each time (adding a metadate to treesitter)
- [ ] scrolling with the buffer, 
- [ ] exposing options to configure custom tex engine and custom preamble
- [ ] instructions


- installation instructions


