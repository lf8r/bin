# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ==== Added by install_quake_development_env.sh ===
export GOPATH=/home/sdasgupta/go
export GOFLAGS=-mod=vendor
export GO111MODULE=on
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/local/go/bin:/bin:$HOME/bin
#export QUAKE=$GOPATH/src/github.com/quattronetworks/quake
export QUAKE=/home/sdasgupta/go/src/github.com/hpe-hcss/quake
# ==== End Added by install_quake_development_env.sh === 

export GOPRIVATE=github.com/lf8r
# Portal setup instructions
export PATH=$PATH:$QUAKE/portal/cmd/steelctl:~/go/bin:~/.local/protoc-3/bin

export LF8RGO=$GOPATH/src/github.com/lf8r/go

export GITHUB_TOKEN=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

export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
