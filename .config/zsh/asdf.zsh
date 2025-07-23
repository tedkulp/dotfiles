export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export KERL_BUILD_DOCS="yes"
export KERL_CONFIGURE_OPTIONS="--without-javac --without-wx --without-odbc --enable-threads --enable-kernel-poll --enable-webview --enable-gettimeofday-as-os-system-time"

asdf-up() {
    plugin=$1
    cur_version=`asdf current ${plugin} | tr -s ' ' | cut -d ' ' -f 2`
    echo Updating plugin: $plugin version: $cur_version
    asdf uninstall ${plugin} ${cur_version} && asdf install ${plugin} ${cur_version}
}



# asdf_clean_unused() {
#   local plugin=$1
#   local dry_run=0
#   local search_dir=~/src
#   local usage="Usage: asdf_clean_unused <plugin> [--dry-run] [--dir=/path/to/search]"

#   if [[ -z "$plugin" ]]; then
#     echo "$usage"
#     return 1
#   fi

#   # Parse flags
#   shift
#   while [[ $# -gt 0 ]]; do
#     case "$1" in
#       --dry-run)
#         dry_run=1
#         ;;
#       --dir=*)
#         search_dir="${1#--dir=}"
#         ;;
#       *)
#         echo "Unknown option: $1"
#         echo "$usage"
#         return 1
#         ;;
#     esac
#     shift
#   done

#   # Ensure `fd` is available
#   if ! command -v fd &>/dev/null; then
#     echo "Error: 'fd' is not installed or not in your PATH."
#     echo "Install it with 'brew install fd' or 'apt install fd-find'"
#     return 1
#   fi

#   # Use associative array to track in-use versions
#   local -A seen_versions

#   # Parse all .tool-versions files in the specified directory
#   while IFS= read -r file; do
#     while IFS= read -r line || [[ -n "$line" ]]; do
#       [[ -z "$line" || "$line" == \#* ]] && continue
#       local tool_and_versions=(${(z)line})  # Zsh-specific word splitting
#       local tool="${tool_and_versions[1]}"
#       if [[ "$tool" == "$plugin" ]]; then
#         for version in "${tool_and_versions[@]:1}"; do
#           seen_versions["$version"]=1
#         done
#       fi
#     done < "$file"
#   done < <(fd .tool-versions "$search_dir")

#   # Add active version(s) from `asdf list`
#   local versions
#   versions=$(asdf list "$plugin")

#   while IFS= read -r line; do
#     [[ -z "$line" ]] && continue
#     local cleaned="${line#"${line%%[![:space:]]*}"}"
#     cleaned="${cleaned%"${cleaned##*[![:space:]]}"}"
#     cleaned="${cleaned#"*"}"
#     seen_versions["$cleaned"]=1
#   done <<< "$versions"

#   # Uninstall any version not marked as seen
#   echo "$versions" | while IFS= read -r line; do
#     [[ -z "$line" ]] && continue
#     local version="${line#"${line%%[![:space:]]*}"}"
#     version="${version%"${version##*[![:space:]]}"}"
#     version="${version#"*"}"

#     if [[ -n "${seen_versions[$version]}" ]]; then
#       echo "Skipping in-use version: $version"
#     else
#       if [[ "$dry_run" -eq 1 ]]; then
#         echo "[Dry Run] Would uninstall $plugin version: $version"
#       else
#         echo "Uninstalling $plugin version: $version"
#         asdf uninstall "$plugin" "$version"
#       fi
#     fi
#   done
# }

export KERL_CONFIGURE_OPTIONS="$KERL_CONFIGURE_OPTIONS --enable-darwin-64bit"

# export CXXFLAGS="-ffat-lto-objects"
# export CFLAGS="-O2 -ffat-lto-objects"
export CFLAGS=""
export LDFLAGS=""

if which brew > /dev/null; then
  blah=`brew --prefix openssl > /dev/null`
  if [ $? -eq 0 ]; then
    export CFLAGS="$CFLAGS -I$(brew --prefix openssl)/include"
    export LDFLAGS="$LDFLAGS -L$(brew --prefix openssl)/lib"
  fi
fi

# uv
export PATH="$HOME/.local/bin:$PATH"

# Stuff for building erlang on Apple ARM
# if [ -d "/opt/homebrew/opt/openssl@1.1/lib" ]; then
#     export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
#     export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
#     export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-threads --enable-kernel-poll --enable-wx --enable-webview --enable-darwin-64bit --enable-gettimeofday-as-os-system-time --with-ssl=$(brew --prefix openssl@1.1)" KERL_BUILD_DOCS="yes"
# fi

# Remove unused asdf plugin versions, with optional --dry-run, --dir, and --verbose
asdf_clean_unused_versions() {
  local plugin=$1
  local dry_run=0
  local verbose=0
  local search_dir=~/src

  # Parse flags
  shift
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run)
        dry_run=1
        ;;
      --verbose)
        verbose=1
        ;;
      --dir=*)
        search_dir="${1#--dir=}"
        ;;
      *)
        echo "Unknown option: $1"
        return 1
        ;;
    esac
    shift
  done

  # Collect all in-use versions from .tool-versions files
  local -A in_use_versions
  local -A version_sources
  if command -v fd &>/dev/null; then
    while IFS= read -r file; do
      while IFS= read -r line || [[ -n "$line" ]]; do
        [[ -z "$line" || "$line" == \#* ]] && continue
        local arr=(${(z)line})
        [[ "${arr[1]}" != "$plugin" ]] && continue
        for v in "${arr[@]:1}"; do
          # Normalize the version completely before using as key
          local normalized_v="${v//[\"']/}"
          normalized_v="${normalized_v#"${normalized_v%%[![:space:]]*}"}"
          normalized_v="${normalized_v%"${normalized_v##*[![:space:]]}"}"
          in_use_versions["$normalized_v"]=1
          version_sources["$normalized_v"]+="$file\n"
        done
      done < "$file"
    done < <(fd .tool-versions "$search_dir")
  fi

  if [[ $verbose -eq 1 ]]; then
    echo "Versions found in .tool-versions files for $plugin:"
    for v in ${(k)in_use_versions}; do
      echo "  $v"
      local IFS=$'\n'
      for src in ${(f)version_sources[$v]}; do
        echo "    found in: $src"
      done
    done
  fi

  # Now process asdf list
  asdf list "$plugin" | while read -r line; do
    local trimmed="${line#"${line%%[![:space:]]*}"}"
    trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
    local version="${trimmed//\*/}"
    version="${version//[\"']/}"
    version="${version#"${version%%[![:space:]]*}"}"
    version="${version%"${version##*[![:space:]]}"}"
    if [[ "$trimmed" == *"*"* || -n "${in_use_versions[\"$version\"]}" ]]; then
      echo "Skipping in-use version: $trimmed"
    elif [[ -n "$trimmed" ]]; then
      if [[ $dry_run -eq 1 ]]; then
        echo "[Dry Run] Would uninstall $plugin $version"
      else
        echo "Uninstalling $plugin $version"
        asdf uninstall "$plugin" "$version"
      fi
    fi
  done
}

