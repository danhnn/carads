# carads

A platform where Client, Supplier, and Car owners do ads on Car

https://docs.google.com/document/d/1q3ed1mm5h5RALhsckbg3r2xVG_zgCXv0t4ILe-A40lM/edit?usp=sharing

### Installation:

## From scratch:

0. `npm install` : install all dependency needed for project

# Fast way:

1. `npm run setup` : run al step needed to keep our project's infrastructure up and run. (compine step 1 to step 7 in normal way). When running this script it will ask us one question then just choose 1. It will clean all docker stuff related to our app

2. `npm run rest` : run rest server. That script will auto input all params we need for up and run our rest server.

3. `npm run playground` : run playground

4. `npm run web` : run web client in port 8080

# Normal way:

1. `npm run clean-composer` : remove composer folder then we can have fresh installation.

2. `npm run reset-fabric` : fresh setup fabric infrastructure

3. `npm run start-fabric` : bring up fabric infrastructure network  

4. `npm run create-peeradmin` : create peer admin Card, every network need at least one peer admin

5. `npm run init` : archive current source to .bna file then install it to current PeerAdmin with current specific version (0.0.1)

6. `npm run start-network` : start our carads network ( create our network instance ) and also create `admin@carads.card`

7. `npm run import-card` : import our admin carads card that just created in last step.

8. `npm run rest` : run rest server. That script will auto input all params we need for up and run our rest server.

9. `npm run playground` : run playground

10. `npm run web` : run web client in port 8080
# Upgrade current code:

 1. Increase version in package.json file

 2. `npm run upgrade` : create and install new .bna file to current network

 3. As my test, no need to restart rest server but in case something not right, just run `npm run rest` to restart rest server
