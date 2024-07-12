## Docker Project 01

## Part 1: Creating a Container from a Pulled Image

Steps:
Pull the Nginx Image:

```bash
docker pull nginx
```

Run the Nginx Container:

```bash
docker run --name my-nginx -d -p 8080:80 nginx
```
--name my-nginx: Assigns a name to the container.
-d: Runs the container in detached mode.
-p 8080:80: Maps port 8080 on your host to port 80 in the container.
Verify the Container is Running:

```
docker ps
```
![alt text](<image/Screenshot from 2024-07-11 10-19-13.png>)

Visit http://localhost:8080 in your browser. You should see the Nginx welcome page.

![alt text](<image/Screenshot from 2024-07-11 10-23-01.png>)

## Part 2: Modifying the Container and Creating a New Image

Steps:
Access the Running Container:

```bash
docker exec -it my-nginx /bin/bash
```

Create a Custom HTML Page:

```bash
echo "<html><body><h1>Hello from Docker!</h1></body></html>" > /usr/share/nginx/html/index.html
```

Exit the Container:

```
exit
```

Commit the Changes to Create a New Image:

```bash
docker commit my-nginx custom-nginx
```

Run a Container from the New Image:

```bash
docker run --name my-custom-nginx -d -p 8081:80 custom-nginx
```
![alt text](<image/Screenshot from 2024-07-11 10-25-35.png>)

Verify the New Container:
Visit http://localhost:8081 in your browser. You should see your custom HTML page.

![alt text](<image/Screenshot from 2024-07-11 10-23-17.png>)

## Part 3: Creating a Dockerfile to Build and Deploy a Web Application

Steps:
Create a Project Directory:

```bash
mkdir my-webapp
cd my-webapp
```

Create a Simple Web Application:
Create an index.html file:

```bash
<!DOCTYPE html>
<html>
<body>
    <h1>Hello from My Web App!</h1>
</body>
</html>
```

Save this file in the my-webapp directory.
Write the Dockerfile:
Create a Dockerfile in the my-webapp directory with the following content:

```bash
#Use the official Nginx base image
FROM nginx:latest

#Copy the custom HTML file to the appropriate location
COPY index.html /usr/share/nginx/html/

#Expose port 80
EXPOSE 80
```

Build the Docker Image:

```bash
docker build -t my-webapp-image .
```
![alt text](<image/Screenshot from 2024-07-11 10-29-03.png>)

Run a Container from the Built Image:

```bash
docker run --name my-webapp-container -d -p 8082:80 my-webapp-image
```

Verify the Web Application:
Visit http://localhost:8082 in your browser. You should see your custom web application.

![alt text](<image/Screenshot from 2024-07-11 10-29-56.png>)

## Part 4: Cleaning Up

Steps:
Stop and Remove the Containers:

```bash
docker stop my-nginx my-custom-nginx my-webapp-container
docker rm my-nginx my-custom-nginx my-webapp-container
```
Remove the Images:

```bash
docker rmi nginx custom-nginx my-webapp-image
```
![alt text](<image/Screenshot from 2024-07-11 10-31-59.png>)

## Docker Project 02

## Part 1: Setting Up the Project Structure

Steps:
Create the Project Directory:

```bash
mkdir fullstack-docker-app
cd fullstack-docker-app
```

Create Subdirectories for Each Service:

```bash
mkdir frontend backend database
```

Create Shared Network and Volume:
Docker allows communication between containers through a shared network.

```bash
docker network create fullstack-network
```

Create a volume for the PostgreSQL database.

```bash
docker volume create pgdata
```
![alt text](<image/Screenshot from 2024-07-11 10-39-54.png>)

## Part 2: Setting Up the Database

Steps:
Create a Dockerfile for PostgreSQL:
In the database directory, create a file named Dockerfile with the following content:

```bash
FROM postgres:latest
ENV POSTGRES_USER=user
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=mydatabase
```

Build the PostgreSQL Image:

```bash
cd database
docker build -t my-postgres-db .
cd ..
```
![alt text](<image/Screenshot from 2024-07-11 10-51-55.png>)

Run the PostgreSQL Container:

```bash
docker run --name postgres-container --network fullstack-network -v pgdata:/var/lib/postgresql/data -d my-postgres-db
```

