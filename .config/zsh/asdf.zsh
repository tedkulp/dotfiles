asdf-up() {
    plugin=$1
    cur_version=`asdf current ${plugin} | tr -s ' ' | cut -d ' ' -f 2`
    echo Updating plugin: $plugin version: $cur_version
    asdf uninstall ${plugin} ${cur_version} && asdf install ${plugin} ${cur_version}
}

# Stuff for building erlang on Apple ARM
if [ -d "/opt/homebrew/opt/openssl@1.1/lib" ]; then
    export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
    export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-threads --enable-kernel-poll --enable-wx --enable-webview --enable-darwin-64bit --enable-gettimeofday-as-os-system-time --with-ssl=$(brew --prefix openssl@1.1)" KERL_BUILD_DOCS="yes"
fi
