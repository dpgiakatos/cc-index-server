# Common Crawl Index Server

This project is a deployment of the [pywb](https://github.com/webrecorder/pywb) web archive replay and index server to provide
an index query mechanism for datasets provided by [Common Crawl](https://commoncrawl.org)

We depend on a fork of pywb, [maintained on this branch](https://github.com/commoncrawl/pywb/tree/common-crawl-cdx-index). It is a modified version of PyWB (pywb>=2.5.0), which is API compatible with PyWB 0.33.2.

## Usage & Installation
To run locally, please install with `pip install -r requirements.txt`

Common Crawl stores data on Amazon S3 and the data can be accessed via s3 or https. Access to CC data using s3 api is restricted to [authenticated](https://docs.aws.amazon.com/accounts/latest/reference/credentials-access-keys-best-practices.html) AWS users.

Currently, individual indexes for each crawl can be accessed under: `https://data.commoncrawl.org/commoncrawl/cc-index/collections/[CC-MAIN-YYYY-WW]` or `s3://commoncrawl/cc-index/collections/[CC-MAIN-YYYY-WW]`

Most of the index will be served from S3, however, a smaller secondary index must be installed locally for each collection.

This can be done automatically by running: `install-collections.sh` which will install all available collections locally.

If successful, there should be `collections` directory with at least one index.

To run, simply run `cdx-server` to start up the index server, or optionally `wayback`, to run pywb replay system along with the cdx server.


### Running with docker

If you have docker installed in your system, you can run index server with docker itself.

```sh
git clone https://github.com/dpgiakatos/cc-index-server.git
cd cc-index-server
./install-collections.sh # optional/one time - big download of data to local collections folder...
docker build . -t cc-index
docker run -v $PWD/collections/:/opt/webapp/collections/ --publish 8080:8080 -ti cc-index
```

You can use `install-collections.sh` to download indexes to your system and mount it on docker.


## CDX Server API

The API endpoints correspond to existing index collections in collections directory.

For example, one currently available index is `CC-MAIN-2025-13` and it can be accessed via

`http://localhost:8080/CC-MAIN-2025-13-index?url=commoncrawl.org`


Refer to [CDX Server API](https://github.com/webrecorder/pywb/wiki/CDX-Server-API) for more detailed instructions on the API itself.

The pywb [README](https://github.com/webrecorder/pywb/blob/master/README.rst) provides additional information about pywb.


## Building the Index

Please see the [webarchive-indexing](https://github.com/ikreymer/webarchive-indexing) repository for more info on how the index is built.
