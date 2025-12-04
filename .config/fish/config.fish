if status is-interactive
	set -x PATH $PATH $HOME/mkp/target/debug/
	starship init fish | source
	clear && neofetch
    # Commands to run in interactive sessions can go here
end
