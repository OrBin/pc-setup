# Running `bash -c 'hstr --show-configuration'` or `zsh -c 'hstr --show-configuration'` removes the shell we try to run,
# which makes the shell we run from (our default shell) become the parent of `hstr` process.
# Since `hstr` checks the parent shell to find out which shell is running it, running `bash -c` or `zsh -c` won't
# provide the desired result, therefore we need this script as a workaround.
hstr --show-configuration
