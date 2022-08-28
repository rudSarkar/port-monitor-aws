### Port Monitor Cron

This is a implementation with AWS and [PortMonitor](https://github.com/rudSarkar/PortMonitor), This repository has `main.py` which pick specific region ( need to configure manually first time ) EC2 instance public IP and scan for open/filtered port.

### How to setup

Copy the `.env.example` file to `.env` change the information including HackerTargetAPI, Slack Webhook, others configuration as well once it done, Use `docker-compose` to create the container.

```bash
docker-compose up --build -d
```

It will build the multi-container application with 3 different container and 1 network and you can access the mongo-express to 8081 port for checking the database with the credential you provided `ME_CONFIG_BASICAUTH_USERNAME` and `ME_CONFIG_BASICAUTH_PASSWORD` in `.env` file.