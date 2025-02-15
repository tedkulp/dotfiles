alias strip-ansi="perl -pe 's/\e\[[0-9;]*m(?:\e\[K)?//g'"
alias format-csv="perl -pe 's/((?<=,)|(?<=^)),/ ,/g;' | column -t -s,"
