# NodeJS Express App

See also [NodeJS](../application-code-basics/nodejs.md)

Express is a NodeJS framework like Flask is a framework used for Python web applications.

## Project setup

Project structure may look as follows: 

```bash
my-application 
├── LICENSE
├── README.MD
├── package.json # Similar to requirements.txt for python
├── app.js # Similar to app.py or main.py for python
├── tests
├── config
├── routes
├── services
├── db
└── core
```

The app.js contains a sample web application:

```js
//app.js
const express = require('express')
const app = express()

app.get('/products' , (req, res) =>
                res.send(getProductList()))

app.use(express.static(path.join(__dirname, 'public')));

app.listen(3000);
```
Run requirements first `npm install`. It will run the package.json (list of dependencies) and install them.

Afterwards run `node app.js`

However, it may be a that there is defined a specific database for the `Dev` environment, then it'll be listed in the `package.json` file under `scripts`, as the excerpt below show

![img](../imgs/package-json-environment-scripts.png)

npm can then be used to run a specific script in the file.

`npm run start` to run the `start` script.

The start script has teh environment variable set to production. We could also run

`npm run start:dev` to start the development environment.


When it is run, the webserver is listening on localhost `http://localhost:3000/` (port 3000 as specified in app.js).

## Tools for running in production

However, this is not considered best practice. If the application were to crash, Node will simply shut the site down, preventing access to the application for other users.

 + supervisord
 + forever
 + pm2 (P(rocess) M(anager) 2)

pm2 is used in the example. It has built in load balancers.
To run our app with pm2

```bash
# start the application
pm2 start app.js

# start the application with multiple workers (cluster mode)
pm2 start app.js -i 4


### quickstart commands
#Start and Daemonize any application:
pm2 start app.js

#Load Balance 4 instances of api.js:
pm2 start api.js -i 4

#Monitor in production:
pm2 monitor

#Make pm2 auto-boot at server restart:
pm2 startup
```

## Labs

1. "We have installed node for you . Install dependencies with npm and run app.js in /opt/the-example-app.nodejs/ directory with node and observe output if any"

```bash
sudo npm install
# start is part of the scripts in package.json
sudo npm run start 

>example-contentful-theExampleApp-js@0.0.0 start /opt/the-example-app.nodejs
>NODE_ENV=production node ./bin/www
>Listening on http://localhost:3000

# Their solution (mine worked though)
sudo npm install
node app.js
```

2. "Run app in start:dev mode and observe the webpage in Browser"

```bash
npm run start:dev
```

3. "Now stop previous app and Run app in start:production mode and observe the webpage in Browser"

```bash
npm run start:production
```

4. "Now please install pm2 with npm"

```bash
# my solution
npm install pm2

# their solution
sudo npm install pm2@latest -g
```

5. "Run app with pm2 and observe the output in console"

```bash
sudo pm2 start app.js
```

6. "How many forks launched by previous step pm2 execution?"

```bash
# Output from the terminal
>[PM2] Spawning PM2 daemon with pm2_home=/root/.pm2
>[PM2] PM2 Successfully daemonized
>[PM2] Starting /opt/the-example-app.nodejs/app.js in fork_mode (1 instance)
>[PM2] Done.

# my answer 1 (correct)
```

7. "Run app with pm2 but with 4 forks. Observe the output in console. The pm2 process is already running in previous step so stop that process and run with new options"

```bash
# Stop the app (didn't work)
sudo pm2 stop app.js

# Start with 4 instances
sudo pm2 start app.js -i 4

# Their solution
pm2 delete app.js # to delete pm2 form
pm2 start app.js -i 4

```