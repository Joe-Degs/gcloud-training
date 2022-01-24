# Getting Started With Cloud Shell and gcloud
- list active account

    `$ gcloud auth list`

- list project ID

    `$ gcloud config list project`

- set project ID

    `$ gcloud config set project <id>`

- list default region and zone settings

    ```console
    $ gcloud config get-value compute/zone
    $ gcloud config get-value compute/region
    ```