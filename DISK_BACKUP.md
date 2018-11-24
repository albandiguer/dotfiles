
# Photos/Videos

## Public/Family/Friends
Flickr has up to 1000 photos hosting for free, it's good for public/family sharing.

Youtube has unlimited video storage

## Private
Arq has a one-off fee of 49 USD and let you sync data to various cloud providers.
S3/Glacier can be picked to store raw images and unshared pictures over long period
of times
https://www.arqbackup.com/pricing/

We can couple that to trovebox client, open source software that lets you interact
with s3 to upload/view pics in buckets

Note that we cannot recycle  existing buckets into trovebox client (not very practical)

We could also upload content via cli and develop a quick UI to be able to view the content
of the bucket (Haskell s3 bindings?)

s3 fuse: https://cloud.netapp.com/blog/amazon-s3-as-a-file-system
