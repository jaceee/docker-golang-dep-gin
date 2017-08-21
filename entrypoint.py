#!/usr/bin/env python

import os

goSrc   = "/go/src"
root    = os.path.join(goSrc, "app")
verbose = os.environ['VERBOSE'] == "true"
appName = os.environ['APP_NAME']
appPort = os.environ['APP_PORT']
ginPort = os.environ['PROXY_PORT']
appPath = os.path.join(goSrc, appName)

# link if app is not called app
if root != appPath:
    if not (os.path.islink(appPath)):
        os.link(root, appPath)
        # os.symlink(root, link)

commands = []

cd = "cd %s" % appPath
commands.append(cd)

dep = "dep ensure"
if verbose:
    dep += " -v"
commands.append(dep)

gin_args = " ".join([
    "--laddr=\"0.0.0.0\"",
    "--port=\"%s\"" % ginPort,
    "--appPort=\"%s\"" % appPort,
])
gin = "gin %s run main.go" % gin_args
commands.append(gin)

for command in commands:
    print "running '" + command + "'..."
    if os.system(command) == 0:
        continue
    else:
        print "ERROR"
        exit(1)
