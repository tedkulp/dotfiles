# Open a sqlite database in sqlit: sqlitdb path/to/file.db
sqlitdb() {
  if [[ -z "$1" ]]; then
    echo "usage: sqlitdb <path-to-db>" >&2
    return 1
  fi
  if [[ ! -f "$1" ]]; then
    echo "sqlitdb: no such file: $1" >&2
    return 1
  fi
  sqlit "sqlite://${1:A}"  # ${1:A} is absolute (leading /), giving sqlite:///...
}
