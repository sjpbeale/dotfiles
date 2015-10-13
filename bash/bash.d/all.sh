#
# Switch terminal to support 256 colors, if possible
# 
case $TERM in
	xterm*)
		# Check if the terminal supports 256 colors
		if [ -e /usr/share/terminfo/x/xterm-256color ]; then
			export TERM='xterm-256color'
		else
			export TERM='xterm-color'
		fi
		;;
	*)
		;;
esac

#
# Various useful functions
# 

# Check if command exists
# 
# Usage: have fortune && fortune
function have() { 
	type "$1" &> /dev/null; 
}

# Show top 10 used commands in history
function top10() {
	history | awk '{a[$4]++ } END{for(i in a){print a[i] " " i}}'|sort -rn |head -n 10
}

# 
# Export some useful variables
# 
export PATH=$PATH:$HOME/bin:$HOME/dotfiles/bin
export PAGER=`which --skip-alias less -RFSinX 2> /dev/null`
export EDITOR=`which --skip-alias vim -X 2> /dev/null`
export SVN_EDITOR=$EDITOR
export LC_TIME=en_US
export HISTTIMEFORMAT=" (%F %T) "
export HISTCONTROL=ignoredups:ignorespace
export MOZ_NO_REMOTE=1
export MYSQL_PS1='[\R:\m:\s][\U:\d]> '

# Shorten and simplify cd
export CDPATH=.:~:~/Development/mamchenkov:~/Development/ImpreStyle:~/Development/Exwebris:~/Development:/var/www/html:/var/www/vhosts
# Do not save these commands to history
export HISTIGNORE="bg:fg:h:history"
# Ignore files matching this suffixes from completion
export FIGNORE=".svn"

# When displaying prompt, write previous command to history file so that,
# any new shell immediately gets the history lines from all previous shells.
PROMPT_COMMAND='history -a'

# Bash Directory Bookmarks
# From: http://habrahabr.ru/post/151484/#habracut                                                                                                                                        
alias m1='alias g1="cd `pwd`"'                                                                                                                                          
alias m2='alias g2="cd `pwd`"'                                                                                                                                          
alias m3='alias g3="cd `pwd`"'                                                                                                                                          
alias m4='alias g4="cd `pwd`"'                                                                                                                                          
alias m5='alias g5="cd `pwd`"'                                                                                                                                          
alias m6='alias g6="cd `pwd`"'                                                                                                                                          
alias m7='alias g7="cd `pwd`"'                                                                                                                                          
alias m8='alias g8="cd `pwd`"'                                                                                                                                          
alias m9='alias g9="cd `pwd`"'                                                                                                                                          
alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.bookmarks'                                                                                             
alias mload='if [ -e ~/.bookmarks ] ; then source ~/.bookmarks ; fi'
alias ah='(echo;alias | grep  "g[0-9]" | grep -v "m[0-9]" | cut -d" " -f "2,3"| sed "s/=/   /" | sed "s/cd //";echo)' 

# 
# Aliases
# 
alias vi="vim -X"
alias vim="vim -X"
alias ll="ls -al --group-directories-first"
alias df="df -kTh"
alias du="du -kh"
alias ..="cd ..;"
alias ...="cd ..;"
alias h="history"
alias traceroute="traceroute -I"
alias who="who -HT"
alias mkdir="mkdir -p"
alias path="echo -e ${PATH//:/\\n}"

# Mysql with fancy pager
alias mysql="mysql --pager='nice_tables | grcat ~/dotfiles/etc/grcat.conf | less -RFSinX'"

alias head='head -n $((${LINES:-12}-2))' #as many as possible without scrolling
alias tail='tail -n $((${LINES:-12}-2)) -s.1' #Likewise, also more responsive -f

# what most people want from od (hexdump)
alias hd='od -Ax -tx1z -v'

# Leaving
alias quit="exit"
alias bye="exit"
# 
# Less pager colors for man pages
# Source:
# http://unix.stackexchange.com/questions/119/colors-in-man-pages/147#147
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# 
# Set some shell options
# 
ulimit -S -c 0 			# No core dump files

