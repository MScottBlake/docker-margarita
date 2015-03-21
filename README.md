# docker-margarita

A Docker container for running [Margarita](https://github.com/jessepeterson/margarita), a web front-end for [Reposado](https://github.com/wdas/reposado).


# Usage Examples

## Example #1 - Basic

```bash
docker run --name margarita -d -p 8089:8089 mscottblake/margarita
```

## Example #2 - Using port 80

```bash
docker run --name margarita -d -p 80:8089 mscottblake/margarita
```

## Example #3 - Custom preferences.plist

By default, `LocalCatalogURLBase` is empty, so the updates aren't really being downloaded, just their metadata. To host the updates on-site, you need to specify a value for this variable. Any optional keys (`AppleCatalogURLs`, `PreferredLocalizations`, etc.) need to be loaded in this manner as well.

```bash
docker run --name margarita -d -p 8089:8089 -v /path/to/reposado/preferences.plist:/margarita/preferences.plist mscottblake/margarita
```

## Example #4 - Link to an existing reposado container

This example assumes the existence of a container named `reposado` from [mscottblake/reposado](https://registry.hub.docker.com/u/mscottblake/reposado/).

```bash
docker run --name margarita --volumes-from reposado -d -p 8089:8089 -v /path/to/reposado/preferences.plist:/margarita/preferences.plist mscottblake/margarita
```

## Example #5 - Add Basic Authentication

Authentication can be added by overriding `/margarita/auth.conf` with the `-v` flag. Contents of `auth.conf`:

```conf
<Location />
  AuthType Basic
  AuthName "Authentication Required"
  AuthUserFile "/margarita/.htpasswd"
  Require valid-user
</Location>
```

```bash
docker run --name margarita -d -p 8089:8089 -v /path/to/auth.conf:/margarita/auth.conf -v /path/to/valid-users:/margarita/.htpasswd mscottblake/margarita
```

Alternatively, the `.htpasswd` file could be created once the container has been created.

```bash
docker run --name margarita -d -p 8089:8089 -v /path/to/auth.conf:/margarita/auth.conf mscottblake/margarita

docker exec -it margarita htpasswd -c /margarita/.htpasswd USERNAME_1

docker exec -it margarita htpasswd /margarita/.htpasswd USERNAME_2
```

More examples of authentication blocks can be found in [GitHub](https://github.com/MScottBlake/docker-margarita/blob/master/auth.conf)
