# SFTP with SSH keys

The docker image [atmoz/sftp](https://hub.docker.com/r/atmoz/sftp) was used here. 

## SFTP with SSH and password
Post cloning this repo/directory

1. Create directories `keys` and `shared` at the base directory of this repo.
2. Create `.env` file with the below information
```bash
SFTP_USERNAME=<username>
SFTP_PASSWORD=<password>
DATA_STORE=shared
```
   - Note: You can use any name instead of shared as long the same name is added into the env variable `DATA_STORE`.
3. reate the ssh key pairs using the below commands
```bash
ssh-keygen -t ed25519 -f ./keys/ssh_host_ed25519_key < /dev/null
ssh-keygen -t rsa -b 4096 -f ./keys/ssh_host_rsa_key < /dev/null
```
4. Start the service
```bash
docker-compose up -d
```  
5. Login (it will prompt for the password)
```bash
sftp -P 2222 -i ./keys/ssh_host_ed25519_key -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null <username>@localhost
```
6. Once done the services can be stopped via
```bash
docker-compose down
```

## SFTP with SSH without password
There are two ways to do this 
- After following the steps 1 - 3 detailed above:
  1. Remove the env variable `SFTP_PASSWORD` from the `.env` file. 
  2. Adjust the `command` inside the `docker-compose.yml` to:
   - `- ${SFTP_USERNAME}::1001::${DATA_STORE}`
  3. Login using the same `sftp` command as shown above. This time the password will not be prompted.

- Else we can first create the directories and the keys (by following steps 1 & 3), and then starting the service like:
  ```bash
    docker run \
        -d --rm --name sshftp \
        -v $PWD/keys/ssh_host_ed25519_key:/etc/ssh/ssh_host_ed25519_key \
        -v $PWD/keys/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key \
        -v $PWD/keys/ssh_host_ed25519_key.pub:/home/foo/.ssh/keys/ssh_host_ed25519_key.pub:ro \
        -v $PWD/keys/ssh_host_rsa_key.pub:/home/foo/.ssh/keys/ssh_host_rsa_key.pub:ro \
        -v $PWD/shared:/home/foo/share \
        -p 2222:22 atmoz/sftp:latest foo::1001
  ```
  In this instance `foo` is username, but can be replaced with any other name. Then we can login using the same `sftp` command as shown above.