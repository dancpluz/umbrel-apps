#!/bin/sh

# This file is a template for docker compose deployment
# Copy this file to .env and change the values as needed

# Fully qualified domain name for the deployment. Replace appflowy.localhost with your domain,
# such as mydomain.com.
export FQDN="localhost"
# Change this to https if you wish to enable TLS.
export SCHEME="http"
# If this has changed, AppFlowy Web might still use the old value due to Javascript cache.
# If AppFlowy Web is sending requests to the wrong URL, do a hard reload on the browser,
# and/or purge Cloudflare cache if you are using CloudFlare.
export APPFLOWY_BASE_URL="${SCHEME}://${FQDN}"

# PostgreSQL Settings
export POSTGRES_HOST="postgres"
export POSTGRES_USER="postgres"
export POSTGRES_PASSWORD="password"
export POSTGRES_PORT="5432"
export POSTGRES_DB="postgres"

# Postgres credential for supabase_auth_admin
export SUPABASE_PASSWORD="root"

# Redis Settings
export REDIS_HOST="redis"
export REDIS_PORT="6379"

# Minio Host
export MINIO_HOST="minio"
export MINIO_PORT="9000"

export AWS_ACCESS_KEY="minioadmin"
export AWS_SECRET="minioadmin"

# AppFlowy Cloud
## URL that connects to the gotrue docker container
export APPFLOWY_GOTRUE_BASE_URL="http://gotrue:9999"
## URL that connects to the postgres docker container. If your password contains special characters, instead of using ${POSTGRES_PASSWORD},
## you will need to convert them into url encoded format. For example, `p@ssword` will become `p%40ssword`.
export APPFLOWY_DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"
export APPFLOWY_ACCESS_CONTROL="true"
export APPFLOWY_WEBSOCKET_MAILBOX_SIZE="6000"
export APPFLOWY_DATABASE_MAX_CONNECTIONS="40"
## URL that connects to the redis docker container
export APPFLOWY_REDIS_URI="redis://${REDIS_HOST}:${REDIS_PORT}"

# admin frontend
## URL that connects to redis docker container
export ADMIN_FRONTEND_REDIS_URL="redis://${REDIS_HOST}:${REDIS_PORT}"
## URL that connects to gotrue docker container
export ADMIN_FRONTEND_GOTRUE_URL="http://gotrue:9999"
## URL that connects to the cloud docker container
export ADMIN_FRONTEND_APPFLOWY_CLOUD_URL="http://appflowy_cloud:8000"
## Base Url for the admin frontend. If you use the default Nginx conf provided here, this value should be /console.
## If you want to keep the previous behaviour where admin frontend is served at the root, don't set this env variable,
## or set it to empty string.
export ADMIN_FRONTEND_PATH_PREFIX="/console"

# authentication key, change this and keep the key safe and secret
# self defined key, you can use any string
export GOTRUE_JWT_SECRET="hello456"
# Expiration time in seconds for the JWT token
export GOTRUE_JWT_EXP="7200"

# User sign up will automatically be confirmed if this is set to true.
# If you have OAuth2 set up or smtp configured, you can set this to false
# to enforce email confirmation or OAuth2 login instead.
# If you set this to false, you need to either set up SMTP
export GOTRUE_MAILER_AUTOCONFIRM="true"
# Number of emails that can be per minute
export GOTRUE_RATE_LIMIT_EMAIL_SENT="100"

# If you intend to use mail confirmation, you need to set the SMTP configuration below
# You would then need to set GOTRUE_MAILER_AUTOCONFIRM=false
# Check for logs in gotrue service if there are any issues with email confirmation
# Note that smtps will be used for port 465, otherwise plain smtp with optional STARTTLS
export GOTRUE_SMTP_HOST="smtp.gmail.com"
export GOTRUE_SMTP_PORT="465"
export GOTRUE_SMTP_USER="email_sender@some_company.com"
export GOTRUE_SMTP_PASS="email_sender_password"
export GOTRUE_SMTP_ADMIN_EMAIL="comp_admin@some_company.com"

# This user will be created when GoTrue starts successfully
# You can use this user to login to the admin panel
export GOTRUE_ADMIN_EMAIL="admin@example.com"
export GOTRUE_ADMIN_PASSWORD="password"

# Set this to true if users can only join by invite
export GOTRUE_DISABLE_SIGNUP="false"

# External URL where the GoTrue service is exposed.
export API_EXTERNAL_URL="${APPFLOWY_BASE_URL}/gotrue"

# GoTrue connect to postgres using this url. If your password contains special characters,
# replace ${SUPABASE_PASSWORD} with the url encoded version. For example, `p@ssword` will become `p%40ssword`
export GOTRUE_DATABASE_URL="postgres://supabase_auth_admin:${SUPABASE_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"

