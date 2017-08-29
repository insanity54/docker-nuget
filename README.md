# Docker NuGet Feed

This project provides a NuGet feed based on the [simple-nuget-server](https://github.com/Daniel15/simple-nuget-server/) project. It also uses the official PHP and nginx docker images.

The corresponding docker image is `insanity54/docker-nuget` and can be found [here](https://hub.docker.com/r/insanity54/docker-nuget/).


## Quickstart

```bash
git clone --recursive https://github.com/insanity54/docker-nuget
docker-compose up

# OR for production use--

docker-compose -f ./docker-compose.yml -f ./production.yml up -d
```

### Environment configuration

Make your changes in docker-compose.yml


## NuGet configuration

In order to push a package to your new NuGet feed, use the following command:

```bash
nuget push -Source http://url.to/your/feed/ -ApiKey <your secret> path/to/package.nupkg
```

Deleting package version `<Version>` of package `<Package>` is done using

```bash
nuget delete -Source http://url.to/your/feed/ -ApiKey <your secret> <Package> <Version>
```

Listing packages including prereleases can be done using

```bash
nuget list -Source http://url.to/your/feed/ -Prerelease
```

You can add your feed to a specific `NuGet.config` file using:

```bash
nuget sources add -Name "Your Feed's Name" -Source http://url.to/your/feed/ -ConfigFile NuGet.config
```

In order to store the API key in a specifig `NuGet.config` file you can use:

```bash
nuget setapikey -Source http://url.to/your/feed/ -ConfigFile NuGet.config
```

This will create or update the `apikeys` section of your configuration file. Make sure to not check anything sensitive into source control.

In both cases, if you omit the `-ConfigFile <file>` option, your user configuration file will be used.