set -o notify 			# Notify when jobs in background terminate
#set -o noclobber 		# Prevent overwriting files by rediction
#set -o nounset 		# Errors if using undefined variable
set -o vi 				# Vi-style command editing


shopt -s cdable_vars 	# directory to cd is in variable
shopt -s cdspell 		# correct minor spelling mistakes
shopt -s checkhash 		# check hash for the command,before path search
shopt -s checkwinsize 	# check window size after every command
shopt -s cmdhist 		# save multiline commands as one history item
shopt -s histappend histreedit histverify # better history management

shopt -u mailwarn
unset MAILCHECK

# 
# Android SDK
# 
#PATH=$PATH:$HOME/lib/android-sdk-linux_x86:$HOME/android-sdk-linux_x86/tools
#export PATH

# For SDK version r_08 and higher, also add this for adb:
# PATH=$PATH:$HOME/AndroidSDK/platform-tools
# export PATH
# bash/zsh git prompt support
#
# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
# Distributed under the GNU General Public License, version 2.0.
#
# This script allows you to see the current branch in your prompt.
#
# To enable:
#
#    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
#    2) Add the following line to your .bashrc/.zshrc:
#        source ~/.git-prompt.sh
#    3) Change your PS1 to also show the current branch:
#         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
#
# The argument to __git_ps1 will be displayed only if you are currently
# in a git repository.  The %s token will be the name of the current
# branch.
#
# In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
# unstaged (*) and staged (+) changes will be shown next to the branch
# name.  You can configure this per-repository with the
# bash.showDirtyState variable, which defaults to true once
# GIT_PS1_SHOWDIRTYSTATE is enabled.
#
# You can also see if currently something is stashed, by setting
# GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
# then a '$' will be shown next to the branch name.
#
# If you would like to see if there're untracked files, then you can set
# GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
# files, then a '%' will be shown next to the branch name.
#
# If you would like to see the difference between HEAD and its upstream,
# set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
# indicates you are ahead, "<>" indicates you have diverged and "="
# indicates that there is no difference. You can further control
# behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
# of values:
#
#     verbose       show number of commits ahead/behind (+/-) upstream
#     legacy        don't use the '--count' option available in recent
#                   versions of git-rev-list
#     git           always compare HEAD to @{upstream}
#     svn           always compare HEAD to your SVN upstream
#
# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
# find one, or @{upstream} otherwise.  Once you have set
# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
# setting the bash.showUpstream config variable.

# __gitdir accepts 0 or 1 arguments (i.e., location)
# returns location of .git repo
__gitdir ()
{
	# Note: this function is duplicated in git-completion.bash
	# When updating it, make sure you update the other one to match.
	if [ -z "${1-}" ]; then
		if [ -n "${__git_dir-}" ]; then
			echo "$__git_dir"
		elif [ -n "${GIT_DIR-}" ]; then
			test -d "${GIT_DIR-}" || return 1
			echo "$GIT_DIR"
		elif [ -d .git ]; then
			echo .git
		else
			git rev-parse --git-dir 2>/dev/null
		fi
	elif [ -d "$1/.git" ]; then
		echo "$1/.git"
	else
		echo "$1"
	fi
}