# Refer to this for details: https://github.com/AppFlowy-IO/AppFlowy-Cloud/blob/main/doc/AUTHENTICATION.md
# Google OAuth2
export GOTRUE_EXTERNAL_GOOGLE_ENABLED="false"
export GOTRUE_EXTERNAL_GOOGLE_CLIENT_ID=""
export GOTRUE_EXTERNAL_GOOGLE_SECRET=""
export GOTRUE_EXTERNAL_GOOGLE_REDIRECT_URI="${API_EXTERNAL_URL}/callback"
# GitHub OAuth2
export GOTRUE_EXTERNAL_GITHUB_ENABLED="false"
export GOTRUE_EXTERNAL_GITHUB_CLIENT_ID=""
export GOTRUE_EXTERNAL_GITHUB_SECRET=""
export GOTRUE_EXTERNAL_GITHUB_REDIRECT_URI="${API_EXTERNAL_URL}/callback"
# Discord OAuth2
export GOTRUE_EXTERNAL_DISCORD_ENABLED="false"
export GOTRUE_EXTERNAL_DISCORD_CLIENT_ID=""
export GOTRUE_EXTERNAL_DISCORD_SECRET=""
export GOTRUE_EXTERNAL_DISCORD_REDIRECT_URI="${API_EXTERNAL_URL}/callback"
# Apple OAuth2
export GOTRUE_EXTERNAL_APPLE_ENABLED="false"
export GOTRUE_EXTERNAL_APPLE_CLIENT_ID=""
export GOTRUE_EXTERNAL_APPLE_SECRET=""
export GOTRUE_EXTERNAL_APPLE_REDIRECT_URI="${API_EXTERNAL_URL}/callback"

# File Storage
# Create the bucket if not exists on AppFlowy Cloud start up.
# Set this to false if the bucket has been created externally.
export APPFLOWY_S3_CREATE_BUCKET="true"
# This is where storage like images, files, etc. will be stored.
# By default, Minio is used as the default file storage which uses host's file system.
# Keep this as true if you are using other S3 compatible storage provider other than AWS.
export APPFLOWY_S3_USE_MINIO="true"
export APPFLOWY_S3_MINIO_URL="http://${MINIO_HOST}:${MINIO_PORT}" # change this if you are using a different address for minio
export APPFLOWY_S3_ACCESS_KEY="${AWS_ACCESS_KEY}"
export APPFLOWY_S3_SECRET_KEY="${AWS_SECRET}"
export APPFLOWY_S3_BUCKET="appflowy"
# Uncomment this if you are using AWS S3
# APPFLOWY_S3_REGION="us-east-1"
# Uncomment this if you are using the Minio service hosted within this docker compose file
# This is so that, the presigned URL generated by AppFlowy Cloud will use the publicly availabe minio endpoint.
# APPFLOWY_S3_PRESIGNED_URL_ENDPOINT="${APPFLOWY_BASE_URL}/minio-api"

# AppFlowy Cloud Mailer
# Note that smtps (TLS) is always required, even for ports other than 465
export APPFLOWY_MAILER_SMTP_HOST="smtp.gmail.com"
export APPFLOWY_MAILER_SMTP_PORT="465"
export APPFLOWY_MAILER_SMTP_USERNAME="email_sender@some_company.com"
export APPFLOWY_MAILER_SMTP_EMAIL="email_sender@some_company.com"
export APPFLOWY_MAILER_SMTP_PASSWORD="email_sender_password"
export APPFLOWY_MAILER_SMTP_TLS_KIND="wrapper" # "none" "wrapper" "required" "opportunistic"

# Log level for the appflowy-cloud service
export RUST_LOG="info"

# PgAdmin
# Optional module to manage the postgres database
# You can access the pgadmin at http://your-host/pgadmin
# Refer to the APPFLOWY_DATABASE_URL for password when connecting to the database
export PGADMIN_DEFAULT_EMAIL="admin@example.com"
export PGADMIN_DEFAULT_PASSWORD="password"

# Portainer (username: admin)
export PORTAINER_PASSWORD="password1234"

# Cloudflare tunnel token
export CLOUDFLARE_TUNNEL_TOKEN=""

# NGINX
# Optional, change this if you want to use custom ports to expose AppFlowy
export NGINX_PORT="80"
export NGINX_TLS_PORT="443"

# AppFlowy AI
export AI_OPENAI_API_KEY=""
export AI_SERVER_PORT="5001"
export AI_SERVER_HOST="ai"
export AI_DATABASE_URL="postgresql+psycopg://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"
export AI_REDIS_URL="redis://${REDIS_HOST}:${REDIS_PORT}"
export LOCAL_AI_TEST_ENABLED="false"
export AI_APPFLOWY_BUCKET_NAME="${APPFLOWY_S3_BUCKET}"
export AI_APPFLOWY_HOST="${APPFLOWY_BASE_URL}"
export AI_MINIO_URL="http://${MINIO_HOST}:${MINIO_PORT}"

# AppFlowy Indexer
export APPFLOWY_INDEXER_ENABLED="true"
export APPFLOWY_INDEXER_DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"
export APPFLOWY_INDEXER_REDIS_URL="redis://${REDIS_HOST}:${REDIS_PORT}"
export APPFLOWY_INDEXER_EMBEDDING_BUFFER_SIZE="5000"

# AppFlowy Collaborate
export APPFLOWY_COLLABORATE_MULTI_THREAD="false"
export APPFLOWY_COLLABORATE_REMOVE_BATCH_SIZE="100"

# AppFlowy Worker
export APPFLOWY_WORKER_REDIS_URL="redis://${REDIS_HOST}:${REDIS_PORT}"
export APPFLOWY_WORKER_DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"
export APPFLOWY_WORKER_DATABASE_NAME="${POSTGRES_DB}"

# AppFlowy Web
# If your AppFlowy Web is hosted on a different domain, update this variable to the correct domain
export APPFLOWY_WEB_URL="${APPFLOWY_BASE_URL}"
# If you are running AppFlowy Web locally for development purpose, use the following value instead
# APPFLOWY_WEB_URL="http://localhost:3000"