## Part 3: Setting Up the Backend (Node.js with Express)

Steps:
Initialize the Node.js Application:

```bash
cd backend
npm init -y
```

Install Express and pg (PostgreSQL client for Node.js):

```bash
npm install express pg
```

Create the Application Code:
In the backend directory, create a file named index.js with the following content:

```bash
const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

const pool = new Pool({
    user: 'user',
    host: 'postgres-container',
    database: 'mydatabase',
    password: 'password',
    port: 5432,
});

app.get('/', (req, res) => {
    res.send('Hello from Node.js and Docker!');
});

app.get('/data', async (req, res) => {
    const client = await pool.connect();
    const result = await client.query('SELECT NOW()');
    client.release();
    res.send(result.rows);
});

app.listen(port, () => {
    console.log(`App running on http://localhost:${port}`);
});
```

Create a Dockerfile for the Backend:
In the backend directory, create a file named Dockerfile with the following content:

```bash
FROM node:latest

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
```

Build the Backend Image:

```bash
docker build -t my-node-app .
cd ..
```
![alt text](<image/Screenshot from 2024-07-11 10-58-23.png>)

Run the Backend Container:

```bash
docker run --name backend-container --network fullstack-network -d my-node-app
```

## Part 4: Setting Up the Frontend (Nginx)

Steps:
Create a Simple HTML Page:
In the frontend directory, create a file named index.html with the following content:

```bash
<!DOCTYPE html>
<html>
<body>
    <h1>Hello from Nginx and Docker!</h1>
    <p>This is a simple static front-end served by Nginx.</p>
</body>
</html>
```

Create a Dockerfile for the Frontend:
In the frontend directory, create a file named Dockerfile with the following content:

```bash
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
```

Build the Frontend Image:

```bash
cd frontend
docker build -t my-nginx-app .
cd ..
```
![alt text](<image/Screenshot from 2024-07-11 11-02-19.png>)

Run the Frontend Container:

```bash
docker run --name frontend-container --network fullstack-network -p 8080:80 -d my-nginx-app
```

## Part 5: Connecting the Backend and Database

Steps:
Update Backend Code to Fetch Data from PostgreSQL:
Ensure that the index.js code in the backend handles /data endpoint correctly as written above.
Verify Backend Communication:
Access the backend container:

```bash
docker exec -it backend-container /bin/bash
```

Test the connection to the database using psql:

```bash
apt-get update && apt-get install -y postgresql-client
psql -h postgres-container -U user -d mydatabase -c "SELECT NOW();"
```

Exit the container:

```
exit
```
![alt text](<image/Screenshot from 2024-07-11 12-12-36.png>)

Test the Backend API:
Visit http://localhost:3000 to see the basic message.
Visit http://localhost:3000/data to see the current date and time fetched from PostgreSQL.

## Part 6: Final Integration and Testing
Steps:
Access the Frontend:
Visit http://localhost:8080 in your browser. You should see the Nginx welcome page with the custom HTML.
Verify Full Integration:
Update the index.html to include a link to the backend:

```bash
<!DOCTYPE html>
<html>
<body>
    <h1>Hello from Nginx and Docker!</h1>
    <p>This is a simple static front-end served by Nginx.</p>
    <a href="http://localhost:3000/data">Fetch Data from Backend</a>
</body>
</html>
```

Rebuild and Run the Updated Frontend Container:

```bash
cd frontend
docker build -t my-nginx-app .
docker stop frontend-container
docker rm frontend-container
docker run --name frontend-container --network fullstack-network -p 8080:80 -d my-nginx-app
cd ..
```
![alt text](<image/Screenshot from 2024-07-11 12-20-17.png>)

Final Verification:
Visit http://localhost:8080 and click the link to fetch data from the backend.

![alt text](<image/Screenshot from 2024-07-11 12-19-24.png>)

## Part 7: Cleaning Up

Steps:
Stop and Remove the Containers:

```bash
docker stop frontend-container backend-container postgres-container
docker rm frontend-container backend-container postgres-container
```

Remove the Images:

```bash
docker rmi my-nginx-app my-node-app my-postgres-db
```

Remove the Network and Volume:

```bash
docker network rm fullstack-network
docker volume rm pgdata
```