#/usr/bin/env bash
_xm() 
{
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    #
    #  The basic options we'll complete.
    #
    opts="branch checkout merge"


    #
    #  Complete the arguments to some of the basic commands.
    #
    case "${prev}" in
        branch)
            local names=$( echo "-a -d -D" )
            COMPREPLY=( $(compgen -W "${names}" -- ${cur}) )
            return 0
            ;;
        checkout)
            local names=$( echo "-b -B" )
            COMPREPLY=( $(compgen -W "${names}" -- ${cur}) )
            return 0
            ;;
        merge)
            local names=$( echo "--squash" )
            COMPREPLY=( $(compgen -W "${names}" -- ${cur}) )
            return 0
            ;;
        *)
        ;;
    esac

   COMPREPLY=($(compgen -W "${opts}" -- ${cur}))  
   return 0
}
complete -F _xm gitr
