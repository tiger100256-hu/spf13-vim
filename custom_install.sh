#!/usr/bin/env sh
app_dir="$HOME/.spf13-vim-3"


rm $HOME/.vim
rm $HOME/.vimrc
rm $HOME/.vimrc.before
rm $HOME/.vimrc.before.local
rm $HOME/.vimrc.bundles
rm $HOME/.vimrc.bundles.default
rm $HOME/.vimrc.bundles.local
rm $HOME/.vimrc.local
rm $HOME/.vimrc.mswin

ln -s ${app_dir}/.vim  $HOME/.vim
ln -s ${app_dir}/.vimrc  $HOME/.vimrc
ln -s ${app_dir}/.vimrc.before  $HOME/.vimrc.before
ln -s ${app_dir}/.vimrc.before.local  $HOME/.vimrc.before.local
ln -s ${app_dir}/.vimrc.bundles  $HOME/.vimrc.bundles
ln -s ${app_dir}/.vimrc.bundles.default  $HOME/.vimrc.bundles.default
ln -s ${app_dir}/.vimrc.bundles.local  $HOME/.vimrc.bundles.local
ln -s ${app_dir}/.vimrc.local  $HOME/.vimrc.local
ln -s ${app_dir}/.vimrc.mswin  $HOME/.vimrc.mswin
