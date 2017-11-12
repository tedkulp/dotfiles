ksr() { knife ssh "role:$1" $2 -x root -a ipaddress }
ksn() { knife ssh "name:$1" $2 -x root -a ipaddress }
ksa() { knife ssh "name:*" $1 -x root -a ipaddress -C 1 }
ksac() { knife ssh "name:*" $1 -x root -a ipaddress }
kua() { ksa "chef-client" }
kuac() { ksac "chef-client" }
kur() { ksr $1 "chef-client" }
