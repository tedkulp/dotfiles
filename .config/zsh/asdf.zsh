asdf-up() {
    plugin=$1
    cur_version=`asdf current ${plugin} | tr -s ' ' | cut -d ' ' -f 2`
    echo Updating plugin: $plugin version: $cur_version
    asdf uninstall ${plugin} ${cur_version} && asdf install ${plugin} ${cur_version}
}
