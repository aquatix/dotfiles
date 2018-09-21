#!fish
#
# Fish completion support for terrible_job.
#

function __terrible_job_needs_command
    set -l cmd (commandline -opc)
    if [ (count $cmd) -lt 2 ]
        return 0
    end

    set -l skip_next 0
    for arg in $cmd[2..-1]
        if [ $skip_next -eq 1 ]
            set skip_next 0
            continue
        end

        switch $arg
            # General options, with and without parameter.
            case --{verbose,superverbose,vv} "-V" --{server,terrible-key}"=*" -{s,k}"=*"
                continue
            # General options that take an argument.
            case --{server,terrible-key}
                set skip_next 1
                continue
            # Options that work like a command
            case "--version" "-v" "--help" "-h"
                return 1
            # Everything else should be the command
            case "*"
                return 1
        end
    end

    return 0
end

function __terrible_job_using_command
    set cmd (commandline -opc)
    if contains -- $argv[1] $cmd
        return 0
    end
    return 1
end

function __mtime
    if [ (uname) = "Darwin" ]
        stat -f "%m" $argv
    else
        stat -c "%Y" $argv
    end
end

function __terrible_job_environments
    if not test -f $HOME/.terrible-job
        echo "~/.terrible-job not found, not completing environments." >&2
        return
    end
    if not which jq ^/dev/null
        echo "jq not found, not completing environments." >&2
        return
    end

    # Set up cache directory
    if test -z "$XDG_CACHE_HOME"
        set XDG_CACHE_HOME $HOME/.cache
    end
    mkdir -m 700 -p $XDG_CACHE_HOME

    # Get the current token from the command line, and parse out the cluster name.
    set -l env (commandline -tc)
    set -l cluster (commandline -tc | cut -d/ -f1)

    # Check if the cache file exists.
    set -l cache_file "$XDG_CACHE_HOME/terrible-$cluster"
    if test -f $cache_file

        # Show results from the cache.
        grep -F --color=never "$env" $cache_file

        # Check the age of the cache file. Don't cache for more than five minutes.
        set age (math (date +%s) - (__mtime $cache_file))
        set max_age 300
        if test $age -lt $max_age
            return
        end
    end

    # Use curl and jq to update the cache, in the background.
    set -l header (sed 's/^TERRIBLE_KEY=/Terrible-Key: /' "$HOME/.terrible-job")
    begin
        if not curl --fail --silent -H "$header" "https://terrible.sanomaservices.nl/env/list/$cluster" | \
                jq -r '.[] | .Cluster + "/" + .Product + "/" + .Environment + "/" + .Deployment' | \
                sort > $cache_file

            # Remove the cache file if the curl command fails.
            rm $cache_file
        end
    end &
end

# Erase all existing completions
complete -c terrible_job -e

complete -c terrible_job -n '__terrible_job_needs_command' -x -l server -s s -d 'Which Terrible Server environment to use'
complete -c terrible_job -n '__terrible_job_needs_command' -l verbose -s V -d 'I feel alone. Talk to me more.'
complete -c terrible_job -n '__terrible_job_needs_command' -l superverbose -l vv -d 'I want to listen. Talk contantly. Never stop.'
complete -c terrible_job -n '__terrible_job_needs_command' -x -l terrible-key -s k -d 'Terrible-Key. Better put it into ~/.terrible-job'
complete -c terrible_job -n '__terrible_job_needs_command' -l help -s h -d 'Show help'
complete -c terrible_job -n '__terrible_job_needs_command' -l version -s v -d 'Print the version'

complete -c terrible_job -n '__terrible_job_needs_command' -a go -d 'Execute a job'
complete -c terrible_job -n '__terrible_job_using_command go' -x -l repo -s r -d 'git repository to deploy'
complete -c terrible_job -n '__terrible_job_using_command go' -x -l branch -s b -d 'branch to deploy'
complete -c terrible_job -n '__terrible_job_using_command go' -x -l commit -s c -d 'SHA-1 checksum of commit to deploy'
# complete -c terrible_job -n '__terrible_job_using_command go' -x -l environment -s e -d 'environment to deploy'
complete -c terrible_job -n '__terrible_job_using_command go' -x -l deployment -s D -d 'deployment to deploy'
complete -c terrible_job -n '__terrible_job_using_command go' -x -l duration -s d -d 'how long to run the environment'
complete -c terrible_job -n '__terrible_job_using_command go' -x -l password -s p -d 'ansible vault password'
complete -c terrible_job -n '__terrible_job_using_command go' -x -l password-file -d 'file containing the ansible vault password'
complete -c terrible_job -n '__terrible_job_using_command go' -l force -s f -d 'force, even if the env is not in consistent running state'
complete -c terrible_job -n '__terrible_job_using_command go' -x -l custom-vars -d 'custom vars for this job'

complete -c terrible_job -n '__terrible_job_needs_command' -a destroy -d 'Execute a Destroy job'
complete -c terrible_job -n '__terrible_job_using_command destroy' -x -l repo -s r -d 'git repository to deploy'
complete -c terrible_job -n '__terrible_job_using_command destroy' -x -l branch -s b -d 'branch to deploy'
complete -c terrible_job -n '__terrible_job_using_command destroy' -x -l environment -s e -d 'environment to deploy'

complete -c terrible_job -n '__terrible_job_needs_command' -a list -d 'List all environments'
complete -c terrible_job -n '__terrible_job_using_command list' -a '(__terrible_job_environments)'

complete -c terrible_job -n '__terrible_job_needs_command' -a start -d 'Start enviroment'
complete -c terrible_job -n '__terrible_job_using_command start' -x -l duration -s d -d 'how long to run the environment'
complete -c terrible_job -n '__terrible_job_using_command start' -a '(__terrible_job_environments)'

complete -c terrible_job -n '__terrible_job_needs_command' -a stop -d 'Stop enviroment'
complete -c terrible_job -n '__terrible_job_using_command stop' -a '(__terrible_job_environments)'

complete -c terrible_job -n '__terrible_job_needs_command' -a taint -d 'Force recreation of instances'
# complete -c terrible_job -n '__terrible_job_using_command taint'

complete -c terrible_job -n '__terrible_job_needs_command' -a extend -d 'Extend time until running enviroment will be stopped'
complete -c terrible_job -n '__terrible_job_using_command extend' -x -l duration -s d -d 'how long to run the environment'
complete -c terrible_job -n '__terrible_job_using_command stop' -a '(__terrible_job_environments)'
