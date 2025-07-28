# About Inception

Inception is a system administration and virtualization project designed to introduce the fundamentals of Docker, container orchestration, and service security. The objective is to set up a personal server using Docker and Docker Compose, hosting multiple services like Nginx, WordPress, and MariaDB—all isolated in their own containers and communicating over a custom Docker network.

Each service must be configured securely and independently, using Dockerfiles (no pre-built images) and ensuring data persistence with named volumes. The project mimics real-world web infrastructure deployment, encouraging best practices in DevOps, such as secure credential storage, service decoupling, and HTTPS encryption.

The final setup must be production-ready, modular, and resilient, running inside a Virtual Machine provided by 42.

<br>


## 🟠 Execution:

Start the entire stack using:
```
make
```

This command will initialize your Docker environment, build all necessary containers, and prepare the infrastructure for execution.


<br>

| Service        | Expected result / Description                          |
| :------------- | :----------------------------------------------------- |
| Nginx          | Serves static content and acts as a reverse proxy with HTTPS |
| WordPress      | Fully working WordPress site connected to the database |
| MariaDB        | Stores WordPress data in a persistent volume           |
| Redis (optional)   | Adds caching layer to improve WordPress performance |
| Adminer (optional) | Web UI to interact with MariaDB for debugging       |
| Portainer (optional) | GUI to manage Docker containers and volumes       |
| FTP (optional) | FTP server configured securely with restricted access   |

<br>

## ✅ Project Requirements

- All services must run in separate containers built from scratch using Dockerfiles.
- Use **Docker volumes** to persist data (MariaDB and WordPress).
- SSL certificates must be set up (either self-signed or via Let’s Encrypt).
- Services must be configured through environment variables using a `.env` file.
- Custom Docker network must be used to isolate services.
- Containers should restart on failure or VM reboot.
- No pre-built Docker Hub images are allowed (except for base OS images like Debian or Alpine).

<br>

##

### 🔄 You may also like...

[-> My profile on the 42 Intranet](https://profile.intra.42.fr/users/tu-usuario)

[-> My LinkedIn profile](https://www.linkedin.com/in/tu-usuario/)