# stores the divergence from upstream in $p
# used by GIT_PS1_SHOWUPSTREAM
__git_ps1_show_upstream ()
{
	local key value
	local svn_remote svn_url_pattern count n
	local upstream=git legacy="" verbose=""

	svn_remote=()
	# get some config options from git-config
	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
	while read -r key value; do
		case "$key" in
		bash.showupstream)
			GIT_PS1_SHOWUPSTREAM="$value"
			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
				p=""
				return
			fi
			;;
		svn-remote.*.url)
			svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
			svn_url_pattern+="\\|$value"
			upstream=svn+git # default upstream is SVN if available, else git
			;;
		esac
	done <<< "$output"

	# parse configuration values
	for option in ${GIT_PS1_SHOWUPSTREAM}; do
		case "$option" in
		git|svn) upstream="$option" ;;
		verbose) verbose=1 ;;
		legacy)  legacy=1  ;;
		esac
	done

	# Find our upstream
	case "$upstream" in
	git)    upstream="@{upstream}" ;;
	svn*)
		# get the upstream from the "git-svn-id: ..." in a commit message
		# (git-svn uses essentially the same procedure internally)
		local svn_upstream=($(git log --first-parent -1 \
					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
			svn_upstream=${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
			svn_upstream=${svn_upstream%@*}
			local n_stop="${#svn_remote[@]}"
			for ((n=1; n <= n_stop; n++)); do
				svn_upstream=${svn_upstream#${svn_remote[$n]}}
			done

			if [[ -z "$svn_upstream" ]]; then
				# default branch name for checkouts with no layout:
				upstream=${GIT_SVN_ID:-git-svn}
			else
				upstream=${svn_upstream#/}
			fi
		elif [[ "svn+git" = "$upstream" ]]; then
			upstream="@{upstream}"
		fi
		;;
	esac

	# Find how many commits we are ahead/behind our upstream
	if [[ -z "$legacy" ]]; then
		count="$(git rev-list --count --left-right \
				"$upstream"...HEAD 2>/dev/null)"
	else
		# produce equivalent output to --count for older versions of git
		local commits
		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
		then
			local commit behind=0 ahead=0
			for commit in $commits
			do
				case "$commit" in
				"<"*) ((behind++)) ;;
				*)    ((ahead++))  ;;
				esac
			done
			count="$behind	$ahead"
		else
			count=""
		fi
	fi

	# calculate the result
	if [[ -z "$verbose" ]]; then
		case "$count" in
		"") # no upstream
			p="" ;;
		"0	0") # equal to upstream
			p="=" ;;
		"0	"*) # ahead of upstream
			p=">" ;;
		*"	0") # behind upstream
			p="<" ;;
		*)	    # diverged from upstream
			p="<>" ;;
		esac
	else
		case "$count" in
		"") # no upstream
			p="" ;;
		"0	0") # equal to upstream
			p=" u=" ;;
		"0	"*) # ahead of upstream
			p=" u+${count#0	}" ;;
		*"	0") # behind upstream
			p=" u-${count%	0}" ;;
		*)	    # diverged from upstream
			p=" u+${count#*	}-${count%	*}" ;;
		esac
	fi

}


# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# returns text to add to bash PS1 prompt (includes branch name)
__git_ps1 ()
{
	local g="$(__gitdir)"
	if [ -n "$g" ]; then
		local r=""
		local b=""
		if [ -f "$g/rebase-merge/interactive" ]; then
			r="|REBASE-i"
			b="$(cat "$g/rebase-merge/head-name")"
		elif [ -d "$g/rebase-merge" ]; then
			r="|REBASE-m"
			b="$(cat "$g/rebase-merge/head-name")"
		else
			if [ -d "$g/rebase-apply" ]; then
				if [ -f "$g/rebase-apply/rebasing" ]; then
					r="|REBASE"
				elif [ -f "$g/rebase-apply/applying" ]; then
					r="|AM"
				else
					r="|AM/REBASE"
				fi
			elif [ -f "$g/MERGE_HEAD" ]; then
				r="|MERGING"
			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
				r="|CHERRY-PICKING"
			elif [ -f "$g/BISECT_LOG" ]; then
				r="|BISECTING"
			fi

			b="$(git symbolic-ref HEAD 2>/dev/null)" || {

				b="$(
				case "${GIT_PS1_DESCRIBE_STYLE-}" in
				(contains)
					git describe --contains HEAD ;;
				(branch)
					git describe --contains --all HEAD ;;
				(describe)
					git describe HEAD ;;
				(* | default)
					git describe --tags --exact-match HEAD ;;
				esac 2>/dev/null)" ||

				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
				b="unknown"
				b="($b)"
			}
		fi

		local w=""
		local i=""
		local s=""
		local u=""
		local c=""
		local p=""

		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
				c="BARE:"
			else
				b="GIT_DIR!"
			fi
		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
					git diff --no-ext-diff --quiet --exit-code || w="*"
					if git rev-parse --quiet --verify HEAD >/dev/null; then
						git diff-index --cached --quiet HEAD -- || i="+"
					else
						i="#"
					fi
				fi
			fi
			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
				git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
			fi

			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
					u="%"
				fi
			fi

			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
				__git_ps1_show_upstream
			fi
		fi

		local f="$w$i$s$u"
		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
	fi
}
#
# Build shell prompt
# 
# Most of the code is from: https://gist.github.com/293517

