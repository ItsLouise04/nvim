let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

map ,, :keepp /<++><CR>ca<
imap ,, <esc>:keepp /<++><CR>ca<

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
"Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
call plug#end()

lua require("toggleterm").setup()
set title
set bg=light
"set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
"set noshowmode
set noruler
set laststatus=2
set noshowcmd
colorscheme vim

highlight StatusLineNC ctermfg=gray ctermbg=black guifg=#888888 guibg=#222222
highlight StatusLine ctermfg=white ctermbg=blue guifg=#da035e guibg=#ffffff
nnoremap c "_c
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set wildmode=longest,list,full
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
vnoremap . :normal .<CR>
map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
map <leader>o :setlocal spell! spelllang=en_us<CR>
set splitbelow splitright
map <leader>t :ToggleTerm<CR>
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>1 :tabn 1<CR>
nnoremap <leader>2 :tabn 2<CR>ap <C-l> <C-w>l
map Q gq
map <leader>s :!clear && shellcheck -x %<CR>
map <leader>b :vsp<space>$BIB<CR>
map <leader>r :vsp<space>$REFER<CR>
nnoremap S :%s//g<Left><Left>
map <leader>c :w! \| !compiler "%:p"<CR>
map <leader>p :!opout "%:p"<CR>

autocmd VimLeave *.tex !texclear %

let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex<CR>
let g:vimwiki_list = [{'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo 80 | call feedkeys("jk")
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo!\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo!\|q!<CR>

autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre *neomutt* %s/^--$/-- /e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

autocmd BufWritePost bm-files,bm-dirs !shortcuts
autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

if &diff
    highlight! link DiffText MatchParen
endif

silent! source ~/.config/nvim/shortcuts.vim
