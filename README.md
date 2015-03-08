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
