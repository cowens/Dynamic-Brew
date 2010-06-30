#!/bin/bash

export PATH=~/apps/brew/bin:~/apps/perlbrew/bin:$PATH

#mkdir -p apps/{brew,perlbrew}
#curl -L http://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C apps/brew
#
#brew install bash-completion
#
export PERLBREW_ROOT=~/apps/perlbrew
#curl -LO http://xrl.us/perlbrew
#chmod u+x ./perlbrew
#./perlbrew install
#rm ./perlbew
#perlbrew init
#perlbrew install perl-5.12.1
#perlbrew switch perl-5.12.1

. ~/apps/perlbrew/etc/bashrc

export PERL_CPANM_OPT="--skip-installed --prompt"

#curl -L http://cpanmin.us | perl - App::cpanminus

cpanm IO::All

cpanm PPI Data::Dump::Streamer Data::Dumper::Concise File::Next Sys::SigAction B::Keywords Lexical::Persistence App::Nopaste Module::Refresh

cpanm Devel::REPL