# Bash colors from https://wiki.archlinux.org/index.php/Color_Bash_Prompt

# Reset
Color_Off="\[\e[0m\]"       # Text Reset

# Regular Colors
Black="\[\e[0;30m\]"        # Black
Red="\[\e[0;31m\]"          # Red
Green="\[\e[0;32m\]"        # Green
Yellow="\[\e[0;33m\]"       # Yellow
Blue="\[\e[0;34m\]"         # Blue
Purple="\[\e[0;35m\]"       # Purple
Cyan="\[\e[0;36m\]"         # Cyan
White="\[\e[0;37m\]"        # White

# Bold
BBlack="\[\e[1;30m\]"       # Black
BRed="\[\e[1;31m\]"         # Red
BGreen="\[\e[1;32m\]"       # Green
BYellow="\[\e[1;33m\]"      # Yellow
BBlue="\[\e[1;34m\]"        # Blue
BPurple="\[\e[1;35m\]"      # Purple
BCyan="\[\e[1;36m\]"        # Cyan
BWhite="\[\e[1;37m\]"       # White

# Underline
UBlack="\[\e[4;30m\]"       # Black
URed="\[\e[4;31m\]"         # Red
UGreen="\[\e[4;32m\]"       # Green
UYellow="\[\e[4;33m\]"      # Yellow
UBlue="\[\e[4;34m\]"        # Blue
UPurple="\[\e[4;35m\]"      # Purple
UCyan="\[\e[4;36m\]"        # Cyan
UWhite="\[\e[4;37m\]"       # White

# Background
On_Black="\[\e[40m\]"       # Black
On_Red="\[\e[41m\]"         # Red
On_Green="\[\e[42m\]"       # Green
On_Yellow="\[\e[43m\]"      # Yellow
On_Blue="\[\e[44m\]"        # Blue
On_Purple="\[\e[45m\]"      # Purple
On_Cyan="\[\e[46m\]"        # Cyan
On_White="\[\e[47m\]"       # White

# High Intensity
IBlack="\[\e[0;90m\]"       # Black
IRed="\[\e[0;91m\]"         # Red
IGreen="\[\e[0;92m\]"       # Green
IYellow="\[\e[0;93m\]"      # Yellow
IBlue="\[\e[0;94m\]"        # Blue
IPurple="\[\e[0;95m\]"      # Purple
ICyan="\[\e[0;96m\]"        # Cyan
IWhite="\[\e[0;97m\]"       # White

# Bold High Intensity
BIBlack="\[\e[1;90m\]"      # Black
BIRed="\[\e[1;91m\]"        # Red
BIGreen="\[\e[1;92m\]"      # Green
BIYellow="\[\e[1;93m\]"     # Yellow
BIBlue="\[\e[1;94m\]"       # Blue
BIPurple="\[\e[1;95m\]"     # Purple
BICyan="\[\e[1;96m\]"       # Cyan
BIWhite="\[\e[1;97m\]"      # White

# High Intensity backgrounds
On_IBlack="\[\e[0;100m\]"   # Black
On_IRed="\[\e[0;101m\]"     # Red
On_IGreen="\[\e[0;102m\]"   # Green On_IYellow='\e[0;103m'  # Yellow
On_IBlue="\[\e[0;104m\]"    # Blue
On_IPurple="\[\e[0;105m\]"  # Purple
On_ICyan="\[\e[0;106m\]"    # Cyan
On_IWhite="\[\e[0;107m\]"   # White

# Print flag character if current git directory is locally modified
# 
# Used in bash prompt
function __git_dirty {
	git diff --quiet HEAD &>/dev/null 
	[ $? == 1 ] && echo "+"
}

function __git_branch {
	GIT_BRANCH=$(git branch 2>/dev/null | grep '^*' | cut -f 2 -d ' ')
	if [ ! -z "$GIT_BRANCH" ]
	then
		echo "$GIT_BRANCH"
	fi

	# Cleanup
	unset GIT_BRANCH
}

function terminal_title {
	echo "\\[\\033]0;\\u@\\H:\\w\\007\\]"
}

