# MONTE CINEMA

 LIVE SITE URL: [MONTE CINEMA](https://monte-cinema-rails-production.up.railway.app/)

## Overview

### Functionalities

- Login and registration
- Authorization for different roles (client and management)
- Internal and external reservation system
- API for communication with automated devices [[DOCUMENTATION]](https://documenter.getpostman.com/view/23736717/2s83znogK8)
- Automatic reservation cancellation and sending confirmation/cancellation mails via internal sidekiq service

## Requirements
- ruby 3.1.2
- rails 7.0.3.1
- postgresql 14.5
- redis

## Setup

```
bundle install
```

### Database creation

```
rails db:create
```

### Database initialization

```
rails db:migrate
```

### Seeds

```
rails db:seed
```

## Services

Sidekiq - job queues for email sending and reservation cancellation




