ecsInstances() {
    cluster=$1
    profile=${2:-default}
    aws ecs list-container-instances --cluster $cluster --profile $profile | jq -r '.containerInstanceArns | join(" ")'
}

ecsInstanceInfo() {
    cluster=$1
    profile=${2:-default}
    instances=(`ecsInstances $cluster $profile`)
    aws ecs describe-container-instances --cluster $cluster --profile $profile --container-instances $instances[@]
}

ecsInstanceIds() {
    cluster=$1
    profile=${2:-default}
    ecsInstanceInfo $cluster $profile | jq -r '.containerInstances[].ec2InstanceId'
}

xecsSsh() {
    cluster=$1
    profile=${2:-default}
    user=${3:-"ec2-user"}
    # KEYS=(`find ~/.ssh/*$profile*.pem | xargs -I {} echo "-i {}" | xargs`)
    KEYS=(`find ~/.ssh/$profile.pem | xargs -I {} echo "-i {}" | xargs`)
    echo $KEYS
    CMD="xpanes -tsc \"SSM_PROFILE=$profile autossh -M 0 ${KEYS[@]} -o ServerAliveInterval=60 -o StrictHostKeyChecking=no $user@{}\" $(ecsInstanceIds $cluster $profile | xargs)"
    eval $CMD
}