function fancyprompt {
	local RETVAL=$?

	# Last command successful - green, otherwise red
	if [ "$RETVAL" -eq "0" ]
	then
		LAST_COLOR=$Green
		LAST_SYMBOL="\\$"
	else
		LAST_COLOR=$Red
		LAST_SYMBOL="\\$"
	fi

	# Root is bright red, everyone else is green
	if [ "$EUID" -eq "0" ]
	then
		USER_COLOR=$IRed
		PROMPT_COLOR=$IRed
		FEEL_COLOR=$IBlack
	else
		USER_COLOR=$Green
		PROMPT_COLOR=$IWhite
		FEEL_COLOR=$IBlack
	fi

	# Load average green, or bright yellow, or bright red
	CPUS=$(grep -c vendor_id /proc/cpuinfo)
	CPUS=$(printf "%.0f" $CPUS)
	read ONE REST < /proc/loadavg
	LOAD=$(printf "%.0f" $ONE)
	if [ "$LOAD" -lt "$CPUS" ]
	then 
		LOAD_COLOR=$Green
	elif [ "$LOAD" -eq "$CPUS" ]
	then 
		LOAD_COLOR=$IYellow
	else 
		LOAD_COLOR=$IRed
	fi

	# .com|.org|.net hostnames are bright red
	if [[ $HOSTNAME =~ ".com" || $HOSTNAME =~ ".org" || $HOSTNAME =~ ".net" ]]
	then
		HOST_COLOR=$IRed
	# localhost|localdomain hostnames are green
	elif [[ $HOSTNAME =~ "localhost" || $HOSTNAME =~ "localdomain" ]]
	then
		HOST_COLOR=$Green
	# everything else yellow
	else
		HOST_COLOR=$IYellow
	fi

	GIT_BRANCH=$(__git_branch)
	if [ ! -z "$GIT_BRANCH" ]
	then
		GIT_DIRTY=$(__git_dirty)
		if [ ! -z "$GIT_DIRTY" ]
		then
			GIT_DIRTY="$IRed$GIT_DIRTY"
		fi
		# Bright yellow for master branch, purple for everything else
		if [ "$GIT_BRANCH" == "master" ]
			then
				GIT_BRANCH_COLOR=$IYellow
			else
				GIT_BRANCH_COLOR=$Purple
		fi
		GIT_BRANCH="$FEEL_COLOR⑂${GIT_BRANCH_COLOR}$GIT_BRANCH$GIT_DIRTY$FEEL_COLOR"
	fi


	# Terminal title and new online separator for each prompt
	PS1="$(terminal_title)\n"
	# Time with color by load
	PS1="$PS1$FEEL_COLOR[$LOAD_COLOR\t$FEEL_COLOR|"
	# User with color by username at host with color by hostname
	PS1="$PS1$USER_COLOR\u$FEEL_COLOR@$HOST_COLOR\H$FEEL_COLOR:"
	# Current folder and git branch with color by branch name and modified
	PS1="$PS1$IBlue\w$GIT_BRANCH$FEEL_COLOR]"
	# Prompt with color by last status
	PS1="$PS1${LAST_COLOR}${LAST_SYMBOL}${FEEL_COLOR} $Color_Off"

	# Cleanup
	unset FEEL_COLOR USER_COLOR HOST_COLOR LOAD_COLOR LAST_COLOR PROMPT_COLOR 
}

function dullprompt {
    PROMPT_COMMAND=""
	if [ "$EUID" -eq "0" ]
	then
		PS1="[\t][\u@\h:\w\$(__git_branch)\$(__git_dirty)]\\$ "
	else
		PS1="[\t][\u@\h:\w\$(__git_branch)\$(__git_dirty)]\\$ "
	fi
}

case "$TERM" in
xterm-color|xterm-256color|rxvt*|screen*)
        PROMPT_COMMAND=fancyprompt
    ;;
*)
        PROMPT_COMMAND=dullprompt
    ;;
esac

# 
# Last bits
# 

# Show host information
#have whereami && whereami

# Show thought of the day
#have fortune && echo Thought of the day: && fortune -s && echo

# Load directory bookmarks
have mload && mload
		
