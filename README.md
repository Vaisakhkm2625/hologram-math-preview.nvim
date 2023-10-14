Archiving this project....

As now there is a better well maintained plugin for image support for neovim, [image.nvim](https://github.com/3rd/image.nvim), i am considering porting this into it in the future... 

# hologram-math-preview.nvim


A simple Neovim plugin for previewing latex equations in markdown/orgmode/norg/tex files 



## demo - current progress

[hologram-math-preview-demo-async.webm](https://github.com/Vaisakhkm2625/hologram-math-preview.nvim/assets/68694876/51c89dbb-927c-41d0-98b8-7a9bc626c319)



## Installation

- Install `tectonic` by following this instruction 
https://tectonic-typesetting.github.io/en-US/install.html

- Install `pdftocairo` (probablty already installed on linux systems)

- also make sure you have hologram.nvim installed
https://github.com/edluffy/hologram.nvim

- then add this plugin to your plugin manager
lazy.nvim
```lua

{'Vaisakhkm2625/hologram-math-preview.nvim'}

```
## TODOs

- [x] find pos of equations and place images
- [x] keep track of images generated, keep it in memory and don't generate each time 
- [x] scrolling with the buffer, (taken care by hologram itself)
- [ ] exposing options to configure custom tex engine and custom preamble
- [ ] proper installation instructions

> This was started for me to learn and test similar impl for neorg,- not for daily use
> latex redering base implementation i took from Vhirro's neorg's unmerged branch,  https://github.com/nvim-neorg/neorg/commit/73ca7b63c79a76d5cd8a3f0b39c5d171c1406fdc
> though there are a lot of changes now as this is using a different latex engine 


