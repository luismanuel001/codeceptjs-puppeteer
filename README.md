# Codeceptjs-Puppeteer Docker

CodeceptJS packed into container with the Puppeteer driver, and other dependencies.

## How to Use

This image comes with the necessary dependencies and packages to execute CodeceptJS tests with Puppeteer.
Mount in your CodeceptJS config directory into the `/tests` directory in the docker container.

Sample mount: `-v $PWD:/tests`

CodeceptJS runner is available inside container as `codeceptjs`.

### Locally

You can execute CodeceptJS with Puppeteer locally with no extra configuration.

```sh
docker run --net=host -v $PWD:/tests lmanuel/codeceptjs-puppeteer
```

To customize execution call `codeceptjs` command:

```sh
# run tests with steps
docker run --net=host -v $PWD:/tests lmanuel/codeceptjs-puppeteer codeceptjs run --steps

# run tests with @user in a name
docker run --net=host -v $PWD:/tests lmanuel/codeceptjs-puppeteer codeceptjs run --grep "@user"
```

You may run use `-v $(pwd)/:tests/` if running this from the root of your CodeceptJS tests directory.
_Note: The output of your test run will appear in your local directory if your output path is `./output` in the CodeceptJS config_

### Build

To build this image:

```sh
docker build -t lmanuel/codeceptjs-puppeteer .
```

* this directory will be added as `/codecept` insde container
* tests directory is expected to be mounted as `/tests`
* `codeceptjs` is a synlink to `/codecept/node_modules/codeceptjs/bin/codecept.js`

### Passing Options

Options can be passed by calling `codeceptjs`:

```
docker run -v $PWD:/tests lmanuel/codeceptjs-puppeteer codeceptjs run --debug
```

Alternatively arguments to `codecept run` command can be passed via `CODECEPT_ARGS` environment variable. For example to run your tests with debug
output:

```yaml
version: '2'
services:
  codeceptjs:
    image: lmanuel/codeceptjs-puppeteer
    environment:
      - CODECEPT_ARGS=--debug
    volumes:
      - .:/tests
```