# SSH Port Forwarding Proxy Client
- https://github.com/aoirint/SSHPortForwardingProxy

## Image Build
```shell
docker-compose build
```

## Usage
1. Add your private key to `/private_keys/myuser`. And add your public key to [SSHPortForwardingProxy](https://github.com/aoirint/SSHPortForwardingProxy) server.
2. Copy `docker-compose.override.yml.template` to `docker-compose.override.yml` and change the configuration.
3. Execute `docker-compose up -d`.
4. Execute `docker-compose down` to close the ssh client.
