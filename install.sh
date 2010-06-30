#!/bin/bash

instdir=/tmp/dynamic-brew-$$

mkdir $instdir
cd $instdir

mkdir -p ~/apps/{brew,perlbrew,python,ruby}
mkdir ~/apps/ruby/gems

export PATH=~/apps/brew/bin:~/apps/perlbrew/bin:$PATH
export SDK=/Developer/SDKs/MacOSX10.6.sdk

####################
### Install brew ###
####################

curl -L http://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C apps/brew

#get bash-completion and git while we are at it
brew install bash-completion git

################################
### Full Perl 5.12.1 install ###
################################

export PERLBREW_ROOT=~/apps/perlbrew
curl -LO http://xrl.us/perlbrew
chmod u+x ./perlbrew
./perlbrew install
perlbrew init
perlbrew install perl-5.12.1
perlbrew switch perl-5.12.1

. ~/apps/perlbrew/etc/bashrc

export PERL_CPANM_OPT="--skip-installed --prompt"

curl -L http://cpanmin.us | perl - App::cpanminus

#needed for App::Nopaste
cpanm IO::All

optional modules for Devel::REPL
cpanm PPI Data::Dump::Streamer Data::Dumper::Concise File::Next Sys::SigAction B::Keywords Lexical::Persistence App::Nopaste Module::Refresh Term::ReadLine::Gnu

#a real Perl REPL
cpanm Devel::REPL

##################################
### Python virtual environment ###
##################################

curl -L http://bitbucket.org/ianb/virtualenv/get/tip.gz#egg=virtualenv-tip | tar xvfz - 

cd virtualenv

./virtualenv.py ~/apps/python

cd ..

. ~/apps/python/bin/activate

cd ~

rm -rf $instdir

cat <<'!'
add the following lines to your profile

#shell stuff
. ~/apps/brew/etc/bash_completion

for bindir in ~/apps/*/bin; do
	PATH="$bindir:$PATH"
done

#git stuff
export GIT_AUTHOR_EMAIL=your email
export GIT_COMMITTER_EMAIL=your email
export GIT_AUTHOR_NAME=your name
export GIT_COMMITTER_NAME=your name

#cpanm stuff
export PERL_CPANM_OPT="--skip-installed --prompt"

#perlbrew stuff
source ~/apps/perlbrew/etc/bashrc
export SDK=/Developer/SDKs/MacOSX10.6.sdk

#Ruby stuff
export RUBYOPT=rubygems
export GEM_HOME=~/apps/ruby/gems

#Python stuff
VIRTUAL_ENV_DISABLE_PROMPT=Y
. ~/apps/python/bin/activate
!
