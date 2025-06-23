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
