# exit if not in interactive
status is-interactive || exit

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# Export environment variables
set -gx ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY latest_installed
set -gx ASDF_GOLANG_MOD_VERSION_ENABLED true
set -gx KERL_BUILD_DOCS yes
set -gx KERL_CONFIGURE_OPTIONS "--without-javac --without-wx --without-odbc --enable-threads --enable-kernel-poll --enable-webview --enable-gettimeofday-as-os-system-time"

# Function to update ASDF plugin version
function asdf-up
    set -l plugin $argv[1]
    set -l cur_version (asdf current $plugin | tr -s ' ' | cut -d ' ' -f 2)
    echo "Updating plugin: $plugin version: $cur_version"
    asdf uninstall $plugin $cur_version; and asdf install $plugin $cur_version
end

# Append to existing KERL_CONFIGURE_OPTIONS
set -gx KERL_CONFIGURE_OPTIONS "$KERL_CONFIGURE_OPTIONS --enable-darwin-64bit"

# Compiler flags
set -gx CFLAGS ""
set -gx LDFLAGS ""

# Check if Homebrew is installed and configure OpenSSL paths
if command -v brew >/dev/null
    set -l openssl_prefix (brew --prefix openssl 2> /dev/null)
    if test -n "$openssl_prefix"
        set -gx CFLAGS "$CFLAGS -I$openssl_prefix/include"
        set -gx LDFLAGS "$LDFLAGS -L$openssl_prefix/lib"
    end
end

# Stuff for building Erlang on Apple ARM (commented out)
# if test -d "/opt/homebrew/opt/openssl@1.1/lib"
#     set -gx LDFLAGS "-L/opt/homebrew/opt/openssl@1.1/lib"
#     set -gx CPPFLAGS "-I/opt/homebrew/opt/openssl@1.1/include"
#     set -gx KERL_CONFIGURE_OPTIONS "--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-threads --enable-kernel-poll --enable-wx --enable-webview --enable-darwin-64bit --enable-gettimeofday-as-os-system-time --with-ssl=(brew --prefix openssl@1.1)"
#     set -gx KERL_BUILD_DOCS "yes"
# end
