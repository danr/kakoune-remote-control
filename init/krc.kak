def connect -override -params 1.. %{
    %arg{1} bash -c %{
        export session=$1
        export client=$2
        cd $3
        shift 4
        [ "$1" ] && "$@" || "$SHELL"
    } -- %val{session} %val{client} %sh{pwd} %arg{@}
}

def shell -params 1.. -override %{
    nop %sh{
        setsid "$@" < /dev/null > /dev/null 2>&1 &
    }
}

def connect-shell -params 1.. -override %{
    connect shell %arg{@}
}

def connect-terminal -params .. -override %{
    connect terminal %arg{@}
}
